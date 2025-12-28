<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #11998e, #38ef7d);
            color: #fff;
            margin: 0;
            padding: 0;
        }
        .login-container {
            width: 380px;
            background: rgba(0, 0, 0, 0.4);
            padding: 30px;
            border-radius: 10px;
            margin: 100px auto;
            text-align: center;
        }
        h2 {
            margin-bottom: 25px;
        }
        input[type="text"], input[type="password"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 6px;
            outline: none;
        }
        button {
            width: 95%;
            padding: 10px;
            background-color: #fff;
            color: #11998e;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }
        button:hover {
            background-color: #11998e;
            color: #fff;
        }
        a {
            color: #fff;
            text-decoration: underline;
        }
        .error {
            color: #ff8080;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Student Login</h2>
        <form action="UserLoginServlet" method="post">
            <input type="text" name="email" placeholder="Enter Email" required><br>
            <input type="password" name="password" placeholder="Enter Password" required><br>
            <button type="submit">Login</button>
        </form>
        <p><a href="userRegister.html">New User? Register Here</a></p>
        <p><a href="forgotPassword.jsp">Forgot Password?</a></p>

        <%-- Optional error message display --%>
        <% 
            String error = request.getParameter("error");
            if(error != null) { 
        %>
            <p class="error">Invalid email or password. Please try again.</p>
        <% } %>
    </div>

</body>
</html>
