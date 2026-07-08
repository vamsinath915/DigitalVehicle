<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="dbconnection.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Users</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background: transparent;
}

.glass{
    background: rgba(255,255,255,0.18);
    backdrop-filter: blur(18px);
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.3);
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
    padding:35px;
}

.page-wrapper{
    padding:30px;
}

.page-title{
    color:#fff;
    font-weight:600;
    margin-bottom:25px;
}

.table{
    background: rgba(255,255,255,0.25);
    border-radius:15px;
    overflow:hidden;
    color:#fff;
}

.table thead{
    background: rgba(255,255,255,0.4);
    color:#333;
}

.btn-sm{
    border-radius:8px;
}

.alert{
    border-radius:12px;
}
</style>
</head>

<body>

<%
String message="";
String type="";

/* DELETE LOGIC */
String deleteId = request.getParameter("delete");
if(deleteId != null){
    try{
        PreparedStatement ps = con.prepareStatement(
        "DELETE FROM users WHERE user_id=?");
        ps.setInt(1,Integer.parseInt(deleteId));
        ps.executeUpdate();
        message="User Deleted Successfully!";
        type="danger";
    }catch(Exception e){
        message="Error: "+e.getMessage();
        type="danger";
    }
}
%>

<div class="page-wrapper">
<div class="glass">

<h4 class="page-title">
<i class="fa fa-users"></i> Manage Users
</h4>

<% if(!message.equals("")){ %>
<div class="alert alert-<%=type%>">
    <%=message%>
</div>
<% } %>

<div class="table-responsive">
<table class="table table-bordered table-hover text-center">

<thead>
<tr>
<th>ID</th>
<th>USER ID</th>
<th>Name</th>
<th>Username</th>
<th>Email</th>
<th>Role</th>
<th>City</th>
<th>Action</th>
</tr>
</thead>

<tbody>

<%
try{

PreparedStatement ps = con.prepareStatement("SELECT * FROM users ORDER BY user_id ASC");
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%=rs.getInt("user_id")%></td>
<td><%=rs.getString("uid")%></td>
<td><%=rs.getString("full_name")%></td>
<td><%=rs.getString("username")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("role")%></td>
<td><%=rs.getString("city")%></td>

<td>
<a href="editUser.jsp?id=<%=rs.getInt("user_id")%>" 
   class="btn btn-warning btn-sm">
   <i class="fa fa-edit"></i>
</a>

<a href="manageUsers.jsp?delete=<%=rs.getInt("user_id")%>" 
   class="btn btn-danger btn-sm"
   onclick="return confirm('Are you sure?');">
   <i class="fa fa-trash"></i>
</a>
</td>

</tr>

<%
}
}catch(Exception e){
out.println("Error: "+e.getMessage());
}
%>

</tbody>
</table>
</div>

</div>
</div>

</body>
</html>
