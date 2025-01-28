<%@ page import="java.sql.*,java.util.*,java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body >
    <%
    String tag = request.getParameter("tag");
    String no_of_question = request.getParameter("no_of_question");
    session.setAttribute("tag",tag);
    session.setAttribute("no_of_question",no_of_question);
    int j =Integer.parseInt(no_of_question);

    // Check if the parameters are not null or empty
    if (tag != null && no_of_question != null && !tag.trim().isEmpty() && !no_of_question.trim().isEmpty()) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project_CBT", "root", "");
            String q = "SELECT * FROM qbank WHERE tag = ? ";
            PreparedStatement pst = con.prepareStatement(q);
            pst.setString(1, tag);
            ResultSet rs = pst.executeQuery();
            int sNo = 1;
            %>
            <h1><%= tag %> EXAM</h1>
            <h3>NO OF QUESTIONS: <%= no_of_question %></h3>
            <hr>
            <form action="results.jsp">
            <%
           
            int[] currop = new int[j];
          
            
            int i=0;
            while (rs.next()) {
                
                String questions = rs.getString("questions");
                String option1 = rs.getString("option1");
                String option2 = rs.getString("option2");
                String option3 = rs.getString("option3");
                String option4 = rs.getString("option4");
                currop[i] = rs.getInt("correctOption");
               
               i++;
                %>
                <div id="user-questions">
                    <div><b><%= sNo %>. <%= questions %></b></div>
                    <div><input type="radio" value="1" name="op<%= sNo %>" id="op1"><%= option1 %></div>
                    <div><input type="radio" value="2" name="op<%= sNo %>" id="op2"><%= option2 %></div>
                    <div><input type="radio" value="3" name="op<%= sNo %>" id="op3"><%= option3 %></div>
                    <div><input type="radio" value="4" name="op<%= sNo %>" id="op4"><%= option4%></div>
                    
                </div>
                <%

                sNo++;
            }
                for(int x=0; x < j; x++){
                    System.out.println("first out puts is:"+currop[x]);
                }


            session.setAttribute("curropUniversal",currop);
            %>
            <input type="submit" value="Submit">
            </form>
            <%
            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            out.println("<div>Error: Unable to retrieve data. " + e.getMessage() + "</div>");
            out.println("<div><pre>" + sw.toString() + "</pre></div>");
        }
    } else {
        out.println("Invalid data received.");
    }
       
    %>
</body>
</html>
