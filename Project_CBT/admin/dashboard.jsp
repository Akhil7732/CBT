<%@ page import="java.sql.*,java.util.*,java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body class="dashboard">
    <h1>ADMIN DASHBOARD!</h1>
    <hr>
    <form>
        <table class="tables">
            <tr >
                <th style="color: black;">S.No</th>
                <th style="color: black;">Tag</th>
                <th style="color: black;">No. of questions</th>
                <th style="color: black;">Action1</th>
              
            </tr>
            <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project_CBT", "root", "");
                Statement st = con.createStatement();
                String q = "SELECT DISTINCT tag, no_questions FROM qbank";
                ResultSet rs = st.executeQuery(q);
                int sNo = 1;
                while (rs.next()) {
                    String tag = rs.getString("tag");
                    int no_of_question = rs.getInt("no_questions");

                    out.println("<tr>");
                    out.println("<td>" + sNo++ + "</td>");
                    out.println("<td>" + tag + "</td>");
                    out.println("<td>" + no_of_question + "</td>");
                   
                    out.println("<td><a href='delete.jsp?tag=" + tag + "'>Delete</a></td>");
                    out.println("</tr>");
                }
                rs.close();
                st.close();
                con.close();
            } catch (Exception e) {
                StringWriter sw = new StringWriter();
                e.printStackTrace(new PrintWriter(sw));
                out.println("<tr><td colspan='5'>Error: Unable to retrieve data. " + e.getMessage() + "</td></tr>");
                out.println("<tr><td colspan='5'><pre>" + sw.toString() + "</pre></td></tr>");
            }
            %>
        </table>
        <br><br>
    </form>
    <a class="addquestions" href="addquestions.html">ADD NEW TEST?</a>
</body>
</html>
