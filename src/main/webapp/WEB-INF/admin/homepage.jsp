<%@ page contentType="text/html;charset=UTF-8" import="java.util.Map" %>
<%!
private String esc(Object value){if(value==null)return "";return value.toString().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#39;");}
%>
<%
Map<String,String> content=(Map<String,String>)request.getAttribute("content");
String context=request.getContextPath(),csrf=(String)session.getAttribute("homepageCsrf");
String[][] slots={{"hero","Homepage hero","Wide landscape, ideally 1600 × 900"},{"goa","Goa destination card","Landscape, ideally 900 × 600"},{"kerala","Kerala destination card","Landscape, ideally 900 × 600"},{"rajasthan","Rajasthan destination card","Landscape, ideally 900 × 600"},{"kashmir","Kashmir destination card","Landscape, ideally 900 × 600"},{"himachal","Himachal destination card","Landscape, ideally 900 × 600"},{"maharashtra","Maharashtra destination card","Landscape, ideally 900 × 600"},{"holiday","Occasion holidays panel","Portrait or landscape, ideally 1000 × 1200"}};
%>
<!doctype html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Homepage Studio | TravelTourism Admin</title><link rel="stylesheet" href="<%=context%>/css/admin-workspace.css"></head>
<body class="holiday-admin homepage-admin"><% request.setAttribute("adminSection","homepage"); %><%@ include file="/WEB-INF/admin/navigation.jspf" %>
<section class="admin-intro"><div><span class="eyebrow">WEBSITE PRESENTATION</span><h1>Homepage studio</h1><p>Keep the first page polished, current and connected to the experiences you actually offer.</p></div><div class="admin-metrics"><div><strong>8</strong><span>photo positions</span></div><div><strong>3</strong><span>editable stories</span></div></div></section>
<main class="homepage-admin-layout">
<% if(request.getAttribute("notice")!=null){ %><div class="admin-notice"><%=esc(request.getAttribute("notice"))%></div><% } %>
<section class="card homepage-copy-card"><div class="editor-title"><div><span class="eyebrow">WORDS &amp; LINKS</span><h2>Homepage content</h2></div><a class="button" href="<%=context%>/index.jsp" target="_blank" rel="noopener">Preview homepage ↗</a></div>
<form method="post" action="<%=context%>/admin/homepage"><input type="hidden" name="csrf" value="<%=esc(csrf)%>">
<div class="homepage-form-section"><div class="section-heading"><span>01</span><div><h3>Hero introduction</h3><p>The first message visitors see.</p></div></div><div class="form-grid">
<label>Small label<input name="hero_label" maxlength="120" value="<%=esc(content.get("hero_label"))%>" required></label>
<label>Main heading<input name="hero_title" maxlength="120" value="<%=esc(content.get("hero_title"))%>" required></label>
<label>Accent heading<input name="hero_accent" maxlength="120" value="<%=esc(content.get("hero_accent"))%>" required></label>
<label class="full">Introduction<textarea name="hero_description" maxlength="700" required><%=esc(content.get("hero_description"))%></textarea></label></div></div>
<div class="homepage-form-section"><div class="section-heading"><span>02</span><div><h3>Popular destinations</h3><p>Introduce the destination collection shown on the homepage.</p></div></div><div class="form-grid">
<label>Small label<input name="destination_label" maxlength="120" value="<%=esc(content.get("destination_label"))%>" required></label>
<label>Heading<input name="destination_title" maxlength="120" value="<%=esc(content.get("destination_title"))%>" required></label>
<label class="full">Description<textarea name="destination_description" maxlength="700" required><%=esc(content.get("destination_description"))%></textarea></label></div></div>
<div class="homepage-form-section"><div class="section-heading"><span>03</span><div><h3>Customized holidays</h3><p>This now points to occasion-based packages rather than a personalized-holiday builder.</p></div></div><div class="form-grid">
<label>Small label<input name="holiday_label" maxlength="120" value="<%=esc(content.get("holiday_label"))%>" required></label>
<label>Heading<input name="holiday_title" maxlength="120" value="<%=esc(content.get("holiday_title"))%>" required></label>
<label class="full">Description<textarea name="holiday_description" maxlength="700" required><%=esc(content.get("holiday_description"))%></textarea></label>
<label>Button wording<input name="holiday_button" maxlength="120" value="<%=esc(content.get("holiday_button"))%>" required></label></div></div>
<div class="editor-save"><p>Changes appear on the public homepage immediately.</p><button class="button primary" type="submit">Save homepage wording</button></div></form></section>
<section class="card" id="photos"><div class="editor-title"><div><span class="eyebrow">VISUAL LIBRARY</span><h2>Homepage photos</h2></div><p class="muted">JPEG or PNG · up to 5 MB</p></div>
<div class="homepage-photo-grid">
<% for(String[] slot:slots){ %><article class="homepage-photo-card"><img src="<%=context%>/homepage-image?slot=<%=slot[0]%>&v=<%=System.currentTimeMillis()%>" alt="<%=esc(slot[1])%> preview"><div class="homepage-photo-copy"><h3><%=esc(slot[1])%></h3><p><%=esc(slot[2])%></p>
<form method="post" enctype="multipart/form-data" action="<%=context%>/admin/homepage-image"><input type="hidden" name="csrf" value="<%=esc(csrf)%>"><input type="hidden" name="slot" value="<%=slot[0]%>"><input type="file" name="photo" accept="image/jpeg,image/png" required><button class="button primary" type="submit">Upload / replace</button></form>
<form method="post" action="<%=context%>/admin/homepage-image"><input type="hidden" name="csrf" value="<%=esc(csrf)%>"><input type="hidden" name="slot" value="<%=slot[0]%>"><input type="hidden" name="action" value="remove"><button class="button" type="submit">Remove photo</button></form></div></article><% } %>
</div></section></main></body></html>