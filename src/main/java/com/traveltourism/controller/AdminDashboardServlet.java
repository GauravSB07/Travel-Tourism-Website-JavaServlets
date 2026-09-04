package com.traveltourism.controller;
import com.traveltourism.model.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;
@WebServlet(urlPatterns={"/admin","/admin/"})
public class AdminDashboardServlet extends HttpServlet {
 protected void doGet(HttpServletRequest req,HttpServletResponse res)throws ServletException,IOException{
  Map<String,Integer> stats=new LinkedHashMap<>();stats.put("tours",count("SELECT COUNT(*) FROM tours"));stats.put("activeTours",count("SELECT COUNT(*) FROM tours WHERE status='active'"));stats.put("holidays",count("SELECT COUNT(*) FROM holiday_packages"));stats.put("activeHolidays",count("SELECT COUNT(*) FROM holiday_packages WHERE active=TRUE"));stats.put("newEnquiries",count("SELECT COUNT(*) FROM contact_enquiries WHERE archived=FALSE AND status='new'"));stats.put("openEnquiries",count("SELECT COUNT(*) FROM contact_enquiries WHERE archived=FALSE AND status IN('new','in_progress')"));stats.put("homePhotos",count("SELECT COUNT(*) FROM homepage_images"));req.setAttribute("stats",stats);req.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(req,res);
 }
 private int count(String sql){try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql);ResultSet r=p.executeQuery()){return r.next()?r.getInt(1):0;}catch(Exception e){return 0;}}
}