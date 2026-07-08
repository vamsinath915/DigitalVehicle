<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%


PreparedStatement ps=null;
ResultSet rs=null;



%>

<!DOCTYPE html>
<html>
<head>

<title>Traffic Challan Details</title>

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
border-radius:10px;
box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.badge-paid{
background:#28a745;
}

.badge-unpaid{
background:#dc3545;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="page-title">
<i class="bi bi-receipt"></i> Traffic Challan Details
</div>

<div class="card">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead class="table-light">

<tr>

<th>Challan ID</th>
<th>Vehicle Number</th>
<th>Owner Name</th>
<th>Violation</th>
<th>Fine Amount</th>
<th>Location</th>
<th>Challan Date</th>
<th>Status</th>

</tr>

</thead>

<tbody>

<%

ps=con.prepareStatement("SELECT * FROM traffic_challans ORDER BY challan_date DESC");

rs=ps.executeQuery();

while(rs.next()){

String status=rs.getString("status");

%>

<tr>

<td><%=rs.getInt("challan_id")%></td>

<td><%=rs.getString("vehicle_number")%></td>

<td><%=rs.getString("owner_name")%></td>

<td><%=rs.getString("violation_type")%></td>

<td>₹<%=rs.getString("fine_amount")%></td>

<td><%=rs.getString("location")%></td>

<td><%=rs.getString("challan_date")%></td>

<td>

<%

if(status.equals("Paid")){
%>

<span class="badge badge-paid">
<i class="bi bi-check-circle"></i> Paid
</span>

<%
}else{
%>

<span class="badge badge-unpaid">
<i class="bi bi-exclamation-circle"></i> Unpaid
</span>

<%
}
%>

</td>

</tr>

<%
}
%>

</tbody>

</table>

</div>

</div>

</div>

</div>

</body>
</html>