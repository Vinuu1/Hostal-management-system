<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>
<%
    // Ensure the user is logged in
    if(session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Hostel | Hostel Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #00b09b, #96c93d);
            margin: 0;
            padding: 0;
        }
        .container {
            width: 450px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            text-align: center;
        }
        h2 {
            color: #11998e;
            margin-bottom: 25px;
        }
        select, button {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 16px;
        }
        button {
            background: #11998e;
            color: #fff;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s ease;
        }
        button:hover {
            background: #0d796a;
        }
        a {
            display: block;
            margin-top: 15px;
            color: #11998e;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .success { color: green; margin-bottom: 10px; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>

<div class="container">
    <h2>Hello, <%= userName %>!</h2>
    <h3>Book Your Hostel Room</h3>

    <% 
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if(msg != null) { %>
            <p class="success"><%= msg %></p>
    <% } else if(error != null) { %>
            <p class="error"><%= error %></p>
    <% } %>

    <form action="RoomServlet" method="post">
    <!-- Hidden field for student ID -->
    <input type="hidden" name="studentId" value="<%= session.getAttribute("userId") %>">

    <label for="room_id">Select Room Number:</label>
    <select name="room_id" id="room_id" required>
        <option value="">--Select Room--</option>
        <% 
            try {
                 con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT id, room_no, fees FROM rooms");
                while(rs.next()) {
                    int roomId = rs.getInt("id");
                    String roomNo = rs.getString("room_no");
                    double fees = rs.getDouble("fees");
        %>
            <option value="<%= roomId %>">Room <%= roomNo %> - Rs. <%= fees %></option>
        <%
                }
                con.close();
            } catch(Exception e) { e.printStackTrace(); }
        %>
    </select>

    <button type="submit">Book Room</button>
</form>

       

    <a href="userDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>
