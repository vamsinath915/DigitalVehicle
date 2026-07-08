<%@ page import="java.sql.*" %>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/digital_vehicle_system",
        "root",
        "Vamsinath915@"
    );

    out.println("<h2 style='color:green'>Database Connected Successfully!</h2>");

    con.close();

} catch (Exception e) {
    out.println("<h2 style='color:red'>Connection Failed</h2>");
    e.printStackTrace(new java.io.PrintWriter(out));
}
%>