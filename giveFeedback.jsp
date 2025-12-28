<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>

<%
    // Ensure the user is logged in
    if(session == null || session.getAttribute("userId") == null){
        response.sendRedirect("userLogin.jsp");
        return;
    }

    int userId = Integer.parseInt(session.getAttribute("userId").toString());
    String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Feedback | Hostel Management System</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(to right, #00b09b, #96c93d); margin: 0; padding: 0; }
        .container { width: 450px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        h2 { color: #11998e; text-align: center; margin-bottom: 20px; }
        textarea { width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #ccc; margin-bottom: 15px; font-size: 15px; }
        button { width: 100%; padding: 12px; background: #11998e; border: none; color: #fff; border-radius: 8px; cursor: pointer; font-weight: bold; }
        button:hover { background: #0d796a; }
        a { display: block; text-align: center; margin-top: 15px; color: #11998e; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .success { color: green; text-align: center; margin-bottom: 10px; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Hello, <%= userName %>!</h2>
    <h3 style="text-align:center;">Submit Your Feedback</h3>

    <% 
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if(msg != null){ %>
            <p class="success"><%= msg %></p>
    <%  } else if(error != null){ %>
            <p class="error"><%= error %></p>
    <% } %>

    <form action="FeedbackServlet" method="post">
        <input type="hidden" name="student_id" value="<%= userId %>">
        <textarea name="feedback_text" rows="5" placeholder="Enter your feedback..." required></textarea>
        <button type="submit">Submit Feedback</button>
    </form>

    <a href="userDashboard.jsp">Back to Dashboard</a>
</div>
</body>
</html>
