<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>

<%
    if(session == null || session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Feedback | Admin</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background:#f0f4f7; margin:0; padding:0; }
        .container { width: 900px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
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
    <h2>Feedback from Users</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Feedback</th>
            <th>Date Submitted</th>
        </tr>

        <%
            try {
                Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM feedback ORDER BY created_at DESC");

                while(rs.next()) {
                    int id = rs.getInt("id");
                    int userId = rs.getInt("user_id");
                    String feedback = rs.getString("feedback_text");
                    String date = rs.getString("created_at");
        %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= userId %></td>
                        <td><%= feedback %></td>
                        <td><%= date %></td>
                    </tr>
        <%
                }

                rs.close();
                stmt.close();
                con.close();
            } catch(Exception e) {
                out.println("<tr><td colspan='4' style='color:red;'>Database connection error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>

    <br>
    <a href="adminDashboard.jsp" class="btn">Back to Dashboard</a>
</div>

</body>
</html>
