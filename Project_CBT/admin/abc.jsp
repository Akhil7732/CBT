<%@ page import="java.sql.*,java.naming.*,java.util.*"%>
<%
String hidden1 = request.getParameter("tag");
session.setAttribute("taga",hidden1);
int hidden2 = Integer.parseInt(request.getParameter("cnt"));

for (int i = 1; i <= hidden2; i++) {
    String qbank = request.getParameter("input" + i);
    String opp_1 = request.getParameter("opp1" + i);
    String opp_2 = request.getParameter("opp2" + i);
    String opp_3 = request.getParameter("opp3" + i);
    String opp_4 = request.getParameter("opp4" + i);
    String correct = request.getParameter("curr"+i);

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project_CBT", "root", "");

        // Create the SQL query
        String q = "INSERT INTO qbank (tag, no_questions, questions, option1, option2, option3, option4, correctOption) " +
                   "VALUES ('" + hidden1 + "', '" + hidden2 + "', '" + qbank + "', '" + opp_1 + "', '" + opp_2 + "', '" + opp_3 + "', '" + opp_4 + "', '" + correct + "')";

        // Execute the query
        Statement st = con.createStatement();
        int rowsAffected = st.executeUpdate(q);

        // Close statement and connection
        st.close();
        con.close();

        if (rowsAffected > 0) {
            System.out.println("Data inserted successfully for question " + i);
        } else {
            System.out.println("Failed to insert data for question " + i);
        }

    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Error inserting data for question " + i + ": " + e.getMessage());
    }
}

// Redirect to final.html with parameters
response.sendRedirect("final.html?tag=" + hidden1 + "&cnt=" + hidden2);
%>
