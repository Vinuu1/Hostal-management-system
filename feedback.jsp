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
    <title>Feedback | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        .container { width: 500px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        h2 { text-align: center; margin-bottom: 20px; }
        textarea { width: 100%; padding: 10px; margin: 10px 0; border-radius: 5px; border:1px solid #ccc; resize: vertical; }
        button { width: 100%; padding: 12px; background: #11998e; color: #fff; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
        button:hover { background: #0d796a; }
        a { display: block; text-align: center; margin-top: 10px; text-decoration: none; color: #11998e; }
        .success { color: green; text-align: center; margin-bottom: 10px; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
    </style>
</head>
<body>

<div class="container">
    <h2>Submit Feedback</h2>

    <% 
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if(msg != null) { %>
            <p class="success"><%= msg %></p>
    <%  } else if(error != null) { %>
            <p class="error"><%= error %></p>
    <% } %>

    <form action="FeedbackServlet" method="post">
        <label for="feedback_text">Enter your feedback:</label>
        <textarea name="feedback_text" id="feedback_text" rows="5" required></textarea>
        <button type="submit">Submit Feedback</button>
    </form>

    <a href="userDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>
