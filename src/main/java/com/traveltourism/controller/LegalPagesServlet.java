package com.traveltourism.controller;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
@WebServlet(urlPatterns={"/privacy-policy","/terms-and-conditions"})
public class LegalPagesServlet extends HttpServlet {
 protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
  String view="/privacy-policy".equals(request.getServletPath())?"/WEB-INF/views/privacy-policy.jsp":"/WEB-INF/views/terms-and-conditions.jsp";
  request.getRequestDispatcher(view).forward(request,response);
 }
}