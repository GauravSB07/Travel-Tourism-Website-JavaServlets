<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <%@ include file="common/header.jsp" %>
        <h1>Tour Details</h1>
        <p>Tour details will appear here based on tourId.</p>
        <%@ include file="common/footer.jsp" %>
    </body>
</html>