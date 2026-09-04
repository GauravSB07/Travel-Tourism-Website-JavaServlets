package com.traveltourism.controller;

import com.traveltourism.model.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.*;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

@WebServlet(urlPatterns={"/holiday-image", "/admin/holiday-image"})
@MultipartConfig(maxFileSize=5*1024*1024, maxRequestSize=6*1024*1024)
public class HolidayImageServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id=req.getParameter("id");
        if (id == null || !id.matches("[A-Za-z0-9_-]{1,80}")) { res.sendError(400); return; }
        res.setHeader("X-Content-Type-Options","nosniff");
        res.setHeader("Cache-Control","no-cache");
        try (Connection con=DBConnection.getConnection();
             PreparedStatement ps=con.prepareStatement("SELECT image_data,mime_type FROM holiday_images WHERE holiday_id=?")) {
            ps.setString(1,id);
            try(ResultSet rs=ps.executeQuery()) {
                if(rs.next()) {
                    String type=rs.getString("mime_type");
                    if ("image/jpeg".equals(type) || "image/png".equals(type)) {
                        byte[] data=rs.getBytes("image_data");
                        if(data != null && data.length>0) {
                            res.setContentType(type); res.setContentLength(data.length);
                            res.getOutputStream().write(data); return;
                        }
                    }
                }
            }
        } catch(SQLException e) {
            // Older databases remain usable until the user runs the image-table SQL.
            if(e.getErrorCode()!=1146) log("Holiday photo unavailable",e);
        }
        res.setContentType("image/svg+xml");
        try(InputStream fallback=getServletContext().getResourceAsStream("/images/holiday-cover-placeholder.svg")) {
            if(fallback==null) { res.sendError(404); return; }
            fallback.transferTo(res.getOutputStream());
        }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        if (!req.getServletPath().startsWith("/admin/")) { res.sendError(405); return; }
        req.setCharacterEncoding("UTF-8");
        try {
            HttpSession session=req.getSession(false);
            String csrf=req.getParameter("csrf");
            if(session==null || csrf==null || !csrf.equals(session.getAttribute("holidayCsrf"))) {
                res.sendError(403,"Reload the holiday editor and try again."); return;
            }
            String id=req.getParameter("id");
            if(id==null || !id.matches("[A-Za-z0-9_-]{1,80}")) { res.sendError(400); return; }
            String notice;
            try {
                String action=req.getParameter("action");
                if("remove".equals(action)) {
                    try(Connection con=DBConnection.getConnection();
                        PreparedStatement ps=con.prepareStatement("DELETE FROM holiday_images WHERE holiday_id=?")) {
                        ps.setString(1,id); ps.executeUpdate();
                    }
                    notice="Cover photo removed.";
                } else if ("upload".equals(action)) {
                    Part photo=req.getPart("photo");
                    if(photo==null || photo.getSize()==0 || photo.getSize()>5*1024*1024)
                        throw new IllegalArgumentException("Choose a JPEG or PNG photo up to 5 MB.");
                    byte[] bytes;
                    try(InputStream in=photo.getInputStream()) { bytes=in.readAllBytes(); }
                    String type=validateImage(bytes);
                    try(Connection con=DBConnection.getConnection();
                        PreparedStatement ps=con.prepareStatement(
                            "INSERT INTO holiday_images (holiday_id,image_data,mime_type) SELECT id,?,? FROM holiday_packages WHERE id=? "
                            + "ON DUPLICATE KEY UPDATE image_data=VALUES(image_data),mime_type=VALUES(mime_type)")) {
                        ps.setBytes(1,bytes); ps.setString(2,type); ps.setString(3,id);
                        if(ps.executeUpdate()==0) {
                            try(PreparedStatement exists=con.prepareStatement("SELECT id FROM holiday_packages WHERE id=?")) {
                                exists.setString(1,id);
                                try(ResultSet row=exists.executeQuery()) {
                                    if(!row.next()) throw new IllegalArgumentException("Save the holiday package before uploading a photo.");
                                }
                            }
                        }
                    }
                    notice="Cover photo saved. It now appears on the holiday listing and details page.";
                } else throw new IllegalArgumentException("Unknown photo action.");
            } catch(IllegalArgumentException e) {
                notice=e.getMessage();
            } catch(SQLException e) {
                log("Holiday photo save failed",e);
                notice=e.getErrorCode()==1146
                    ? "Image storage is not set up yet. Run database/holiday_images.sql in your existing database, then upload again."
                    : "The photo could not be saved. Please try again.";
            }
            session.setAttribute("holidayNotice",notice);
            res.sendRedirect(req.getContextPath()+"/admin/holidays?id="+URLEncoder.encode(id,StandardCharsets.UTF_8)+"#cover-photo");
        } catch(IllegalStateException e) {
            res.sendError(413,"Photo too large. Choose a JPEG or PNG file up to 5 MB.");
        }
    }

    static String validateImage(byte[] bytes) {
        try(ImageInputStream input=ImageIO.createImageInputStream(new ByteArrayInputStream(bytes))) {
            Iterator<ImageReader> readers=ImageIO.getImageReaders(input);
            if(!readers.hasNext()) throw new IllegalArgumentException("The selected file is not a valid JPEG or PNG photo.");
            ImageReader reader=readers.next();
            try {
                reader.setInput(input,true,true);
                String format=reader.getFormatName().toLowerCase(Locale.ROOT);
                if(!Set.of("jpeg","jpg","png").contains(format))
                    throw new IllegalArgumentException("Only JPEG and PNG photos are supported.");
                int width=reader.getWidth(0),height=reader.getHeight(0);
                if(width<1 || height<1 || (long)width*height>24000000)
                    throw new IllegalArgumentException("Choose an image with at most 24 million pixels.");
                if(reader.read(0)==null) throw new IllegalArgumentException("The photo could not be read.");
                return format.equals("png") ? "image/png" : "image/jpeg";
            } finally { reader.dispose(); }
        } catch(IOException e) {
            throw new IllegalArgumentException("The photo is damaged or unreadable. Try another JPEG or PNG.");
        }
    }
}
