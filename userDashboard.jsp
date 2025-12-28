<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>
<%
    
    String userName = (String) session.getAttribute("userName");
    

    if(session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }
    
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        .container { width: 800px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        h2 { text-align: center; margin-bottom: 30px; }
        .menu { display: flex; flex-wrap: wrap; justify-content: space-between; }
        .menu a { width: 48%; margin-bottom: 15px; padding: 15px; background: #11998e; color: #fff; text-align: center; text-decoration: none; border-radius: 8px; font-weight: bold; }
        .menu a:hover { background: #0d796a; }
        .logout { text-align: center; margin-top: 20px; }
        .logout a { padding: 8px 15px; background: #e74c3c; color: #fff; text-decoration: none; border-radius: 5px; }
        .logout a:hover { background: #c0392b; }
    </style>
</head>
<body>

<div class="container">
    <h2>Welcome, <%= userName %>!</h2>

    <div class="menu">
        <a href="bookHostel.jsp">Book Hostel</a>
        <a href="roomDetails.jsp">View Booked Room</a>
        <a href="registerComplaint.jsp">Register Complaint</a>
        <a href="viewComplaints.jsp">View Complaint Status</a>
        <a href="giveFeedback.jsp">Give Feedback</a>
        <a href="changePassword.jsp">Change Password</a>
    </div>

    <div class="logout">
        <a href="userLogout.jsp">Logout</a>
    </div>
</div>

</body>
</html>
