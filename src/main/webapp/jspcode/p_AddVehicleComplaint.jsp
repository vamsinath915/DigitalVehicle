<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>
<%


PreparedStatement ps=null;

String username = session.getAttribute("username").toString();


if(request.getParameter("add_complaint")!=null){

String vehicle_number=request.getParameter("vehicle_number");
String complaint_type=request.getParameter("complaint_type");
String description=request.getParameter("description");
String location=request.getParameter("location");
String officer_name=request.getParameter("officer_name");
String police_station=request.getParameter("police_station");

ps=con.prepareStatement(
"INSERT INTO vehicle_complaints(vehicle_number,complaint_type,description,location,officer_name,police_station,complaint_date,status,officer_id) VALUES(?,?,?,?,?,?,CURDATE(),'Open',?)");

ps.setString(1,vehicle_number);
ps.setString(2,complaint_type);
ps.setString(3,description);
ps.setString(4,location);
ps.setString(5,officer_name);
ps.setString(6,police_station);
ps.setString(7,username);

ps.executeUpdate();

out.println("<script>alert('Complaint Added Successfully')</script>");

}

%>

<!DOCTYPE html>
<html>
<head>

<title>Add Vehicle Complaint</title>

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
background:#0d6efd;
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
background:#0d6efd;
color:white;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="page-title">
<i class="bi bi-exclamation-diamond"></i>
Add Vehicle Complaint
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

<label class="form-label">Complaint Type</label>

<select name="complaint_type" class="form-select" required>

<option value="">Select Complaint</option>
<option>Stolen Vehicle</option>
<option>Illegal Modification</option>
<option>Fake Number Plate</option>
<option>Suspicious Vehicle</option>
<option>Accident Case</option>

</select>

</div>

</div>

<div class="mb-3">

<label class="form-label">Complaint Description</label>

<textarea
name="description"
class="form-control"
rows="4"
placeholder="Enter Complaint Details"
required></textarea>

</div>

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">Location</label>

<input type="text"
name="location"
class="form-control"
placeholder="Enter Location">

</div>

<div class="col-md-6 mb-3">

<label class="form-label">Police Officer Name</label>

<input type="text"
name="officer_name"
class="form-control"
placeholder="Enter Officer Name">

</div>

</div>

<div class="mb-3">

<label class="form-label">Police Station</label>

<input type="text"
name="police_station"
class="form-control"
placeholder="Enter Police Station">

</div>

<div class="text-center mt-3">

<button type="submit"
name="add_complaint"
class="btn btn-submit px-4">

<i class="bi bi-plus-circle"></i>
Register Complaint

</button>

</div>

</form>

</div>

</div>

</div>

</body>
</html>