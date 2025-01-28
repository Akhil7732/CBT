<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    
</body>
</html>
<%
String uname = request.getParameter("uname");
String uphn = request.getParameter("uphn");
String password = request.getParameter("password");
String cpassword = request.getParameter("cpassword");

if (!password.equals(cpassword)) {
    out.println("Password did not match");
} else {
    out.println("Password created successfully");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project_CBT", "root", "");
             PreparedStatement ps = con.prepareStatement("INSERT INTO newuser (uname, uphn, password,cpassword) VALUES (?, ?, ?,?)")) {

            ps.setString(1, uname);
            ps.setString(2, uphn);
            ps.setString(3, password);
            ps.setString(4,cpassword);
            ps.executeUpdate();
            response.sendRedirect("user.html");
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("Error: " + e.getMessage());
    }
}
%>
