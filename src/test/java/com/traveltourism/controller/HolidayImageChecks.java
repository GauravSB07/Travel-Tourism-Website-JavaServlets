package com.traveltourism.controller;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import javax.imageio.ImageIO;
public class HolidayImageChecks {
    private static void reject(byte[] bytes) {
        try { HolidayImageServlet.validateImage(bytes); throw new AssertionError("Invalid file accepted"); }
        catch (IllegalArgumentException expected) {}
    }
    public static void main(String[] args) throws Exception {
        BufferedImage image=new BufferedImage(12,8,BufferedImage.TYPE_INT_RGB);
        for(String format:new String[]{"png","jpeg"}) {
            ByteArrayOutputStream out=new ByteArrayOutputStream();
            ImageIO.write(image,format,out);
            if(!HolidayImageServlet.validateImage(out.toByteArray()).equals("image/"+format))
                throw new AssertionError("Wrong detected MIME type");
        }
        reject("<svg onload='alert(1)'></svg>".getBytes(StandardCharsets.UTF_8));
        reject(new byte[]{1,2,3,4});
        ByteArrayOutputStream gif=new ByteArrayOutputStream(); ImageIO.write(image,"gif",gif);
        reject(gif.toByteArray());
        System.out.println("Holiday image checks passed: JPEG/PNG accepted; SVG, GIF and invalid files rejected.");
    }
}