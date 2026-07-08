<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>
<%

PreparedStatement ps=null;
ResultSet rs=null;

String username = session.getAttribute("username").toString();

String vehicle_number=request.getParameter("vehicle_number");
%>

<!DOCTYPE html>
<html>
<head>

<title>Track Vehicle</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>

body{
background:#eef2f7;
font-family:Segoe UI;
}

.page-title{
background:linear-gradient(45deg,#0d6efd,#3a8bfd);
color:white;
padding:18px;
border-radius:8px;
font-size:22px;
margin-bottom:20px;
}

.search-box{
background:white;
padding:20px;
border-radius:10px;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
margin-bottom:20px;
}

.card{
border-radius:10px;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
margin-bottom:15px;
}

.card-header{
cursor:pointer;
display:flex;
justify-content:space-between;
align-items:center;
font-weight:bold;
}

.card-content{
display:none;
padding:15px;
}

.toggle-icon{
font-size:20px;
font-weight:bold;
}

</style>

<script>

function toggleCard(id,icon){

let content=document.getElementById(id);

if(content.style.display==="block"){
content.style.display="none";
icon.innerHTML="+";
}else{
content.style.display="block";
icon.innerHTML="-";
}

}

</script>

</head>

<body>

<div class="container mt-4">

<div class="page-title">
<i class="bi bi-search"></i> Track Vehicle Details
</div>


<div class="search-box">

<form method="get">

<div class="row">

<div class="col-md-10">

<input type="text"
name="vehicle_number"
class="form-control"
placeholder="Enter Vehicle Number"
required>

</div>

<div class="col-md-2">

<button class="btn btn-primary w-100">
<i class="bi bi-search"></i> Search
</button>

</div>

</div>

</form>

</div>


<%
if(vehicle_number!=null){
%>


<!-- Vehicle Details -->

<div class="card">

<div class="card-header bg-primary text-white"
onclick="toggleCard('vehicle_card',this.querySelector('.toggle-icon'))">

<span>Vehicle Registration Details</span>
<span class="toggle-icon">+</span>

</div>

<div class="card-content" id="vehicle_card">


<table class="table table-bordered">

<tr>
<th>Vehicle Number</th>
<th>Vehicle Type</th>
<th>Model</th>
<th>Registration Date</th>
</tr>

<%

ps=con.prepareStatement(
"SELECT * FROM vehicles WHERE vehicle_number=?");

ps.setString(1,vehicle_number);

rs=ps.executeQuery();

if(rs.next()){
%>

<tr>

<td><%=rs.getString("vehicle_number")%></td>
<td><%=rs.getString("vehicle_type")%></td>
<td><%=rs.getString("model")%></td>
<td><%=rs.getString("registration_date")%></td>


</tr>

<%
}
else
{
    out.println("No Vehicle Found");
}
%>

</table>
</div>

</div>



<!-- Owner Details -->

<div class="card">

<div class="card-header bg-success text-white"
onclick="toggleCard('owner_card',this.querySelector('.toggle-icon'))">

<span>Owner Details</span>
<span class="toggle-icon">+</span>

</div>

<div class="card-content" id="owner_card">

<table class="table table-bordered">

<tr>
<th>Full Name</th>
<th>Mobile</th>
<th>Email</th>
<th>Address</th>
</tr>

<%

ps=con.prepareStatement(
"SELECT u.* FROM vehicles v JOIN users u ON v.owner_id=u.uid WHERE v.vehicle_number=?");

ps.setString(1,vehicle_number);

rs=ps.executeQuery();

while(rs.next()){
%>

<tr>

<td><%=rs.getString("full_name")%></td>
<td><%=rs.getString("mobile")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("address")%></td>


</tr>

<%
}
%>

</table>

</div>

</div>



<!-- Pollution Certificate -->

<div class="card">

<div class="card-header bg-info text-white"
onclick="toggleCard('pollution_card',this.querySelector('.toggle-icon'))">

<span>Pollution Certificate</span>
<span class="toggle-icon">+</span>

</div>
<div class="card-content" id="pollution_card">
<table class="table table-bordered">

<tr>
<th>Certificate ID</th>
<th>Issue Date</th>
<th>Expiry Date</th>

</tr>

<%

ps=con.prepareStatement(
"SELECT * FROM pollution_certificates WHERE vehicle_number=?");

ps.setString(1,vehicle_number);

rs=ps.executeQuery();

while(rs.next()){
%>

<tr>

<td><%=rs.getString("certificate_id")%></td>
<td><%=rs.getString("issue_date")%></td>
<td><%=rs.getString("expiry_date")%></td>


</tr>

<%
}
%>

</table>


</div>

</div>

<!-- Insurance -->

<div class="card">

<div class="card-header bg-secondary text-white"
onclick="toggleCard('insurance_card',this.querySelector('.toggle-icon'))">

<span>Insurance Details</span>
<span class="toggle-icon">+</span>

</div>

<div class="card-content" id="insurance_card">

<table class="table table-bordered">

<tr>
<th>Insurance ID</th>
<th>Fine</th>
<th>Date</th>
<th>Status</th>
</tr>

<%

ps=con.prepareStatement(
"SELECT * FROM vehicle_insurance_applications WHERE vehicle_number=?");

ps.setString(1,vehicle_number);

rs=ps.executeQuery();

while(rs.next()){
%>

<tr>

<td><%=rs.getString("owner_id")%></td>
<td>₹<%=rs.getDate("issue_date")%></td>
<td><%=rs.getDate("expiry_date")%></td>
<td><%=rs.getString("status")%></td>

</tr>

<%
}
%>

</table>

</div>

</div>

<!-- Traffic Challans -->

<div class="card">

<div class="card-header bg-danger text-white"
onclick="toggleCard('challan_card',this.querySelector('.toggle-icon'))">

<span>Traffic Challans</span>
<span class="toggle-icon">+</span>

</div>

<div class="card-content" id="challan_card">

<table class="table table-bordered">

<tr>
<th>Violation</th>
<th>Fine</th>
<th>Date</th>
<th>Status</th>
</tr>

<%

ps=con.prepareStatement(
"SELECT * FROM traffic_challans WHERE vehicle_number=?");

ps.setString(1,vehicle_number);

rs=ps.executeQuery();

while(rs.next()){
%>

<tr>

<td><%=rs.getString("violation_type")%></td>
<td>₹<%=rs.getString("fine_amount")%></td>
<td><%=rs.getString("challan_date")%></td>
<td><%=rs.getString("status")%></td>

</tr>

<%
}
%>

</table>

</div>

</div>



<!-- Vehicle Complaints -->

<div class="card">

<div class="card-header bg-warning"
onclick="toggleCard('complaint_card',this.querySelector('.toggle-icon'))">

<span>Vehicle Complaints</span>
<span class="toggle-icon">+</span>

</div>

<div class="card-content" id="complaint_card">

<table class="table table-bordered">

<tr>
<th>Complaint</th>
<th>Location</th>
<th>Date</th>
<th>Status</th>
</tr>

<%

ps=con.prepareStatement(
"SELECT * FROM vehicle_complaints WHERE vehicle_number=?");

ps.setString(1,vehicle_number);

rs=ps.executeQuery();

while(rs.next()){
%>

<tr>

<td><%=rs.getString("complaint_type")%></td>
<td><%=rs.getString("location")%></td>
<td><%=rs.getString("complaint_date")%></td>
<td><%=rs.getString("status")%></td>

</tr>

<%
}
%>

</table>

</div>

</div>

<%
}
%>

</div>

</body>
</html>