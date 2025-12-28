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
    <title>Manage Students | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        .container { width: 900px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        h2 { text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border:1px solid #ccc; text-align: left; }
        th { background: #11998e; color: #fff; }
        a.btn { padding: 5px 10px; background: #11998e; color: #fff; text-decoration: none; border-radius: 5px; }
        a.btn:hover { background: #0d796a; }
        form input, form select { padding: 8px; margin: 5px 5px 5px 0; }
        form button { padding: 8px 12px; background: #11998e; color: #fff; border: none; border-radius: 5px; cursor: pointer; }
        form button:hover { background: #0d796a; }
    </style>
</head>
<body>

<div class="container">
    <h2>Manage Students</h2>

    <% 
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if(msg != null) { %>
            <p style="color:green;"><%= msg %></p>
    <% } else if(error != null) { %>
            <p style="color:red;"><%= error %></p>
    <% } %>

    <!-- Add New Student -->
    <form action="StudentServlet" method="post">
        <input type="text" name="name" placeholder="Student Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>

        <select name="course_id" required>
            <option value="">Select Course</option>
            <%
                try {
                    Connection con = DBConnection.getConnection();
                    Statement stmt = con.createStatement();
                    ResultSet rsCourses = stmt.executeQuery("SELECT * FROM courses");
                    while(rsCourses.next()) {
                        int courseId = rsCourses.getInt("id");
                        String courseName = rsCourses.getString("course_name");
            %>
                        <option value="<%=courseId%>"><%=courseName%></option>
            <%
                    }
                    con.close();
                } catch(Exception e) { e.printStackTrace(); }
            %>
        </select>

        <select name="room_id">
            <option value="">Select Room (optional)</option>
            <%
                try {
                    Connection con = DBConnection.getConnection();
                    Statement stmt = con.createStatement();
                    ResultSet rsRooms = stmt.executeQuery("SELECT * FROM rooms");
                    while(rsRooms.next()) {
                        int roomId = rsRooms.getInt("id");
                        String roomNo = rsRooms.getString("room_no");
            %>
                        <option value="<%=roomId%>"><%=roomNo%></option>
            <%
                    }
                    con.close();
                } catch(Exception e) { e.printStackTrace(); }
            %>
        </select>

        <button type="submit" name="action" value="add">Add Student</button>
    </form>

    <br>

    <!-- List Students -->
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Course</th>
            <th>Room</th>
            <th>Actions</th>
        </tr>

        <%
            try {
                Connection con = DBConnection.getConnection();
                String sql = "SELECT s.id, s.name, s.email, c.course_name, r.room_no " +
                             "FROM students s LEFT JOIN courses c ON s.course_id = c.id " +
                             "LEFT JOIN rooms r ON s.room_id = r.id";
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                while(rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String courseName = rs.getString("course_name");
                    String roomNo = rs.getString("room_no");
        %>
                    <tr>
                        <td><%=id%></td>
                        <td><%=name%></td>
                        <td><%=email%></td>
                        <td><%=courseName%></td>
                        <td><%=roomNo != null ? roomNo : "Not Assigned" %></td>
                        <td>
                            <a href="StudentServlet?action=edit&id=<%=id%>" class="btn">Edit</a>
                            <a href="StudentServlet?action=delete&id=<%=id%>" class="btn" 
                               onclick="return confirm('Are you sure you want to delete this student?');">Delete</a>
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
