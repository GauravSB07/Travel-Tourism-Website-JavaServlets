<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Manage Tour Images | TravelTourism</title>


    <style>

        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            padding: 40px 20px;

            font-family:
                Arial,
                Helvetica,
                sans-serif;

            background: #f5f5f5;

            color: #222;
        }


        .container {

            width: 1100px;

            max-width: 100%;

            margin: 0 auto;
        }


        .page-header {

            background: #ffffff;

            padding: 30px;

            border-radius: 14px;

            box-shadow:
                0 5px 25px rgba(0, 0, 0, 0.08);

            margin-bottom: 25px;
        }


        .page-header h1 {

            margin: 0 0 8px 0;

            font-size: 30px;
        }


        .page-header p {

            margin: 0;

            color: #666;

            line-height: 1.6;
        }


        .message {

            padding: 14px 18px;

            margin-bottom: 20px;

            border-radius: 8px;

            background: #e9f7ef;

            border: 1px solid #b8e0c8;

            color: #216e39;
        }


        .error-message {

            padding: 14px 18px;

            margin-bottom: 20px;

            border-radius: 8px;

            background: #fdecec;

            border: 1px solid #f1b8b8;

            color: #a12626;
        }


        .selector-card {

            background: #ffffff;

            padding: 25px;

            border-radius: 14px;

            box-shadow:
                0 5px 25px rgba(0, 0, 0, 0.08);

            margin-bottom: 25px;
        }


        .selector-card h2 {

            margin-top: 0;

            margin-bottom: 18px;

            font-size: 20px;
        }


        .tour-form {

            display: flex;

            gap: 12px;

            align-items: center;
        }


        .tour-form input {

            width: 220px;

            padding: 12px 14px;

            border: 1px solid #ccc;

            border-radius: 7px;

            font-size: 15px;
        }


        .button {

            display: inline-block;

            padding: 12px 20px;

            border: none;

            border-radius: 7px;

            background: #222;

            color: #fff;

            text-decoration: none;

            cursor: pointer;

            font-size: 15px;
        }


        .button:hover {

            background: #444;
        }


        .button-light {

            background: #eee;

            color: #222;
        }


        .button-light:hover {

            background: #ddd;
        }


        .tour-heading {

            background: #ffffff;

            padding: 22px 25px;

            border-radius: 14px;

            box-shadow:
                0 5px 25px rgba(0, 0, 0, 0.08);

            margin-bottom: 25px;
        }


        .tour-heading h2 {

            margin: 0 0 5px 0;

            font-size: 24px;
        }


        .tour-heading span {

            color: #777;

            font-size: 14px;
        }


        .images-grid {

            display: grid;

            grid-template-columns:
                repeat(3, minmax(0, 1fr));

            gap: 22px;
        }


        .image-card {

            background: #ffffff;

            border-radius: 14px;

            overflow: hidden;

            box-shadow:
                0 5px 25px rgba(0, 0, 0, 0.08);
        }


        .image-wrapper {

            position: relative;

            width: 100%;

            height: 230px;

            background: #eee;

            overflow: hidden;
        }


        .image-wrapper img {

            width: 100%;

            height: 100%;

            display: block;

            object-fit: cover;
        }


        .cover-badge {

            position: absolute;

            top: 12px;

            left: 12px;

            padding: 7px 11px;

            border-radius: 20px;

            background: #222;

            color: #fff;

            font-size: 12px;

            font-weight: bold;
        }


        .image-info {

            padding: 18px;
        }


        .image-name {

            margin: 0 0 8px 0;

            font-weight: bold;

            word-break: break-word;
        }


        .image-id {

            margin: 0 0 15px 0;

            color: #777;

            font-size: 13px;
        }


        .delete-form {

            margin: 0;
        }


        .delete-button {

            width: 100%;

            padding: 11px;

            border: none;

            border-radius: 7px;

            background: #b42318;

            color: #ffffff;

            font-size: 14px;

            cursor: pointer;
        }


        .delete-button:hover {

            background: #8f1c14;
        }


        .empty-state {

            background: #ffffff;

            padding: 50px 30px;

            text-align: center;

            border-radius: 14px;

            box-shadow:
                0 5px 25px rgba(0, 0, 0, 0.08);
        }


        .empty-state h2 {

            margin-top: 0;
        }


        .empty-state p {

            color: #777;

            margin-bottom: 25px;
        }


        .actions {

            display: flex;

            gap: 10px;

            flex-wrap: wrap;

            margin-top: 25px;
        }


        @media (max-width: 800px) {

            .images-grid {

                grid-template-columns:
                    repeat(2, minmax(0, 1fr));
            }
        }


        @media (max-width: 550px) {

            body {

                padding: 20px 12px;
            }


            .images-grid {

                grid-template-columns: 1fr;
            }


            .tour-form {

                flex-direction: column;

                align-items: stretch;
            }


            .tour-form input {

                width: 100%;
            }
        }

    </style>

