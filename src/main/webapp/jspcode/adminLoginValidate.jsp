<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

PreparedStatement pst = null;
ResultSet rs = null;

try {

    if(username != null && password != null){

        String query = "SELECT * FROM admin WHERE username=? AND password=?";
        pst = con.prepareStatement(query);
        pst.setString(1, username);
        pst.setString(2, password);

        rs = pst.executeQuery();

        if(rs.next()){
            session.setAttribute("admin", rs.getString("username"));
            session.setAttribute("admin_id", rs.getInt("admin_id"));
            response.sendRedirect("adminDashboard.jsp");
        } else {
            response.sendRedirect("adminLogin.jsp?error=1");
        }

    } else {
        response.sendRedirect("adminLogin.jsp?error=1");
    }

} catch(Exception e){
    out.println("Database Error: " + e.getMessage());
} finally {

    try {
        if(rs != null) rs.close();
        if(pst != null) pst.close();
        if(con != null) con.close();
    } catch(Exception ex){
        out.println("Close Error: " + ex.getMessage());
    }

}
%>
