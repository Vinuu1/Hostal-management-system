<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>
<%

String userName = (String) session.getAttribute("userName");


    if(session == null || session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String id = request.getParameter("id");
    String roomNo = "";
    double fees = 0;

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM rooms WHERE id=?");
        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            roomNo = rs.getString("room_no");
            fees = rs.getDouble("fees");
        }
        con.close();
    } catch(Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Room | Hostel Management System</title>
</head>
<body>
    <h2>Edit Room</h2>
    <form action="updateRoom.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="text" name="room_no" value="<%=roomNo%>" required>
        <input type="number" step="0.01" name="fees" value="<%=fees%>" required>
        <button type="submit">Update</button>
    </form>
    <a href="manageRooms.jsp">Back</a>
</body>
</html>
