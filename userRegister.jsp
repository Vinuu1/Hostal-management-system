<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h2>User Registration</h2>
    <form action="UserServlet" method="post">
        <input type="text" name="fullname" placeholder="Full Name" required><br>
        <input type="email" name="email" placeholder="Email" required><br>
        <input type="password" name="password" placeholder="Password" required><br>
        <select name="course" required>
            <option value="">Select Course</option>
            <%
                try {
                    Connection con = DBConnection.getConnection();
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM courses");
                    while(rs.next()) {
                        String course = rs.getString("course_name");
            %>
                        <option value="<%=course%>"><%=course%></option>
            <%
                    }
                    con.close();
                } catch(Exception e) { e.printStackTrace(); }
            %>
        </select><br>
        <button type="submit" name="action" value="register">Register</button>
    </form>
    <br>
    <a href="userLogin.jsp">Already have an account? Login here</a>
</div>
</body>
</html>
