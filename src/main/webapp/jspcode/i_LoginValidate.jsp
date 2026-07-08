<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="dbconnection.jsp" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

PreparedStatement pst = null;
ResultSet rs = null;

try{

    String query = "SELECT * FROM insurance_companies WHERE uid=? AND password=? AND status='Active'";
    pst = con.prepareStatement(query);
    pst.setString(1, username);
    pst.setString(2, password);
    

    rs = pst.executeQuery();

    if(rs.next()){

        // Create session
        session.setAttribute("user_id", rs.getInt("company_id"));
        session.setAttribute("username", rs.getString("uid"));
        session.setAttribute("role", rs.getString("role"));

        // Role based redirect
        String role = rs.getString("role");

        if(role.equals("INSURANCE")){
            response.sendRedirect("i_home.jsp");
        }
        else{
            response.sendRedirect("i_login.jsp");
        }

    }else{
        response.sendRedirect("menu.jsp?error=1");
    }

}catch(Exception e){
    out.println("Error: "+e.getMessage());
}
finally{
    if(rs!=null) rs.close();
    if(pst!=null) pst.close();
    if(con!=null) con.close();
}
%>
