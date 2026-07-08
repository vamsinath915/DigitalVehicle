<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnection.jsp" %>
<%
if(session.getAttribute("username")==null){
%>
<script>
    window.top.location.href="login.jsp";
</script>
<%
    return;
}

//Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String message="";
String alertType="";

try{
    if(request.getMethod().equalsIgnoreCase("POST")){

        String username=(String)session.getAttribute("username");
        String oldPass=request.getParameter("old_password");
        String newPass=request.getParameter("new_password");
        String confirmPass=request.getParameter("confirm_password");

        if(!newPass.equals(confirmPass)){
            message="New Password and Confirm Password do not match!";
            alertType="danger";
        }else{

//            Class.forName("com.mysql.jdbc.Driver");
//            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

            ps=con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1,username);
            ps.setString(2,oldPass);
            rs=ps.executeQuery();

            if(rs.next()){

                ps=con.prepareStatement("UPDATE users SET password=? WHERE username=?");
                ps.setString(1,newPass);
                ps.setString(2,username);

                int i=ps.executeUpdate();

                if(i>0){
                    message="Password updated successfully.";
                    alertType="success";
                }else{
                    message="Password update failed.";
                    alertType="danger";
                }

            }else{
                message="Old password is incorrect.";
                alertType="warning";
            }
        }
    }

}catch(Exception e){
    message="Error: "+e.getMessage();
    alertType="danger";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{
    background-color:#f1f4f8;
    font-family: 'Segoe UI', sans-serif;
}

/* Page Header */
.page-header{
    background-color:#0d6efd;
    color:white;
    padding:20px 30px;
    border-radius:8px;
    margin-bottom:30px;
    box-shadow:0 3px 10px rgba(0,0,0,0.1);
}

/* Card */
.password-card{
    border:none;
    border-radius:10px;
    box-shadow:0 4px 20px rgba(0,0,0,0.08);
}

.card-header{
    background-color:#ffffff;
    font-weight:600;
    font-size:18px;
    border-bottom:1px solid #e5e7eb;
}

.form-control{
    border-radius:6px;
}

.btn-primary{
    border-radius:6px;
    font-weight:500;
}

@media(max-width:768px){
    .page-header{
        text-align:center;
    }
}
</style>
</head>

<body>

<div class="container-fluid p-4">

<!-- Corporate Page Title -->
<div class="page-header">
    <h4 class="mb-0">
        <i class="fa-solid fa-key me-2"></i>
        Change Password
    </h4>
</div>

<div class="row justify-content-center">
<div class="col-lg-5 col-md-7">

<div class="card password-card">

<div class="card-header">
    Account Security
</div>

<div class="card-body p-4">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
<%=message%>
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>

<form method="post">

<div class="mb-3">
<label class="form-label">Old Password</label>
<div class="input-group">
    <input type="password" name="old_password" id="oldPass" class="form-control" autofocus="yes" required>
    <span class="input-group-text bg-white" onclick="togglePassword('oldPass', this)" style="cursor:pointer;">
        <i class="fa-solid fa-eye"></i>
    </span>
</div>
</div>


<div class="mb-3">
<label class="form-label">New Password</label>
<div class="input-group">
    <input type="password" name="new_password" id="newPass" class="form-control" required>
    <span class="input-group-text bg-white" onclick="togglePassword('newPass', this)" style="cursor:pointer;">
        <i class="fa-solid fa-eye"></i>
    </span>
</div>
</div>


<div class="mb-3">
<label class="form-label">Confirm Password</label>
<div class="input-group">
    <input type="password" name="confirm_password" id="confirmPass" class="form-control" required>
    <span class="input-group-text bg-white" onclick="togglePassword('confirmPass', this)" style="cursor:pointer;">
        <i class="fa-solid fa-eye"></i>
    </span>
</div>
</div>


<div class="d-grid">
<button type="submit" class="btn btn-primary">
<i class="fa-solid fa-floppy-disk me-2"></i>
Update Password
</button>
</div>

</form>

</div>
</div>

</div>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function togglePassword(fieldId, element){
    const input = document.getElementById(fieldId);
    const icon = element.querySelector("i");

    if(input.type === "password"){
        input.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    }else{
        input.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}
</script>

</body>
</html>
