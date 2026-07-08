<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%

String username = session.getAttribute("username").toString();
PreparedStatement ps=null;




if(request.getParameter("add_challan")!=null){

String vehicle_number=request.getParameter("vehicle_number");
String owner_name=request.getParameter("owner_name");
String violation_type=request.getParameter("violation_type");
String fine_amount=request.getParameter("fine_amount");
String location=request.getParameter("location");

ps=con.prepareStatement(
"INSERT INTO traffic_challans(vehicle_number,owner_name,violation_type,fine_amount,location,challan_date,status, officer_id) VALUES(?,?,?,?,?,CURDATE(),'Unpaid',?)");

ps.setString(1,vehicle_number);
ps.setString(2,owner_name);
ps.setString(3,violation_type);
ps.setString(4,fine_amount);
ps.setString(5,location);
ps.setString(6,username);
ps.executeUpdate();

out.println("<script>alert('Traffic Challan Added Successfully')</script>");

}

%>

<!DOCTYPE html>
<html>
<head>

<title>Add Traffic Challan</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>

body{
background:#f4f6f9;
font-family:Arial;
}

.page-title{
background:#dc3545;
color:white;
padding:15px;
border-radius:8px;
margin-bottom:20px;
}

.card{
border-radius:12px;
box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.btn-submit{
background:#dc3545;
color:white;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="page-title">
<i class="bi bi-exclamation-triangle"></i>
Add Traffic Challan
</div>

<div class="card">

<div class="card-body">

<form method="post">

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">Vehicle Number</label>

<input type="text"
name="vehicle_number"
class="form-control"
placeholder="Enter Vehicle Number"
required>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">Owner Name</label>

<input type="text"
name="owner_name"
class="form-control"
placeholder="Enter Owner Name"
required>

</div>

</div>

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">Violation Type</label>

<select name="violation_type" class="form-select" required>

<option value="">Select Violation</option>
<option>Over Speeding</option>
<option>No Helmet</option>
<option>No Seatbelt</option>
<option>Signal Jump</option>
<option>Drunk Driving</option>
<option>Parking Violation</option>

</select>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">Fine Amount (₹)</label>

<input type="number"
name="fine_amount"
class="form-control"
placeholder="Enter Fine Amount"
required>

</div>

</div>

<div class="row">

<div class="col-md-12 mb-3">

<label class="form-label">Violation Location</label>

<input type="text"
name="location"
class="form-control"
placeholder="Enter Violation Location">

</div>

</div>

<div class="text-center mt-3">

<button type="submit"
name="add_challan"
class="btn btn-submit px-4">

<i class="bi bi-plus-circle"></i>
Add Challan

</button>

</div>

</form>

</div>

</div>

</div>

</body>
</html>