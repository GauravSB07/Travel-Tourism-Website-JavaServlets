package com.traveltourism.controller;
import com.traveltourism.model.ContactEnquiryDataAccess;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.*;
import java.util.regex.Pattern;
@WebServlet("/contact")
public class Contact_usServlet extends HttpServlet {
 private static final long serialVersionUID=1L;
 private static final Pattern EMAIL=Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
 protected void doGet(HttpServletRequest req,HttpServletResponse res)throws ServletException,IOException{
  HttpSession s=req.getSession();if(s.getAttribute("contactCsrf")==null){byte[] b=new byte[24];new SecureRandom().nextBytes(b);s.setAttribute("contactCsrf",Base64.getUrlEncoder().withoutPadding().encodeToString(b));}
  for(String key:new String[]{"contactSuccess","contactError","contactDraft"}){Object v=s.getAttribute(key);if(v!=null){req.setAttribute(key,v);s.removeAttribute(key);}}
  req.getRequestDispatcher("/contact_us.jsp").forward(req,res);
 }
 protected void doPost(HttpServletRequest req,HttpServletResponse res)throws IOException{
  req.setCharacterEncoding("UTF-8");HttpSession s=req.getSession();
  if(req.getParameter("csrf")==null||!req.getParameter("csrf").equals(s.getAttribute("contactCsrf"))){res.sendError(403,"Reload the contact page and try again.");return;}
  Map<String,String> v=new LinkedHashMap<>();for(String key:new String[]{"name","email","phone","enquiryType","destination","travelMonth","travellers","budget","message","tourId"})v.put(key,Optional.ofNullable(req.getParameter(key)).orElse("").trim());
  try{
   check(v.get("name"),2,120,"Enter your full name.");if(!EMAIL.matcher(v.get("email")).matches()||v.get("email").length()>254)throw new IllegalArgumentException("Enter a valid email address.");check(v.get("phone"),7,30,"Enter a valid phone number.");
   if(!Set.of("general","destination","customized_holiday","existing_booking").contains(v.get("enquiryType")))throw new IllegalArgumentException("Choose how we can help.");
   if(v.get("destination").length()>120||v.get("travelMonth").length()>20||v.get("budget").length()>40)throw new IllegalArgumentException("One of the planning details is too long.");
   if(!v.get("travellers").isBlank()){int n=Integer.parseInt(v.get("travellers"));if(n<1||n>50)throw new IllegalArgumentException("Traveller count must be between 1 and 50.");}
   if(!v.get("tourId").isBlank()){int id=Integer.parseInt(v.get("tourId"));if(id<1)throw new NumberFormatException();}
   check(v.get("message"),10,3000,"Tell us a little more about your enquiry.");
   long id=ContactEnquiryDataAccess.create(v);s.setAttribute("contactSuccess","Thank you, "+v.get("name")+". Your enquiry #"+id+" has reached our travel team.");
   s.setAttribute("contactCsrf",null);
  }catch(IllegalArgumentException e){s.setAttribute("contactError",e.getMessage());s.setAttribute("contactDraft",v);}
  catch(SQLException e){log("Contact enquiry save failed",e);s.setAttribute("contactError",e.getErrorCode()==1146?"Contact storage is not ready yet. Please ask the administrator to run database/contact_enquiries.sql.":"We could not save your enquiry right now. Please try again.");s.setAttribute("contactDraft",v);}
  res.sendRedirect(req.getContextPath()+"/contact");
 }
 private static void check(String value,int min,int max,String message){if(value==null||value.length()<min||value.length()>max)throw new IllegalArgumentException(message);}
}