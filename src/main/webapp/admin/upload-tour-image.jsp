<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Upload Tour Image</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 40px;
        }

        .upload-container {
            width: 500px;
            max-width: 100%;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
        }

        h1 {
            margin-top: 0;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="number"],
        input[type="file"] {
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
        }

        .cover-option {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .cover-option label {
            margin: 0;
            font-weight: normal;
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            background: #222;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #444;
        }

        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            background: #eee;
        }

    </style>

</head>

<body>

<div class="upload-container">

    <h1>Upload Tour Image</h1>

    <%
        String message = request.getParameter("message");

        if (message != null) {
    %>

        <div class="message">
            <%= message %>
        </div>

    <%
        }
    %>

    <form action="${pageContext.request.contextPath}/upload-tour-image"
          method="post"
          enctype="multipart/form-data">

        <div class="form-group">

            <label for="tourId">
                Tour ID
            </label>

            <input type="number"
                   id="tourId"
                   name="tourId"
                   min="1"
                   required>

        </div>


        <div class="form-group">

            <label for="image">
                Select Image
            </label>

            <input type="file"
                   id="image"
                   name="image"
                   accept="image/jpeg,image/png,image/webp,image/gif"
                   required>

        </div>


        <div class="form-group cover-option">

            <input type="checkbox"
                   id="isCover"
                   name="isCover"
                   value="true">

            <label for="isCover">
                Make this the cover image
            </label>

        </div>


        <button type="submit">
            Upload Image
        </button>

    </form>

</div>

</body>

</html>