<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%

if(request.getParameter("create_policy")!=null){

String policy_name=request.getParameter("policy_name");
String vehicle_type=request.getParameter("vehicle_type");
String insurance_company=request.getParameter("insurance_company");
String policy_type=request.getParameter("policy_type");
String coverage_details=request.getParameter("coverage_details");
String premium_amount=request.getParameter("premium_amount");
String policy_duration=request.getParameter("policy_duration");

try{

PreparedStatement ps=con.prepareStatement(
"INSERT INTO insurance_policies(policy_name,vehicle_type,insurance_company,policy_type,coverage_details,premium_amount,policy_duration) VALUES(?,?,?,?,?,?,?)");

ps.setString(1,policy_name);
ps.setString(2,vehicle_type);
ps.setString(3,insurance_company);
ps.setString(4,policy_type);
ps.setString(5,coverage_details);
ps.setString(6,premium_amount);
ps.setString(7,policy_duration);

ps.executeUpdate();

out.println("<script>alert('Policy Created Successfully')</script>");

}catch(Exception e){
out.println(e);
}

}

%>

<!DOCTYPE html>
<html>
<head>

<title>Create Insurance Policy</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>

body{
background:#f4f6f9;
font-family:Arial;
}

.sidebar{
width:220px;
height:100vh;
background:#1f2d3d;
position:fixed;
padding-top:20px;
}

.sidebar a{
display:block;
color:#cfd8dc;
padding:12px 20px;
text-decoration:none;
}

.sidebar a:hover{
background:#2f4050;
color:white;
}

.main{
margin-left:30px;
padding:30px;
}

.card{
border-radius:10px;
box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.header-title{
background:#2b6edc;
color:white;
padding:15px;
border-radius:10px;
margin-bottom:20px;
font-weight:600;
}

.btn-primary{
background:#2b6edc;
border:none;
}

</style>

</head>

<body>


<!-- Main Content -->

<div class="main">

<div class="header-title">
Create Insurance Policy
</div>

<div class="card">

<div class="card-body">

<form method="post">

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">Policy Name</label>

<input type="text" name="policy_name" class="form-control" required>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">Vehicle Type</label>

<select name="vehicle_type" class="form-control">

<option>Two Wheeler</option>
<option>Car</option>
<option>SUV</option>
<option>Truck</option>
<option>Bus</option>

</select>

</div>

</div>

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">Insurance Company</label>

<select name="insurance_company" class="form-control">
<option>SBI</option>
<option>ICICI Lombard</option>
<option>HDFC ERGO</option>
<option>Bajaj Allianz</option>
<option>TATA AIG</option>

</select>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">Policy Type</label>

<select name="policy_type" class="form-control">

<option>Comprehensive</option>
<option>Third Party</option>
<option>Zero Depreciation</option>

</select>

</div>

</div>

<div class="mb-3">

<label class="form-label">Coverage Details</label>

<textarea name="coverage_details" class="form-control" rows="3"></textarea>

</div>

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">Premium Amount (₹)</label>

<input type="number" name="premium_amount" class="form-control" required>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">Policy Duration (Months)</label>

<input type="number" name="policy_duration" class="form-control" required>

</div>

</div>

<div class="text-center mt-3">

<button type="submit" name="create_policy" class="btn btn-primary px-4">
Create Policy
</button>

<button type="reset" class="btn btn-secondary px-4">
Reset
</button>

</div>

</form>

</div>

</div>

</div>

</body>
</html>