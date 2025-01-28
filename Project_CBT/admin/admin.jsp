<%@ page import="java.sql.*,java.naming.*,java.util.*"%>
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
String name = request.getParameter("name");
String password = request.getParameter("password");
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project_CBT", "root", "");
    Statement st = con.createStatement();
    String q = "select * from admin where name='" + name + "' and password='" + password + "'";
    ResultSet r = st.executeQuery(q);
    if (!r.next()) {
        out.println("<script type=\"text/javascript\">");
            out.println("alert('Invalid Name or Password!');");
            out.println("location='admin.html';");
            out.println("</script>");
            System.out.println("Invalid User Name or Password!");
    } else {
        
        response.sendRedirect("dashboard.jsp"); 
    }
    st.close();
    con.close();
} catch(Exception e) {
    e.printStackTrace(); // Print the exception for debugging purposes
}
%>
