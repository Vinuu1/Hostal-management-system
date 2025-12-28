<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>

<%
    // Ensure user is logged in
    if(session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    String userName = (String) session.getAttribute("userName");
    int userId = Integer.parseInt(session.getAttribute("userId").toString());

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Complaints | Hostel Management System</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin: 0; padding: 0; }
        .container { width: 600px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        h2 { color: #11998e; text-align: center; margin-bottom: 25px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 12px; text-align: left; }
        th { background: #11998e; color: #fff; }
        tr:nth-child(even) { background: #f9f9f9; }
        a { display: block; margin-top: 15px; color: #11998e; text-decoration: none; text-align: center; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <h2>Complaints Submitted by <%= userName %></h2>

    <%
        try {
            con = DBConnection.getConnection();
            String sql = "SELECT complaint_text, status FROM complaints WHERE student_id=? ORDER BY id DESC";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
    %>

    <table>
        <tr>
            <th>Complaint</th>
            <th>Status</th>
        </tr>
        <%
            while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("complaint_text") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
            }
        %>
    </table>

    <%
        } catch(Exception e) {
            out.println("<p style='color:red;'>Error fetching complaints!</p>");
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception ex) {}
            try { if(ps != null) ps.close(); } catch(Exception ex) {}
            try { if(con != null) con.close(); } catch(Exception ex) {}
        }
    %>

    <a href="userDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>
