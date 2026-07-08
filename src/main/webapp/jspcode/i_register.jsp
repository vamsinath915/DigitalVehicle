<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>

<%
PreparedStatement ps=null;
String message=null;
String alertType=null;
boolean submitted=false;

try{
    if("POST".equalsIgnoreCase(request.getMethod())){
        submitted=true;

        String companyName=request.getParameter("company_name");
        String email=request.getParameter("contact_email");
        String phone=request.getParameter("contact_phone");
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        String address=request.getParameter("address");
        String city=request.getParameter("city");

        String role="INSURANCE";
        String status = "Inactive";
        //String hashedPassword=Integer.toHexString(password.hashCode());
        String userId = null;
        int generatedAutoIncrementId = 0;
        
        String sql = "SELECT count(company_id) FROM insurance_companies where role=?";
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
        
        userId = "INS_"+ String.format("%03d", generatedAutoIncrementId);
        String query="INSERT INTO insurance_companies " +
                     "(company_name, contact_email, contact_phone, role, address, city, username, password, status, uid) " +
                     "VALUES(?,?,?,?,?,?,?,?,?,?)";

        ps=con.prepareStatement(query);
        ps.setString(1,companyName);
        ps.setString(2,email);
        ps.setString(3,phone);
        ps.setString(4,role);
        ps.setString(5,address);
        ps.setString(6,city);
        ps.setString(7,username);
        ps.setString(8,password);
        ps.setString(9,status);
        ps.setString(10,userId);

        int i=ps.executeUpdate();

        if(i>0){
            message="Registration Successful! Waiting for Admin Approval."+" USER ID:"+userId;
            alertType="success";
        }else{
            message="Registration Failed!";
            alertType="danger";
        }
    }

}catch(Exception e){
    submitted=true;
    message="Error: "+e.getMessage();
    alertType="danger";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insurance Company Registration</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    background: url('images/bg_f.jpg');
    background-size: cover;
    font-family:'Segoe UI',sans-serif;
}

/* Navbar */
.navbar-brand img{
    margin-right:10px;
}

.brand-text{
    font-weight:600;
    font-size:18px;
    color:#0d6efd;
}

/* Card Layout */
.main-wrapper{
    padding:60px 0;
}

.card{
    width:100%;
    max-width:950px;
    margin:auto;
    border-radius:12px;
    box-shadow:0 6px 20px rgba(0,0,0,0.25);
    border:none;
}

.card-header{
    background:#0d6efd;
    color:white;
    font-size:18px;
    font-weight:600;
    text-align:center;
    padding:12px;
}

.card-body{
    padding:25px 35px;
}

.form-control{
    border:1.5px solid #bfc9d4;
    border-radius:6px;
    height:44px;
    font-size:14px;
}

textarea.form-control{
    height:80px;
    resize:none;
}

.form-control:focus{
    border-color:#0d6efd;
    box-shadow:none;
}

.btn-register{
    background:#0d6efd;
    border:none;
    padding:9px 35px;
    font-weight:600;
    border-radius:6px;
    color:#fff;
}

.password-wrapper{
    position:relative;
}

.password-wrapper i{
    position:absolute;
    top:50%;
    right:12px;
    transform:translateY(-50%);
    cursor:pointer;
    color:#6c757d;
}
</style>

</head>

<body>

    <!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
            <img src="images/vehicle.png" width="60" height="54">
            <span class="brand-text">Digital Vehicle Information</span>
        </a>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="menu.jsp">Logins</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
    <div class="main-wrapper">
<div class="card">

<div class="card-header">
    <i class="fa-solid fa-building"></i> Insurance Company Registration
</div>

<div class="card-body">

    <% if(submitted && message!=null){ %>
        <div class="alert alert-<%=alertType%> text-center py-2">
            <%=message%>
        </div>
    <% } %>

    <form method="post">

    <div class="row g-4">

        <div class="col-md-6">
            <input type="text" name="company_name" 
                   class="form-control" placeholder="Company Name" required>
        </div>

        <div class="col-md-6">
            <input type="email" name="contact_email" 
                   class="form-control" placeholder="Contact Email" required>
        </div>

        <div class="col-md-6">
            <input type="text" name="contact_phone" 
                   class="form-control"
                   placeholder="Contact Phone"
                   maxlength="10"
                   pattern="[0-9]{10}" required>
        </div>

        <div class="col-md-6">
            <input type="text" name="city" 
                   class="form-control" placeholder="City" required>
        </div>

        <!-- FULL WIDTH ADDRESS -->
        <div class="col-md-12">
            <textarea name="address" 
                      class="form-control" 
                      placeholder="Company Address" required></textarea>
        </div>

        <div class="col-md-6">
            <input type="text" name="username" 
                   class="form-control" placeholder="Username" required>
        </div>

        <div class="col-md-6">
            <div class="password-wrapper">
                <input type="password" name="password" id="password"
                       class="form-control" placeholder="Password" required>
                <i class="fa fa-eye" onclick="togglePassword()"></i>
            </div>
        </div>

    </div>

    <div class="text-center mt-4">
        <button type="submit" class="btn btn-register">
            <i class="fa fa-user-plus"></i> Register
        </button>
    </div>

</form>

</div>

</div>
</div>

<script>
function togglePassword(){
    var pwd=document.getElementById("password");
    var icon=document.querySelector(".password-wrapper i");

    if(pwd.type==="password"){
        pwd.type="text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    }else{
        pwd.type="password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}
</script>

</body>
</html>
