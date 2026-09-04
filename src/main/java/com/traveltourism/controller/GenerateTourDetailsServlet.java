package com.traveltourism.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/admin/generate-details")
public class GenerateTourDetailsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String apiKey = System.getenv("GEMINI_API_KEY");
        if (apiKey == null || apiKey.trim().isEmpty()) {
            response.setStatus(500);
            response.getWriter().write("{\"error\": \"GEMINI_API_KEY environment variable not set.\"}");
            return;
        }

        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        // Very basic extraction of title parameter since we expect {"title": "..."}
        String body = sb.toString();
        String title = "";
        if (body.contains("\"title\"")) {
            int start = body.indexOf("\"title\"") + 7;
            start = body.indexOf("\"", start) + 1;
            int end = body.indexOf("\"", start);
            if (start > 0 && end > start) {
                title = body.substring(start, end);
            }
        }

        if (title.trim().isEmpty()) {
            response.setStatus(400);
            response.getWriter().write("{\"error\": \"Title is required.\"}");
            return;
        }

        String prompt = "You are a travel package expert. Please generate realistic details for a tour named '" + title + "'. " +
                "Return ONLY a valid JSON object without markdown formatting, containing strictly these keys: " +
                "\"category\" (string, e.g. 'Nature', 'Family', 'Adventure'), " +
                "\"departureCity\" (string), " +
                "\"duration\" (integer, number of days), " +
                "\"price\" (integer, a realistic price in INR), " +
                "\"shortDescription\" (string, 1-2 sentences), " +
                "\"longDescription\" (string, MUST BE AT LEAST 250 CHARACTERS long, an engaging detailed description), " +
                "\"highlights\" (string), " +
                "\"inclusions\" (string), " +
                "\"exclusions\" (string), " +
                "\"bestTime\" (string), " +
                "\"durationText\" (string, e.g., '5 Days / 4 Nights'), " +
                "\"statesCovered\" (string), " +
                "\"citiesCovered\" (string), " +
                "\"route\" (string), " +
                "\"preparation\" (string), " +
                "\"paymentTerms\" (string), " +
                "\"upgradesInfo\" (string). " +
                "Do not include any code blocks, just raw JSON that can be parsed by JSON.parse().";

        // Escape quotes and newlines in prompt
        prompt = prompt.replace("\"", "\\\"");

        String requestBody = "{\n" +
                "  \"contents\": [{\n" +
                "    \"parts\":[{\"text\": \"" + prompt + "\"}]\n" +
                "  }]\n" +
                "}";

        try {
            URL url = new URL("https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent?key=" + apiKey);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(requestBody.getBytes("UTF-8"));
            }

            int responseCode = conn.getResponseCode();
            
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuilder geminiResponse = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    geminiResponse.append(inputLine);
                }
                in.close();
                response.getWriter().write(geminiResponse.toString());
            } else {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
                String inputLine;
                StringBuilder geminiResponse = new StringBuilder();
                while ((inputLine = in.readLine()) != null) {
                    geminiResponse.append(inputLine);
                }
                in.close();
                response.setStatus(500);
                response.getWriter().write("{\"error\": \"Gemini request failed\", \"details\": " + geminiResponse.toString() + "}");
            }
        } catch (Exception e) {
            response.setStatus(500);
            e.printStackTrace();
            response.getWriter().write("{\"error\": \"Exception occurred: " + e.getMessage() + "\"}");
        }
    }
}
