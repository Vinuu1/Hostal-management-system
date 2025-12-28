<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password | Hostel Management System</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f7; text-align: center; padding-top: 50px; }
        .container { background: #fff; display: inline-block; padding: 30px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.2);}
        input { width: 100%; padding: 10px; margin: 10px 0; border-radius: 5px; border: 1px solid #ccc; }
        button { width: 100%; padding: 12px; background: #11998e; color: #fff; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #0d796a; }
        a { display: block; margin-top: 10px; color: #11998e; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>

<div class="container">
    <h2>Forgot Password</h2>

    <% 
        String msg = request.getParameter("msg");
        String error = request.getParameter("error");
        if(msg != null) { %>
            <p class="success"><%= msg %></p>
    <%  } else if(error != null) { %>
            <p class="error"><%= error %></p>
    <% } %>

    <form action="ForgotPasswordServlet" method="post">
        <input type="email" name="email" placeholder="Enter your registered email" required>
        <button type="submit">Submit</button>
    </form>

    <a href="userLogin.jsp">Back to Login</a>
</div>

</body>
</html>
