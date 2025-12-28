<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Rooms</title>
    <style>
        body { font-family: Arial,sans-serif; background:#f0f4f7; margin:0; padding:0; }
        .container { width: 700px; margin:50px auto; background:#fff; padding:25px; border-radius:8px; box-shadow:0 2px 5px rgba(0,0,0,0.2);}
        h2 { text-align:center; margin-bottom:20px; }
        table { width:100%; border-collapse:collapse; }
        th, td { padding:10px; border:1px solid #ccc; text-align:left; }
        th { background:#11998e; color:#fff; }
        a.btn { padding:5px 10px; background:#11998e; color:#fff; text-decoration:none; border-radius:5px; }
        a.btn:hover { background:#0d796a; }
        form input, form button { padding:8px; margin:5px 5px 5px 0; }
        form button { background:#11998e; color:#fff; border:none; border-radius:5px; cursor:pointer; }
        form button:hover { background:#0d796a; }
        .success { color:green; }
        .error { color:red; }
    </style>
</head>
<body>

<div class="container">
    <h2>Manage Rooms</h2>

    <%
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if (msg != null) { %>
            <p class="success"><%= msg %></p>
    <% } else if (error != null) { %>
            <p class="error"><%= error %></p>
    <% } %>

    <!-- Add New Room -->
    <form action="RoomServlet" method="post">
        <input type="text" name="room_no" placeholder="Room Number" required>
        <input type="number" step="0.01" name="fees" placeholder="Fees" required>
        <button type="submit" name="action" value="add">Add Room</button>
    </form>

    <br>

    <!-- List Existing Rooms -->
    <table>
        <tr>
            <th>ID</th>
            <th>Room No</th>
            <th>Fees</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM rooms");

                while(rs.next()) {
                    int id = rs.getInt("id");
                    String roomNo = rs.getString("room_no");
                    double fees = rs.getDouble("fees");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= roomNo %></td>
            <td><%= fees %></td>
            <td>
                <a href="RoomServlet?action=edit&id=<%=id%>" class="btn">Edit</a>
                <a href="RoomServlet?action=delete&id=<%=id%>" class="btn" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <%
                }
                con.close();
            } catch(Exception e) { e.printStackTrace(); }
        %>
    </table>

</div>
</body>
</html>
