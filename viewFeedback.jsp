<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>

<%
    String userName = (String) session.getAttribute("userName");

    if(session == null || session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Feedback | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        .container { width: 700px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        h2 { text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border:1px solid #ccc; text-align: left; }
        th { background: #11998e; color: #fff; }
        a.btn { padding: 5px 10px; background: #11998e; color: #fff; text-decoration: none; border-radius: 5px; }
        a.btn:hover { background: #0d796a; }
    </style>
</head>
<body>

<div class="container">
    <h2>Student Feedback</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Student Name</th>
            <th>Feedback</th>
        </tr>

        <%
            try {
                Connection con = DBConnection.getConnection();
                String sql = "SELECT f.id, u.fullname, f.feedback_text " +
                             "FROM feedback f JOIN users u ON f.user_id = u.id";
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                while(rs.next()) {
                    int id = rs.getInt("id");
                    String fullname = rs.getString("fullname");
                    String feedback = rs.getString("feedback_text");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= fullname %></td>
                        <td><%= feedback %></td>
                    </tr>
        <%
                }
                con.close();
            } catch(Exception e) { e.printStackTrace(); }
        %>
    </table>

    <br>
    <a href="adminDashboard.jsp" class="btn">Back to Dashboard</a>
</div>

</body>
</html>
