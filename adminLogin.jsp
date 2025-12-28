<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        .container { width: 400px; margin: 100px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        h2 { text-align: center; margin-bottom: 20px; }
        input { width: 100%; padding: 10px; margin: 10px 0; border-radius: 5px; border:1px solid #ccc; }
        button { width: 100%; padding: 12px; background: #11998e; color: #fff; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
        button:hover { background: #0d796a; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
        a { text-align: center; display: block; margin-top: 10px; text-decoration: none; color: #11998e; }
    </style>
</head>
<body>

<div class="container">
    <h2>Admin Login</h2>

    <% 
        String error = request.getParameter("error");
        if(error != null) { %>
            <p class="error"><%= error %></p>
    <% } %>

    <form action="AdminLoginServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required>

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required>

        <button type="submit">Login</button>
    </form>

    <a href="index.html">Back to Home</a>
</div>

</body>
</html>
