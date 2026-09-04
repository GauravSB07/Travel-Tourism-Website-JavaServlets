package com.traveltourism.model;
import java.sql.*;
import java.util.*;
public final class ContactEnquiryDataAccess {
 private ContactEnquiryDataAccess(){}
 public static long create(Map<String,String> v)throws SQLException{
  String sql="INSERT INTO contact_enquiries(name,email,phone,enquiry_type,preferred_destination,travel_month,travellers,budget_range,message,tour_id,status) VALUES(?,?,?,?,?,?,?,?,?,?,'new')";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
   p.setString(1,v.get("name"));p.setString(2,v.get("email"));p.setString(3,v.get("phone"));p.setString(4,v.get("enquiryType"));p.setString(5,v.get("destination"));p.setString(6,v.get("travelMonth"));
   if(v.get("travellers").isBlank())p.setNull(7,Types.INTEGER);else p.setInt(7,Integer.parseInt(v.get("travellers")));
   p.setString(8,v.get("budget"));p.setString(9,v.get("message"));
   if(v.get("tourId").isBlank())p.setNull(10,Types.INTEGER);else p.setInt(10,Integer.parseInt(v.get("tourId")));
   p.executeUpdate();try(ResultSet r=p.getGeneratedKeys()){return r.next()?r.getLong(1):0;}
  }
 }
 public static List<Map<String,Object>> list(String status,String search,boolean archived)throws SQLException{
  List<Map<String,Object>> rows=new ArrayList<>();
  StringBuilder sql=new StringBuilder("SELECT * FROM contact_enquiries WHERE archived=?");List<String> args=new ArrayList<>();
  if(status!=null&&!status.isBlank()&&!status.equals("all")){sql.append(" AND status=?");args.add(status);}
  if(search!=null&&!search.isBlank()){sql.append(" AND (name LIKE ? OR email LIKE ? OR phone LIKE ? OR preferred_destination LIKE ?)");String q="%"+search.trim()+"%";for(int i=0;i<4;i++)args.add(q);}
  sql.append(" ORDER BY CASE status WHEN 'new' THEN 0 WHEN 'in_progress' THEN 1 WHEN 'responded' THEN 2 ELSE 3 END, created_at DESC");
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql.toString())){int i=1;p.setBoolean(i++,archived);for(String a:args)p.setString(i++,a);try(ResultSet r=p.executeQuery()){while(r.next())rows.add(row(r));}}
  return rows;
 }
 public static Map<String,Object> find(long id)throws SQLException{
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("SELECT * FROM contact_enquiries WHERE id=?")){p.setLong(1,id);try(ResultSet r=p.executeQuery()){return r.next()?row(r):null;}}
 }
 public static void update(long id,String status,String notes,java.sql.Date followUp,boolean archived)throws SQLException{
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("UPDATE contact_enquiries SET status=?,admin_notes=?,follow_up_date=?,archived=? WHERE id=?")){p.setString(1,status);p.setString(2,notes);if(followUp==null)p.setNull(3,Types.DATE);else p.setDate(3,followUp);p.setBoolean(4,archived);p.setLong(5,id);p.executeUpdate();}
 }
 public static boolean deleteArchived(long id)throws SQLException{
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("DELETE FROM contact_enquiries WHERE id=? AND archived=TRUE")){p.setLong(1,id);return p.executeUpdate()==1;}
 }
 public static Map<String,Integer> counts()throws SQLException{
  Map<String,Integer> out=new LinkedHashMap<>();out.put("new",0);out.put("in_progress",0);out.put("responded",0);out.put("closed",0);
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("SELECT status,COUNT(*) total FROM contact_enquiries WHERE archived=FALSE GROUP BY status");ResultSet r=p.executeQuery()){while(r.next())out.put(r.getString(1),r.getInt(2));}return out;
 }
 private static Map<String,Object> row(ResultSet r)throws SQLException{
  Map<String,Object> m=new LinkedHashMap<>();for(String k:new String[]{"id","name","email","phone","enquiry_type","preferred_destination","travel_month","travellers","budget_range","message","tour_id","status","admin_notes","follow_up_date","created_at","updated_at","archived"})m.put(k,r.getObject(k));return m;
 }
}