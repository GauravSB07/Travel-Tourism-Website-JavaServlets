package com.traveltourism.controller;
import com.traveltourism.model.ContactEnquiryDataAccess;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.*;
import java.util.*;
@WebServlet("/admin/enquiries")
public class AdminEnquiryServlet extends HttpServlet {
 private static final Set<String> STATUSES=Set.of("new","in_progress","responded","closed");
 protected void doGet(HttpServletRequest req,HttpServletResponse res)throws ServletException,IOException{
  HttpSession s=req.getSession();if(s.getAttribute("enquiryCsrf")==null){byte[] b=new byte[24];new SecureRandom().nextBytes(b);s.setAttribute("enquiryCsrf",Base64.getUrlEncoder().withoutPadding().encodeToString(b));}
  Object notice=s.getAttribute("enquiryNotice");if(notice!=null){req.setAttribute("notice",notice);s.removeAttribute("enquiryNotice");}
  String status=Optional.ofNullable(req.getParameter("status")).orElse("all"),search=Optional.ofNullable(req.getParameter("q")).orElse("");boolean archived="true".equals(req.getParameter("archived"));
  try{List<Map<String,Object>> rows=ContactEnquiryDataAccess.list(status,search,archived);req.setAttribute("enquiries",rows);req.setAttribute("counts",ContactEnquiryDataAccess.counts());long id=parse(req.getParameter("id"));Map<String,Object> selected=id>0?ContactEnquiryDataAccess.find(id):(rows.isEmpty()?null:rows.get(0));req.setAttribute("selected",selected);}
  catch(SQLException e){log("Enquiry inbox load failed",e);req.setAttribute("loadError",e.getErrorCode()==1146?"Enquiry storage is not installed. Run database/contact_enquiries.sql in your existing database.":"The enquiry inbox could not be loaded.");req.setAttribute("enquiries",Collections.emptyList());req.setAttribute("counts",Collections.emptyMap());}
  req.setAttribute("filterStatus",status);req.setAttribute("search",search);req.setAttribute("showArchived",archived);req.getRequestDispatcher("/WEB-INF/admin/enquiries.jsp").forward(req,res);
 }
 protected void doPost(HttpServletRequest req,HttpServletResponse res)throws IOException{
  req.setCharacterEncoding("UTF-8");HttpSession s=req.getSession(false);if(s==null||req.getParameter("csrf")==null||!req.getParameter("csrf").equals(s.getAttribute("enquiryCsrf"))){res.sendError(403);return;}
  long id=parse(req.getParameter("id"));if("delete".equals(req.getParameter("action"))){try{if(id<1||!ContactEnquiryDataAccess.deleteArchived(id))throw new IllegalArgumentException();s.setAttribute("enquiryNotice","Archived enquiry permanently deleted.");}catch(Exception e){s.setAttribute("enquiryNotice","Only an archived enquiry can be permanently deleted.");}res.sendRedirect(req.getContextPath()+"/admin/enquiries?archived=true");return;}String status=req.getParameter("status"),notes=Optional.ofNullable(req.getParameter("adminNotes")).orElse("").trim(),date=Optional.ofNullable(req.getParameter("followUpDate")).orElse("").trim();String archiveAction=req.getParameter("archiveAction");boolean archived="archive".equals(archiveAction)||(!"restore".equals(archiveAction)&&"true".equals(req.getParameter("currentArchived")));
  try{if(id<1||!STATUSES.contains(status)||notes.length()>3000)throw new IllegalArgumentException("Check the enquiry status and internal notes.");java.sql.Date follow=date.isBlank()?null:java.sql.Date.valueOf(date);ContactEnquiryDataAccess.update(id,status,notes,follow,archived);s.setAttribute("enquiryNotice",archived?"Enquiry archived.":"Enquiry workflow updated.");}
  catch(IllegalArgumentException e){s.setAttribute("enquiryNotice","The update could not be saved. Check the follow-up date and fields.");}catch(SQLException e){log("Enquiry update failed",e);s.setAttribute("enquiryNotice","The enquiry could not be updated.");}
  res.sendRedirect(req.getContextPath()+"/admin/enquiries"+(archived?"?archived=true":"?id="+id));
 }
 private static long parse(String v){try{return Long.parseLong(v);}catch(Exception e){return 0;}}
}