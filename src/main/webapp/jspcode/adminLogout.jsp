<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    // Remove specific admin session attribute
    session.removeAttribute("admin");

    // Invalidate complete session
    session.invalidate();

    // Prevent browser caching
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires", 0);

    // Redirect to login page
    response.sendRedirect("menu.jsp");
%>