</head>


<body>


<div class="container">


    <!-- =====================================================
         PAGE HEADER
    ====================================================== -->

    <div class="page-header">

        <h1>Manage Tour Images</h1>

        <p>
            View, inspect and delete images associated
            with your tours.
        </p>

    </div>


    <!-- =====================================================
         MESSAGE
    ====================================================== -->

    <c:if test="${not empty param.message}">

        <div class="message">

            <c:out value="${param.message}" />

        </div>

    </c:if>


    <!-- =====================================================
         ERROR
    ====================================================== -->

    <c:if test="${not empty errorMessage}">

        <div class="error-message">

            <c:out value="${errorMessage}" />

        </div>

    </c:if>


    <!-- =====================================================
         TOUR SELECTOR
    ====================================================== -->

    <div class="selector-card">

        <h2>Select Tour</h2>


        <form
            class="tour-form"
            action="${pageContext.request.contextPath}/manage-tour-images"
            method="get">


            <input
                type="number"
                name="tourId"
                min="1"
                placeholder="Enter Tour ID"
                value="${selectedTourId}"
                required>


            <button
                type="submit"
                class="button">

                View Images

            </button>


        </form>

    </div>


    <!-- =====================================================
         SELECTED TOUR
    ====================================================== -->

    <c:if test="${not empty selectedTourId}">

        <div class="tour-heading">

            <h2>
                <c:out value="${selectedTourName}" />
            </h2>

            <span>
                Tour ID:
                <c:out value="${selectedTourId}" />
            </span>


            <div class="actions">

                <a
                    class="button"
                    href="${pageContext.request.contextPath}/admin/upload-tour-image.jsp">

                    Upload New Image

                </a>


                <a
                    class="button button-light"
                    href="${pageContext.request.contextPath}/manage-tour-images?tourId=${selectedTourId}">

                    Refresh

                </a>

            </div>

        </div>


        <!-- =================================================
             IMAGE LIST
        ================================================== -->

        <c:choose>


            <c:when test="${empty images}">

                <div class="empty-state">

                    <h2>No images found</h2>

                    <p>
                        This tour currently has no images.
                    </p>


                    <a
                        class="button"
                        href="${pageContext.request.contextPath}/admin/upload-tour-image.jsp">

                        Upload First Image

                    </a>

                </div>

            </c:when>


            <c:otherwise>

                <div class="images-grid">


                    <c:forEach
                        var="image"
                        items="${images}">


                        <div class="image-card">


                            <!-- =================================
                                 IMAGE
                            ================================== -->

                            <div class="image-wrapper">


                                <img
                                    src="${pageContext.request.contextPath}/TourImageServlet?id=${image.id}"
                                    alt="<c:out value='${image.originalName}' />">


                                <c:if test="${image.cover}">

                                    <span class="cover-badge">

                                        COVER IMAGE

                                    </span>

                                </c:if>


                            </div>


                            <!-- =================================
                                 IMAGE INFORMATION
                            ================================== -->

                            <div class="image-info">


                                <p class="image-name">

                                    <c:out
                                        value="${image.originalName}" />

                                </p>


                                <p class="image-id">

                                    Image ID:
                                    <c:out
                                        value="${image.id}" />

                                </p>


                                <!-- =================================
                                     DELETE
                                ================================== -->

                                <form
                                    class="delete-form"
                                    action="${pageContext.request.contextPath}/delete-tour-image"
                                    method="post"
                                    onsubmit="return confirmDelete(
                                        ${image.id},
                                        ${image.cover}
                                    );">


                                    <input
                                        type="hidden"
                                        name="imageId"
                                        value="${image.id}">


                                    <button
                                        type="submit"
                                        class="delete-button">

                                        Delete Image

                                    </button>


                                </form>


                            </div>

                        </div>


                    </c:forEach>


                </div>

            </c:otherwise>


        </c:choose>

    </c:if>


</div>


<script>

function confirmDelete(imageId, isCover) {

    if (isCover) {

        return confirm(
            "This image is currently the COVER IMAGE.\n\n" +
            "Deleting it will automatically make another " +
            "image the cover, if one exists.\n\n" +
            "Do you want to continue?"
        );

    }


    return confirm(
        "Are you sure you want to delete Image ID " +
        imageId +
        "?\n\nThis action cannot be undone."
    );
}

</script>


</body>

</html>