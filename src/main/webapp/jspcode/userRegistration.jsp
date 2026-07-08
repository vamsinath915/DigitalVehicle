<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnection.jsp" %>
<%
//Connection con=null;
PreparedStatement ps=null;

String message="";
String alertType="";

try{
    if(request.getMethod().equalsIgnoreCase("POST")){

        String fullName=request.getParameter("full_name");
        String email=request.getParameter("email");
        String mobile=request.getParameter("mobile");
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        String role=request.getParameter("role");
        String address=request.getParameter("address");
        String city=request.getParameter("city");

//        Class.forName("com.mysql.jdbc.Driver");
//        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");
        String userId = null;
        int generatedAutoIncrementId = 0;
        
        String sql = "SELECT count(user_id) FROM users where role=?";
        PreparedStatement ps1 = con.prepareStatement(sql);
        ps1.setString(1,role);
        ResultSet rs1 = ps1.executeQuery();
        if(rs1.next())
        {
            generatedAutoIncrementId = rs1.getInt(1)+1;
        }
        else
        {
            generatedAutoIncrementId = 1;
        }
        
        userId = "VO_"+ String.format("%03d", generatedAutoIncrementId);

        String query="INSERT INTO users(full_name,email,mobile,username,password,role,address,city,uid) VALUES(?,?,?,?,?,?,?,?,?)";
        ps=con.prepareStatement(query);
        ps.setString(1,fullName);
        ps.setString(2,email);
        ps.setString(3,mobile);
        ps.setString(4,username);
        ps.setString(5,password);
        ps.setString(6,role);
        ps.setString(7,address);
        ps.setString(8,city);
        ps.setString(9,userId);
        int i=ps.executeUpdate();

        if(i>0){
            message="Registration Successful! USER ID:"+userId;
            alertType="success";
        }else{
            message="Registration Failed!";
            alertType="danger";
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
<title>User Registration</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{
    background: url('images/bg_f.jpg');
    background-size: cover;
    font-family:'Segoe UI',sans-serif;
}

.page-header{
    background-color: #F54927;
    color:white;
    padding:20px 30px;
    border-radius:8px;
    margin-bottom:25px;
    box-shadow:0 3px 10px rgba(0,0,0,0.1);
}

.card{
    border:none;
    border-radius:10px;
    box-shadow:0 4px 20px rgba(0,0,0,0.08);
}

.form-label{
    font-weight:500;
}

.btn-primary{
    background-color: #F54927;
    //background-image: linear-gradient(red, yellow, blue);
    border-radius:6px;
    font-weight:500;
    outline: none;
    border:none;
}

.input-group-text{
    cursor:pointer;
}

@media(max-width:768px){
    .page-header{
        text-align:center;
    }
}
</style>
</head>

<body>
<!-- ? Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm">
    <div class="container">
       <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                    <img src="images/vehicle.png" alt="" width="80" height="74" class="d-inline-block align-text-top" >
                    <span class="brand-text">Digital Vehicle Information</span>
                </a>
                <!--<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>-->
                </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="menu.jsp">Logins</a></li>
               <!-- <li class="nav-item"><a class="nav-link" href="#">Projects</a></li>-->
                <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container my-3">

<div class="page-header">
    <h4 class="mb-0">
        <i class="fa-solid fa-user-plus me-2"></i>
        User Registration
    </h4>
</div>

<div class="card">
<div class="card-body p-3">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
<%=message%>
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>

<form method="post" onsubmit="return validateForm();">

<div class="row">

<div class="col-md-6 mb-3">
<label class="form-label">Full Name</label>
<input type="text" name="full_name" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Email</label>
<input type="email" name="email" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Mobile</label>
<input type="text" name="mobile" class="form-control" maxlength="10" pattern="[0-9]{10}" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">City</label>
<input type="text" name="city" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Username</label>
<input type="text" name="username" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Role</label>
<select name="role" class="form-select" required>
<option value="">-- Select Role --</option>

<option value="OWNER">OWNER</option>

<option value="INSURANCE">INSURANCE</option>
<!--<option value="TRAFFIC">TRAFFIC</option>
<option value="POLICE">POLICE</option>
<option value="RTO">RTO</option>
<option value="PCB">PCB</option>-->
</select>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Password</label>
<div class="input-group">
<input type="password" name="password" id="password" class="form-control" required>
<span class="input-group-text" onclick="togglePassword('password',this)">
<i class="fa-solid fa-eye"></i>
</span>
</div>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Confirm Password</label>
<div class="input-group">
<input type="password" id="confirmPassword" class="form-control" required>
<span class="input-group-text" onclick="togglePassword('confirmPassword',this)">
<i class="fa-solid fa-eye"></i>
</span>
</div>
</div>

<div class="col-12 mb-3">
<label class="form-label">Address</label>
<textarea name="address" class="form-control" rows="3" required></textarea>
</div>

</div>

<div class="d-grid mt-3">
<button type="submit" class="btn btn-primary">
<i class="fa-solid fa-user-check me-2"></i>
Register
</button>
</div>

</form>

</div>
</div>

</div>

<script>
function togglePassword(fieldId, element){
    const input=document.getElementById(fieldId);
    const icon=element.querySelector("i");

    if(input.type==="password"){
        input.type="text";
        icon.classList.replace("fa-eye","fa-eye-slash");
    }else{
        input.type="password";
        icon.classList.replace("fa-eye-slash","fa-eye");
    }
}

function validateForm(){
    const pass=document.getElementById("password").value;
    const confirm=document.getElementById("confirmPassword").value;

    if(pass!==confirm){
        alert("Passwords do not match!");
        return false;
    }
    return true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
