<%@ page contentType="text/html;charset=UTF-8" import="java.sql.*,java.util.*,com.traveltourism.model.DBConnection" %>
<%!
private int adminCount(String sql){try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql);ResultSet r=p.executeQuery()){return r.next()?r.getInt(1):0;}catch(Exception e){return 0;}}
%>
<%
Map<String,Integer> stats=new LinkedHashMap<>();
stats.put("tours",adminCount("SELECT COUNT(*) FROM tours"));
stats.put("activeTours",adminCount("SELECT COUNT(*) FROM tours WHERE status='active'"));
stats.put("holidays",adminCount("SELECT COUNT(*) FROM holiday_packages"));
stats.put("activeHolidays",adminCount("SELECT COUNT(*) FROM holiday_packages WHERE active=TRUE"));
stats.put("newEnquiries",adminCount("SELECT COUNT(*) FROM contact_enquiries WHERE archived=FALSE AND status='new'"));
stats.put("openEnquiries",adminCount("SELECT COUNT(*) FROM contact_enquiries WHERE archived=FALSE AND status IN('new','in_progress')"));
stats.put("homePhotos",adminCount("SELECT COUNT(*) FROM homepage_images"));
request.setAttribute("stats",stats);
request.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(request,response);
%>