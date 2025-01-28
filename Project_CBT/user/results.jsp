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
String tag = (String) session.getAttribute("tag");
String countStr = (String) session.getAttribute("no_of_question");

int count = 0;
int cutOffMarks = 0;
int noOfQuestions = 0;

int totalQuestions = Integer.parseInt(countStr);
System.out.println("total questions:"+totalQuestions);

int[] arr =(int[]) session.getAttribute("curropUniversal");

for (int i = 1; i <= totalQuestions; i++) {
    String paramName = "op" + i;
    int str = Integer.parseInt(request.getParameter(paramName));
    System.out.println("user option is : "+str);
    System.out.println("admin opption  is : "+arr[i-1]);

   if(str == arr[i-1]){
        count++;
        System.out.println("count is:"+count);
    }
}

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project_CBT", "root", "");
    String q = "SELECT cutOffMarks, no_questions FROM qbank WHERE tag = ?";
    PreparedStatement pst = con.prepareStatement(q);
    pst.setString(1, tag);
    ResultSet r = pst.executeQuery();

    if (r.next()) {
        cutOffMarks = r.getInt("cutOffMarks");
        noOfQuestions = r.getInt("no_questions");
    }

    r.close();
    pst.close();
    con.close();
} catch (Exception e) {
    out.println("<div>Error: Unable to retrieve data. " + e.getMessage() + "</div>");
    e.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Results</title>
    <link rel="stylesheet" href="../style.css">
    <meta charset="UTF-8">
</head>
<body class="results-body">
    
    <h1>FINAL MARKS</h1>
    <hr>
    <%
    if (count >= cutOffMarks) {
    %>
        <h2 style="color: green;">YOU HAVE SUCCESSFULLY PASSED THE EXAM!</h2>
        <h3>Your marks are: <span style="color: blue ;"><%= count %> </span>out of <%= noOfQuestions %></h3>
        <a class="home-button" href="../home/home.html">HOME</a>
        <p style="font-size: 90px;">&#129395;</p>
        <%
    } else {
    %>
        <h2 style="color: red  ;">YOU HAVE FAILED THE EXAM!</h2>
        <h2>Better luck next time</h2>
        <h3>Your marks are: <span style="color: blue;"><%= count %> </span> out of <%= noOfQuestions %></h3>
    <%
    }
    %>
    <a class="home-button" href="../home/home.html">HOME</a>
</body>
</html>
