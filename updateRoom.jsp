<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, hostelManagementSystem.DBConnection" %>
<%
    // Ensure admin is logged in
    if (session == null || session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String idStr = request.getParameter("id");
    if (idStr == null || idStr.isEmpty()) {
        response.sendRedirect("manageRooms.jsp?error=Room ID is missing!");
        return;
    }

    int roomId = Integer.parseInt(idStr);
    String roomNo = "";
    double fees = 0.0;

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM rooms WHERE id = ?");
        ps.setInt(1, roomId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            roomNo = rs.getString("room_no");
            fees = rs.getDouble("fees");
        } else {
            response.sendRedirect("manageRooms.jsp?error=Room not found!");
            return;
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manageRooms.jsp?error=Database error!");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Room | Hostel Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; margin:0; padding:0; }
        .container { width: 500px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        h2 { text-align: center; margin-bottom: 20px; }
        form input { width: 100%; padding: 10px; margin-bottom: 15px; border-radius: 5px; border: 1px solid #ccc; }
        form button { padding: 10px 15px; background: #11998e; color: #fff; border: none; border-radius: 5px; cursor: pointer; }
        form button:hover { background: #0d796a; }
        a.btn { display:inline-block; margin-top:10px; color:#11998e; text-decoration:none; }
        a.btn:hover { text-decoration:underline; }
    </style>
</head>
<body>

<div class="container">
    <h2>Update Room</h2>

    <form action="UpdateRoomServlet" method="post">
        <input type="hidden" name="id" value="<%= roomId %>">
        <label>Room Number</label>
        <input type="text" name="room_no" value="<%= roomNo %>" required>

        <label>Fees</label>
        <input type="number" step="0.01" name="fees" value="<%= fees %>" required>

        <button type="submit">Update Room</button>
    </form>

    <a href="manageRooms.jsp" class="btn">Back to Manage Rooms</a>
</div>

</body>
</html>
