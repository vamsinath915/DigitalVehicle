<%@ page import="java.sql.*" %>
<%@include file="dbconnection.jsp" %>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");

//String url = "jdbc:mysql://localhost:3306/digital";
//String dbUser = "root";
//String dbPass = "root";
//
//Connection con = null;
PreparedStatement pst = null;
ResultSet rs = null;

try {
//    Class.forName("com.mysql.jdbc.Driver");
//    con = DriverManager.getConnection(url, dbUser, dbPass);

    String query = "SELECT * FROM login WHERE username=? AND password=?";
    pst = con.prepareStatement(query);
    pst.setString(1, username);
    pst.setString(2, password);
    
    System.out.println(query);

    rs = pst.executeQuery();

    if(rs.next()) {
        session.setAttribute("username", username);
        response.sendRedirect("r_home.jsp");
    } else {
        response.sendRedirect("login.jsp?error=1");
    }

} catch(Exception e) {
    out.println("Error: " + e);
} finally {
    if(rs!=null) rs.close();
    if(pst!=null) pst.close();
    if(con!=null) con.close();
}
%>
