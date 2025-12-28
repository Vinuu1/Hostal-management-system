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
    String courseName = "";
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT course_name FROM courses WHERE id=?");
        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            courseName = rs.getString("course_name");
        }
        con.close();
    } catch(Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Course | Hostel Management System</title>
</head>
<body>
    <h2>Edit Course</h2>
    <form action="updateCourse.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="text" name="course_name" value="<%=courseName%>" required>
        <button type="submit">Update</button>
    </form>
    <a href="manageCourses.jsp">Back</a>
</body>
</html>
