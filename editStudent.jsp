<%@ page import="java.sql.*" %>
<%@ page import="hostelManagementSystem.DBConnection" %>
<%
    if (session == null || session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String studentId = request.getParameter("id");
    if (studentId == null) {
        response.sendRedirect("manageStudents.jsp?error=Student ID is missing!");
        return;
    }

    String name = "", email = "", password = "";
    int courseID = 0;
    Integer roomID = null;

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM students WHERE id=?");
        ps.setInt(1, Integer.parseInt(studentId));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            password = rs.getString("password");
            courseID = rs.getInt("course_id");
            roomID = rs.getObject("room_id") != null ? rs.getInt("room_id") : null;
        }
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<style>
/* --- Global Styles --- */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f0f4f7;
    margin: 0;
    padding: 0;
    color: #333;
}

.container {
    max-width: 900px;
    margin: 50px auto;
    background: #fff;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
}

/* --- Headings --- */
h2 {
    text-align: center;
    color: #11998e;
    font-size: 28px;
    margin-bottom: 30px;
}

/* --- Form Styles --- */
form {
    display: flex;
    flex-direction: column;
}

form label {
    margin-bottom: 5px;
    font-weight: bold;
}

form input[type="text"],
form input[type="email"],
form input[type="number"],
form select {
    padding: 12px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 16px;
    transition: border 0.3s, box-shadow 0.3s;
}

form input:focus,
form select:focus {
    border-color: #11998e;
    box-shadow: 0 0 5px rgba(17,153,142,0.4);
    outline: none;
}

form button {
    padding: 12px;
    background-color: #11998e;
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s;
}

form button:hover {
    background-color: #0d796a;
}

/* --- Table Styles --- */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 30px;
}

th, td {
    padding: 12px 15px;
    border: 1px solid #ddd;
    text-align: left;
}

th {
    background-color: #11998e;
    color: #fff;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

tr:hover {
    background-color: #f1f1f1;
}

/* --- Buttons inside Table --- */
a.btn {
    padding: 6px 12px;
    border-radius: 5px;
    text-decoration: none;
    color: #fff;
    background-color: #11998e;
    margin-right: 5px;
    font-size: 14px;
    transition: background-color 0.3s;
}

a.btn:hover {
    background-color: #0d796a;
}

/* --- Messages --- */
.message {
    padding: 12px;
    border-radius: 6px;
    margin-bottom: 20px;
    font-weight: bold;
    text-align: center;
}

.message.success {
    background-color: #d4edda;
    color: #155724;
}

.message.error {
    background-color: #f8d7da;
    color: #721c24;
}

/* --- Back Button --- */
a.btn-back {
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    color: #fff;
    background-color: #11998e;
    padding: 10px 20px;
    border-radius: 6px;
    transition: background-color 0.3s;
}

a.btn-back:hover {
    background-color: #0d796a;
}

/* --- Responsive --- */
@media screen and (max-width: 768px) {
    .container {
        padding: 20px;
    }

    table th, table td {
        padding: 8px;
        font-size: 14px;
    }

    form input, form select, form button {
        font-size: 14px;
    }
}
</style>


<form action="StudentServlet" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="<%=studentId%>">

    Name: <input type="text" name="name" value="<%=name%>" required><br>
    Email: <input type="email" name="email" value="<%=email%>" required><br>
    Password: <input type="text" name="password" value="<%=password%>" required><br>

    Course:
    <select name="course_id" required>
    <%
        Connection con2 = DBConnection.getConnection();
        Statement stmt = con2.createStatement();
        ResultSet rsCourses = stmt.executeQuery("SELECT id, course_name FROM courses");
        while(rsCourses.next()) {
            int cId = rsCourses.getInt("id");
            String cName = rsCourses.getString("course_name");
    %>
            <option value="<%=cId%>" <%= (cId == courseID ? "selected" : "") %>><%=cName%></option>
    <%
        }
        con2.close();
    %>
    </select><br>

    Room:
    <select name="room_id">
        <option value="">--No Room--</option>
        <%
            Connection con3 = DBConnection.getConnection();
            Statement stmt2 = con3.createStatement();
            ResultSet rsRooms = stmt2.executeQuery("SELECT id, room_no FROM rooms");
            while(rsRooms.next()) {
                int rId = rsRooms.getInt("id");
                String rNo = rsRooms.getString("room_no");
        %>
                <option value="<%=rId%>" <%= (roomID != null && roomID == rId ? "selected" : "") %>><%=rNo%></option>
        <%
            }
            con3.close();
        %>
    </select><br>

    <button type="submit">Update Student</button>
</form>
