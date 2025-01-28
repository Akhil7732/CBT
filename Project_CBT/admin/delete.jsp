<%@ page import="java.sql.*,java.io.*" %>
<%
    String tag = request.getParameter("tag");
    if (tag != null && !tag.isEmpty()) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project_CBT", "root", "");
            String q = "DELETE FROM qbank WHERE tag = ?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, tag);
            int rowsAffected = ps.executeUpdate();
            ps.close();
            con.close();
            
            if (rowsAffected > 0) {
                out.println("<script>alert('Record deleted successfully.'); window.location.href='dashboard.jsp';</script>");
            } else {
                out.println("<script>alert('Record not found.'); window.location.href='dashboard.jsp';</script>");
            }
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            out.println("<script>alert('Error: Unable to delete record. " + e.getMessage() + "'); window.location.href='admin_dashboard.jsp';</script>");
            out.println("<pre>" + sw.toString() + "</pre>");
        }
    } else {
        out.println("<script>alert('Invalid request.'); window.location.href='admin_dashboard.jsp';</script>");
    }
%>
