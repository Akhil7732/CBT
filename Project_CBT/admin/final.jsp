<%@ page import="java.sql.*" %>
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
String cutOffMarks = request.getParameter("pass_marks1");
System.out.println("**"+cutOffMarks);
String tag = (String) session.getAttribute("taga");

try {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish the connection
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project_CBT", "root", "");

    // Construct the SQL statement to update the cutOffMarks for the given tag
    String sql = "UPDATE qbank SET cutOffMarks = ? WHERE tag = ?";

    // Create a PreparedStatement
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, cutOffMarks);
    pstmt.setString(2, tag);

    // Execute the UPDATE statement
    int rowsAffected = pstmt.executeUpdate();

    // Clean up resources
    pstmt.close();
    con.close();

    // Redirect after successful update
    response.sendRedirect("logout.html");

} catch (Exception e) {
    out.println("<h1>Error: " + e.getMessage() + "</h1>");
    e.printStackTrace();
}
%>
