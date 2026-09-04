package com.traveltourism.controller;

import java.lang.reflect.Proxy;
import java.sql.*;
import java.util.*;

/** No database access. Run this main class after Maven test compilation. */
public class AdminHolidayPanelChecks {
    static final class Database {
        final List<String> events = new ArrayList<>();
        final List<Map<Integer,Object>> batches = new ArrayList<>();
        boolean failItinerary, exists = true, autoCommit = true;
        Connection connection() {
            return (Connection) Proxy.newProxyInstance(getClass().getClassLoader(), new Class[]{Connection.class},
                (proxy, method, args) -> {
                    switch (method.getName()) {
                        case "getAutoCommit": return autoCommit;
                        case "setAutoCommit": autoCommit=(boolean)args[0]; return null;
                        case "commit": events.add("commit"); return null;
                        case "rollback": events.add("rollback"); return null;
                        case "prepareStatement": return statement((String)args[0]);
                        default: return null;
                    }
                });
        }
        PreparedStatement statement(String sql) {
            Map<Integer,Object> params = new HashMap<>();
            return (PreparedStatement) Proxy.newProxyInstance(getClass().getClassLoader(), new Class[]{PreparedStatement.class},
                (proxy, method, args) -> {
                    if (method.getName().startsWith("set")) { params.put((Integer)args[0],args[1]); return null; }
                    switch (method.getName()) {
                        case "executeUpdate": events.add(sql); return 1;
                        case "executeQuery":
                            events.add(sql);
                            return Proxy.newProxyInstance(getClass().getClassLoader(), new Class[]{ResultSet.class},
                                (p,m,a) -> "next".equals(m.getName()) ? exists : null);
                        case "addBatch": batches.add(new HashMap<>(params)); return null;
                        case "executeBatch":
                            events.add(sql);
                            if (failItinerary) throw new SQLException("Simulated failed itinerary insert");
                            return new int[]{1,1};
                        default: return null;
                    }
                });
        }
    }
    static Map<String,Object> valid() {
        Map<String,Object> p = new HashMap<>();
        p.put("id","birthday-test"); p.put("name","Birthday getaway");
        p.put("occasion","Birthday"); p.put("departure_city","Mumbai");
        p.put("duration","2"); p.put("price","9999");
        p.put("description","A quiet celebration."); p.put("inclusions","Breakfast");
        p.put("exclusions","Flights"); p.put("source_url",""); p.put("active","0");
        return p;
    }
    static void require(boolean result, String message) { if(!result) throw new AssertionError(message); }
    static void rejected(String field, String value) {
        Map<String,Object> p=valid(); p.put(field,value);
        try { AdminHolidayPanelServlet.validate(p,new ArrayList<>(List.of("Arrive","Depart")));
            throw new AssertionError("Accepted invalid "+field);
        } catch (IllegalArgumentException expected) {}
    }
    public static void main(String[] args) throws Exception {
        List<String> days=new ArrayList<>(List.of("Arrive","Depart"));
        AdminHolidayPanelServlet.validate(valid(),days);
        rejected("duration","0"); rejected("price","-1"); rejected("price","999999999999");
        rejected("occasion",""); rejected("id","bad id");
        rejected("source_url","javascript:alert(1)"); rejected("duration","3");
        Database success=new Database();
        AdminHolidayPanelServlet.save(success.connection(),valid(),days,true);
        require(success.events.contains("commit")&&!success.events.contains("rollback"),"Create must commit");
        require(success.batches.size()==2 && success.batches.get(1).get(2).equals(2),"Sequential itinerary");
        require(success.autoCommit,"Connection state restored");
        Database update=new Database();
        AdminHolidayPanelServlet.save(update.connection(),valid(),days,false);
        require(update.events.get(0).contains("FOR UPDATE"),"Lock existing package before replacement");
        require(update.events.stream().anyMatch(s->s.startsWith("UPDATE holiday_packages")),"Update existing package");
        Database failed=new Database(); failed.failItinerary=true;
        try { AdminHolidayPanelServlet.save(failed.connection(),valid(),days,false);
            throw new AssertionError("Failed itinerary accepted");
        } catch(SQLException expected) {}
        require(failed.events.contains("rollback")&&!failed.events.contains("commit"),"Failure must roll back entire save");
        require(failed.autoCommit,"Failed save restores state");
        Database missing=new Database(); missing.exists=false;
        try { AdminHolidayPanelServlet.save(missing.connection(),valid(),days,false);
            throw new AssertionError("Missing package accepted");
        } catch(IllegalArgumentException expected) {}
        require(missing.events.stream().noneMatch(s->s.startsWith("UPDATE")||s.startsWith("DELETE")),"Missing package must not change data");
        System.out.println("Holiday validation and transaction checks passed (no database used).");
    }
}
