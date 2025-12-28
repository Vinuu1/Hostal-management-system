<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>
<%

String userName = (String) session.getAttribute("userName");


    if(session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    int userId = (int) session.getAttribute("userId");
    
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complaint Status | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        .container { width: 600px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        h2 { text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        th { background: #11998e; color: #fff; }
        a { display: block; text-align: center; margin-top: 10px; text-decoration: none; color: #11998e; }
    </style>
</head>
<body>

<div class="container">
    <h2>Complaints Status</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Complaint</th>
            <th>Status</th>
            <th>Date</th>
        </tr>

        <%
            try {
                con = DBConnection.getConnection();
                ps = con.prepareStatement("SELECT * FROM complaints WHERE user_id = ? ORDER BY created_at DESC");
                ps.setInt(1, userId);
                rs = ps.executeQuery();

                while(rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("complaint_text") %></td>
                        <td><%= rs.getString("status") %></td>
                        <td><%= rs.getTimestamp("created_at") %></td>
                    </tr>
        <%
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                try { if(rs != null) rs.close(); if(ps != null) ps.close(); if(con != null) con.close(); } catch(Exception ex) {}
            }
        %>
    </table>

    <a href="userDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>
