package com.traveltourism.controller;
import com.traveltourism.model.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Set;
@WebServlet(urlPatterns={"/homepage-image","/admin/homepage-image"})
@MultipartConfig(maxFileSize=5*1024*1024,maxRequestSize=6*1024*1024)
public class HomepageImageServlet extends HttpServlet {
 public static final Set<String>SLOTS=Set.of("hero","goa","kerala","rajasthan","kashmir","himachal","maharashtra","holiday");
 protected void doGet(HttpServletRequest req,HttpServletResponse res)throws IOException{
  String slot=req.getParameter("slot");if(!SLOTS.contains(slot)){res.sendError(400);return;}res.setHeader("X-Content-Type-Options","nosniff");res.setHeader("Cache-Control","no-cache");
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("SELECT image_data,mime_type FROM homepage_images WHERE slot_key=?")){p.setString(1,slot);try(ResultSet r=p.executeQuery()){if(r.next()){String type=r.getString(2);byte[] data=r.getBytes(1);if(("image/jpeg".equals(type)||"image/png".equals(type))&&data!=null&&data.length>0){res.setContentType(type);res.setContentLength(data.length);res.getOutputStream().write(data);return;}}}}catch(SQLException e){if(e.getErrorCode()!=1146)log("Homepage image unavailable",e);}
  res.setContentType("image/svg+xml");try(InputStream in=getServletContext().getResourceAsStream("/images/homepage-placeholder.svg")){if(in==null){res.sendError(404);return;}in.transferTo(res.getOutputStream());}
 }
 protected void doPost(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException{
  if(!req.getServletPath().startsWith("/admin/")){res.sendError(405);return;}HttpSession s=req.getSession(false);if(s==null||req.getParameter("csrf")==null||!req.getParameter("csrf").equals(s.getAttribute("homepageCsrf"))){res.sendError(403);return;}String slot=req.getParameter("slot");if(!SLOTS.contains(slot)){res.sendError(400);return;}String notice;
  try{if("remove".equals(req.getParameter("action"))){try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("DELETE FROM homepage_images WHERE slot_key=?")){p.setString(1,slot);p.executeUpdate();}notice="Homepage photo removed.";}else{Part part=req.getPart("photo");if(part==null||part.getSize()==0||part.getSize()>5L*1024*1024)throw new IllegalArgumentException("Choose a JPEG or PNG photo up to 5 MB.");byte[] data;try(InputStream in=part.getInputStream()){data=in.readAllBytes();}String type=HolidayImageServlet.validateImage(data);try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("INSERT INTO homepage_images(slot_key,image_data,mime_type)VALUES(?,?,?) ON DUPLICATE KEY UPDATE image_data=VALUES(image_data),mime_type=VALUES(mime_type),updated_at=CURRENT_TIMESTAMP")){p.setString(1,slot);p.setBytes(2,data);p.setString(3,type);p.executeUpdate();}notice="Homepage photo saved.";}}
  catch(IllegalArgumentException e){notice=e.getMessage();}catch(SQLException e){log("Homepage image save failed",e);notice=e.getErrorCode()==1146?"Homepage image storage is not installed yet. Run database/homepage_content.sql in your existing database.":"The photo could not be saved.";}s.setAttribute("homepageNotice",notice);res.sendRedirect(req.getContextPath()+"/admin/homepage#photos");
 }
}