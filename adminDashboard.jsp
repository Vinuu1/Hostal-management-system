<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>
<%
String userName = (String) session.getAttribute("userName");


    if(session == null || session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("adminName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        header { background: #11998e; color: #fff; padding: 15px; text-align: center; }
        .container { width: 80%; margin: 30px auto; }
        .card { background: #fff; padding: 20px; margin: 15px 0; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .card h3 { margin: 0 0 10px 0; }
        a.btn { display: inline-block; padding: 10px 20px; background: #11998e; color: #fff; text-decoration: none; border-radius: 5px; margin: 5px; }
        a.btn:hover { background: #0d796a; }
    </style>
</head>
<body>

<header>
    <h1>Welcome, <%= adminName %>!</h1>
    <a href="LogoutServlet" style="color: #fff; float: right; margin-right: 20px;">Logout</a>
</header>

<div class="container">
    <div class="card">
        <h3>Manage Courses</h3>
        <a href="manageCourses.jsp" class="btn">Go</a>
    </div>

    <div class="card">
        <h3>Manage Rooms</h3>
        <a href="manageRooms.jsp" class="btn">Go</a>
    </div>

    <div class="card">
        <h3>Manage Students</h3>
        <a href="manageStudents.jsp" class="btn">Go</a>
    </div>

    <div class="card">
        <h3>Manage Complaints</h3>
        <a href="manageComplaints.jsp" class="btn">Go</a>
    </div>

    <div class="card">
        <h3>View Feedback</h3>
        <a href="viewFeedbackAdmin.jsp" class="btn">Go</a>
    </div>
</div>

</body>
</html>
