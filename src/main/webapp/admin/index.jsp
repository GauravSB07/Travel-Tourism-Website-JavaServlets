<%@ page contentType="text/html;charset=UTF-8" import="java.sql.*,java.util.*,com.traveltourism.model.DBConnection" %>
<%!
private int adminCount(Connection connection, String sql) {
    if (connection == null) return 0;
    try (PreparedStatement statement = connection.prepareStatement(sql);
         ResultSet results = statement.executeQuery()) {
        return results.next() ? results.getInt(1) : 0;
    } catch (Exception exception) {
        return 0;
    }
}
%>
<%
Map<String,Integer> stats=new LinkedHashMap<>();
for(String key:new String[]{"tours","activeTours","holidays","activeHolidays","pendingBookings","openBookings","newEnquiries","openEnquiries","homePhotos"}) stats.put(key,0);
try(Connection connection=DBConnection.getConnection()){
    stats.put("tours",adminCount(connection,"SELECT COUNT(*) FROM tours"));
    stats.put("activeTours",adminCount(connection,"SELECT COUNT(*) FROM tours WHERE status='active'"));
    stats.put("holidays",adminCount(connection,"SELECT COUNT(*) FROM holiday_packages"));
    stats.put("activeHolidays",adminCount(connection,"SELECT COUNT(*) FROM holiday_packages WHERE active=TRUE"));
    stats.put("pendingBookings",adminCount(connection,"SELECT COUNT(*) FROM booking_requests WHERE archived=FALSE AND status='pending'"));
    stats.put("openBookings",adminCount(connection,"SELECT COUNT(*) FROM booking_requests WHERE archived=FALSE AND status IN('pending','reviewing')"));
    stats.put("newEnquiries",adminCount(connection,"SELECT COUNT(*) FROM contact_enquiries WHERE archived=FALSE AND status='new'"));
    stats.put("openEnquiries",adminCount(connection,"SELECT COUNT(*) FROM contact_enquiries WHERE archived=FALSE AND status IN('new','in_progress')"));
    stats.put("homePhotos",adminCount(connection,"SELECT COUNT(*) FROM homepage_images"));
}catch(Exception ignored){}
request.setAttribute("stats",stats);
request.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(request,response);
%>
