<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Add User</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{
    background: linear-gradient(135deg,#89f7fe,#66a6ff);
    font-family:'Poppins',sans-serif;
}

.glass{
    background: rgba(255,255,255,0.25);
    backdrop-filter: blur(18px);
    border-radius:20px;
    padding:30px;
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
    margin-top:50px;
}

.form-control{
    border-radius:12px;
}

.toast-msg{
    animation: fadeOut 4s forwards;
}

@keyframes fadeOut{
    0%{opacity:1;}
    80%{opacity:1;}
    100%{opacity:0; display:none;}
}
</style>
</head>
<body>

<div class="container">
<div class="col-md-8 mx-auto glass">

<h4><i class="fa fa-user-plus"></i> Add New User</h4>
<hr>

<%
String message = "";
String type = "";

if("POST".equalsIgnoreCase(request.getMethod())){

    String full_name = request.getParameter("full_name");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    String address = request.getParameter("address");
    String city = request.getParameter("city");

    try{

       

        // Duplicate Check
        PreparedStatement check = con.prepareStatement(
        "SELECT * FROM users WHERE username=? OR email=?");
        check.setString(1, username);
        check.setString(2, email);

        ResultSet rs = check.executeQuery();

        if(rs.next()){
            message = "Username or Email already exists!";
            type = "danger";
        }else{

            PreparedStatement ps = con.prepareStatement(
            "INSERT INTO users(full_name,email,mobile,username,password,role,address,city) VALUES(?,?,?,?,?,?,?,?)");

            ps.setString(1, full_name);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, username);
            ps.setString(5, password);
            ps.setString(6, role);
            ps.setString(7, address);
            ps.setString(8, city);

            ps.executeUpdate();

            message = "User Added Successfully!";
            type = "success";
        }

        con.close();

    }catch(Exception e){
        message = "Error: " + e.getMessage();
        type = "danger";
    }
}
%>

<!-- Toast Message -->
<% if(!message.equals("")){ %>
<div class="alert alert-<%=type%> toast-msg">
    <%= message %>
</div>
<% } %>



</div>
</div>

</body>
</html>
