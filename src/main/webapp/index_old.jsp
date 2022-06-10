<%--
  Created by IntelliJ IDEA.
  User: DavidWang
  Date: 2022-06-06
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<jsp:forward page="/emps"></jsp:forward>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

    <button class="btn-success">button</button>

</body>
</html>
