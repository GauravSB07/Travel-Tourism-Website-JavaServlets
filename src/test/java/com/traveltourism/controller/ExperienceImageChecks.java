package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.WriteListener;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class ExperienceImageChecks {
    public static void main(String[] args) throws Exception {
        System.out.println("1. Verifying experience images in Aiven MySQL database...");
        String sql = "SELECT id, title, mime_type, LENGTH(image_data) as img_len FROM experiences WHERE id BETWEEN 1 AND 12 ORDER BY id ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            int count = 0;
            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String mimeType = rs.getString("mime_type");
                int len = rs.getInt("img_len");
                
                if (len <= 0) {
                    throw new AssertionError("Image data missing or 0 bytes for experience ID " + id);
                }
                if (!"image/jpeg".equals(mimeType)) {
                    throw new AssertionError("Unexpected mime type " + mimeType + " for experience ID " + id);
                }
                System.out.println("  ✓ Verified ID " + id + " (" + title + "): " + len + " bytes, " + mimeType);
                count++;
            }
            if (count != 12) {
                throw new AssertionError("Expected 12 experiences with image data, found " + count);
            }
        }

        System.out.println("2. Testing ExperienceImageServlet doGet execution with ID=1...");
        ExperienceImageServlet servlet = new ExperienceImageServlet();
        
        ByteArrayOutputStream responseBytes = new ByteArrayOutputStream();
        Map<String, Object> headers = new HashMap<>();

        ServletOutputStream sos = new ServletOutputStream() {
            @Override
            public boolean isReady() { return true; }
            @Override
            public void setWriteListener(WriteListener writeListener) {}
            @Override
            public void write(int b) { responseBytes.write(b); }
            @Override
            public void write(byte[] b, int off, int len) { responseBytes.write(b, off, len); }
        };

        HttpServletRequest req = (HttpServletRequest) Proxy.newProxyInstance(
                HttpServletRequest.class.getClassLoader(),
                new Class<?>[]{HttpServletRequest.class},
                (proxy, method, methodArgs) -> {
                    if ("getParameter".equals(method.getName()) && "id".equals(methodArgs[0])) {
                        return "1";
                    }
                    return null;
                }
        );

        HttpServletResponse res = (HttpServletResponse) Proxy.newProxyInstance(
                HttpServletResponse.class.getClassLoader(),
                new Class<?>[]{HttpServletResponse.class},
                (proxy, method, methodArgs) -> {
                    if ("getOutputStream".equals(method.getName())) return sos;
                    if ("setContentType".equals(method.getName())) headers.put("Content-Type", methodArgs[0]);
                    if ("setContentLength".equals(method.getName())) headers.put("Content-Length", methodArgs[0]);
                    if ("setHeader".equals(method.getName())) headers.put(String.valueOf(methodArgs[0]), methodArgs[1]);
                    if ("isCommitted".equals(method.getName())) return false;
                    return null;
                }
        );

        servlet.doGet(req, res);

        if (!"image/jpeg".equals(headers.get("Content-Type"))) {
            throw new AssertionError("Expected image/jpeg content-type, got: " + headers.get("Content-Type"));
        }
        if (responseBytes.size() != 968964) {
            throw new AssertionError("Expected 968964 bytes, got: " + responseBytes.size());
        }

        System.out.println("  ✓ ExperienceImageServlet successfully streamed " + responseBytes.size() + " bytes with type " + headers.get("Content-Type"));
        System.out.println("ALL CHECKS PASSED: Images are served directly from Aiven DB without needing local files!");
    }
}
