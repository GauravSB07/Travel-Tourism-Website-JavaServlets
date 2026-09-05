package com.traveltourism.controller;
import com.traveltourism.model.HomepageDataAccess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.*;
@WebServlet("/admin/homepage")
public class AdminHomepageServlet extends HttpServlet {
 private static final Set<String> KEYS=HomepageDataAccess.defaults().keySet();
 protected void doGet(HttpServletRequest req,HttpServletResponse res)throws ServletException,IOException{
  HttpSession s=req.getSession();if(s.getAttribute("homepageCsrf")==null){byte[] b=new byte[24];new SecureRandom().nextBytes(b);s.setAttribute("homepageCsrf",Base64.getUrlEncoder().withoutPadding().encodeToString(b));}
  Object n=s.getAttribute("homepageNotice");if(n!=null){req.setAttribute("notice",n);s.removeAttribute("homepageNotice");}
  req.setAttribute("content",HomepageDataAccess.load());req.getRequestDispatcher("/WEB-INF/admin/homepage.jsp").forward(req,res);
 }
 protected void doPost(HttpServletRequest req,HttpServletResponse res)throws IOException{
  req.setCharacterEncoding("UTF-8");HttpSession s=req.getSession(false);if(s==null||req.getParameter("csrf")==null||!req.getParameter("csrf").equals(s.getAttribute("homepageCsrf"))){res.sendError(403);return;}
  Map<String,String> values=new LinkedHashMap<>();
  try{for(String key:KEYS){String v=Optional.ofNullable(req.getParameter(key)).orElse("").trim();int max=key.endsWith("description")?700:120;if(v.isEmpty()||v.length()>max)throw new IllegalArgumentException("Complete every field. Descriptions may use 700 characters and other fields 120.");values.put(key,v);}HomepageDataAccess.save(values);s.setAttribute("homepageNotice","Homepage wording saved.");}
  catch(IllegalArgumentException e){s.setAttribute("homepageNotice",e.getMessage());}catch(SQLException e){log("Homepage save failed",e);s.setAttribute("homepageNotice",e.getErrorCode()==1146?"Homepage storage is not installed yet. Run database/homepage_content.sql in your existing database.":"The homepage could not be saved.");}
  res.sendRedirect(req.getContextPath()+"/admin/homepage");
 }
}