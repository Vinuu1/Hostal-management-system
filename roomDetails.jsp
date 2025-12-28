<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>

<%
    // Ensure the user is logged in
    if(session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    int userId = Integer.parseInt(session.getAttribute("userId").toString());
    String userName = (String) session.getAttribute("userName");
    String roomNo = "Not booked yet";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        // Fetch the room booked by the student
        String sql = "SELECT r.room_no FROM students s " +
                     "LEFT JOIN rooms r ON s.room_id = r.id " +
                     "WHERE s.id = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        rs = ps.executeQuery();
        if(rs.next() && rs.getString("room_no") != null) {
            roomNo = rs.getString("room_no");
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception ex) {}
        try { if(ps != null) ps.close(); } catch(Exception ex) {}
        try { if(con != null) con.close(); } catch(Exception ex) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booked Room | Hostel Management System</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        header { background: #11998e; color: #fff; padding: 20px; text-align: center; font-size: 26px; }
        .container { width: 400px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); text-align: center; }
        h2 { color: #11998e; margin-bottom: 20px; }
        p { font-size: 18px; }
        .room-number { font-size: 22px; font-weight: bold; color: #ff5722; }
        a.btn { display: inline-block; padding: 12px 20px; background: #11998e; color: #fff; text-decoration: none; border-radius: 5px; margin-top: 20px; }
        a.btn:hover { background: #0d796a; }
    </style>
</head>
<body>

<header>Hostel Management System</header>

<div class="container">
    <h2>Welcome, <%= userName %></h2>
    <p>Your booked room number is:</p>
    <p class="room-number"><%= roomNo %></p>
    <a href="userDashboard.jsp" class="btn">Back to Dashboard</a>
</div>

</body>
</html>
