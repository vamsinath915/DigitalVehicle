<%@ page import="java.sql.*" %>

<%
String dbURL = "jdbc:mysql://localhost:3306/digital_vehicle_system";
String dbUser = "root";
String dbPassword = "Vamsinath915@";

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
} catch (Exception e) {
    out.println("Database Connection Error: " + e.getMessage());
}
%>