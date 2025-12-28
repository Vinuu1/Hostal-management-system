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
    <title>Manage Complaints | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        .container { width: 900px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        h2 { text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border:1px solid #ccc; text-align: left; }
        th { background: #11998e; color: #fff; }
        a.btn, button { padding: 5px 10px; background: #11998e; color: #fff; text-decoration: none; border-radius: 5px; border: none; cursor: pointer; }
        a.btn:hover, button:hover { background: #0d796a; }
        form select { padding: 5px; }
    </style>
</head>
<body>

<div class="container">
    <h2>Manage Complaints</h2>

    <% 
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if(msg != null) { %>
            <p style="color:green;"><%= msg %></p>
    <% } else if(error != null) { %>
            <p style="color:red;"><%= error %></p>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>Student Name</th>
            <th>Complaint</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <%
            try {
                Connection con = DBConnection.getConnection();
                String sql = "SELECT c.id, s.name, c.complaint_text, c.status " +
                             "FROM complaints c JOIN students s ON c.student_id = s.id";
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                while(rs.next()) {
                    int id = rs.getInt("id");
                    String studentName = rs.getString("name");
                    String complaint = rs.getString("complaint_text");
                    String status = rs.getString("status");
        %>
                    <tr>
                        <td><%=id%></td>
                        <td><%=studentName%></td>
                        <td><%=complaint%></td>
                        <td><%=status%></td>
                        <td>
                            <form action="ComplaintServlet" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="<%=id%>">
                                <select name="status">
                                    <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Pending</option>
                                    <option value="In Progress" <%= "In Progress".equals(status) ? "selected" : "" %>>In Progress</option>
                                    <option value="Resolved" <%= "Resolved".equals(status) ? "selected" : "" %>>Resolved</option>
                                </select>
                                <button type="submit" name="action" value="update">Update</button>
                            </form>
                        </td>
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
