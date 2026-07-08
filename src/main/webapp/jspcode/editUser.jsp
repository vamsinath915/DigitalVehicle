<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="dbconnection.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Edit User</title>
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

.form-control{
    background: rgba(255,255,255,0.25);
    border:1px solid rgba(255,255,255,0.4);
    border-radius:12px;
    color:#fff;
}

.form-control:focus{
    background: rgba(255,255,255,0.35);
    box-shadow:none;
    border-color:#fff;
    color:#fff;
}

select.form-control option{
    background:#fff;
    color:#333;
}

label{
    color:#fff;
    font-weight:500;
}

.btn-custom{
    background:#fff;
    color:#333;
    border-radius:12px;
    padding:10px 25px;
    font-weight:500;
    transition:0.3s;
}

.btn-custom:hover{
    background:#f1f1f1;
    transform:translateY(-2px);
}
</style>
</head>

<body>

<%
String message="";
String type="";

String idParam = request.getParameter("id");
int userId = 0;

if(idParam != null){
    userId = Integer.parseInt(idParam);
}

/* UPDATE LOGIC */
if("POST".equalsIgnoreCase(request.getMethod())){

    userId = Integer.parseInt(request.getParameter("user_id"));

    String full_name = request.getParameter("full_name");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String role = request.getParameter("role");
    String address = request.getParameter("address");
    String city = request.getParameter("city");

    try{

        PreparedStatement ps = con.prepareStatement(
        "UPDATE users SET full_name=?,username=?,email=?,mobile=?,role=?,address=?,city=? WHERE user_id=?");

        ps.setString(1, full_name);
        ps.setString(2, username);
        ps.setString(3, email);
        ps.setString(4, mobile);
        ps.setString(5, role);
        ps.setString(6, address);
        ps.setString(7, city);
        ps.setInt(8, userId);

        ps.executeUpdate();

        message="User Updated Successfully!";
        type="success";

    }catch(Exception e){
        message="Error: "+e.getMessage();
        type="danger";
    }
}

/* FETCH USER DATA */
PreparedStatement ps = con.prepareStatement(
"SELECT * FROM users WHERE user_id=?");
ps.setInt(1,userId);
ResultSet rs = ps.executeQuery();

if(!rs.next()){
    out.println("<h4>User Not Found</h4>");
    return;
}
%>

<div class="page-wrapper">
<div class="glass">

<h4 class="page-title">
<i class="fa fa-edit"></i> Edit User
</h4>

<% if(!message.equals("")){ %>
<div class="alert alert-<%=type%>">
    <%=message%>
</div>
<% } %>

<form method="post">

<input type="hidden" name="user_id" value="<%=userId%>">

<div class="row">

<div class="col-md-6 mb-3">
<label>Full Name</label>
<input type="text" name="full_name"
value="<%=rs.getString("full_name")%>"
class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label>Username</label>
<input type="text" name="username"
value="<%=rs.getString("username")%>"
class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label>Email</label>
<input type="email" name="email"
value="<%=rs.getString("email")%>"
class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label>Mobile</label>
<input type="text" name="mobile"
value="<%=rs.getString("mobile")%>"
class="form-control">
</div>

<div class="col-md-6 mb-3">
<label>Role</label>
<select name="role" class="form-control" required>
<option value="RTO" <%=rs.getString("role").equals("RTO")?"selected":""%>>RTO</option>
<option value="PCB" <%=rs.getString("role").equals("PCB")?"selected":""%>>PCB</option>
<option value="TRAFFIC" <%=rs.getString("role").equals("TRAFFIC")?"selected":""%>>TRAFFIC</option>
<option value="POLICE" <%=rs.getString("role").equals("POLICE")?"selected":""%>>POLICE</option>
</select>
</div>

<div class="col-md-6 mb-3">
<label>City</label>
<input type="text" name="city"
value="<%=rs.getString("city")%>"
class="form-control">
</div>

<div class="col-12 mb-3">
<label>Address</label>
<textarea name="address" class="form-control"><%=rs.getString("address")%></textarea>
</div>

</div>

<div class="text-end">
<button class="btn btn-custom">
<i class="fa fa-save"></i> Update User
</button>
</div>

</form>

</div>
</div>

</body>
</html>
