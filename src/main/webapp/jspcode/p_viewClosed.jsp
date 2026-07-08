<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%
String username = session.getAttribute("username").toString();

PreparedStatement ps=null;
ResultSet rs=null;



%>

<!DOCTYPE html>
<html>
<head>

<title>Vehicle Complaints</title>

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

.badge-open{
background:#ffc107;
color:black;
}

.badge-investigation{
background:#0d6efd;
}

.badge-closed{
background:#28a745;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="page-title">

<i class="bi bi-exclamation-triangle"></i>
Vehicle Complaint Records

</div>

<div class="card">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead class="table-light">

<tr>

<th>ID</th>
<th>Vehicle Number</th>
<th>Complaint Type</th>
<th>Description</th>
<th>Location</th>
<th>Officer</th>
<th>Police Station</th>
<th>Date</th>
<th>Status</th>

</tr>

</thead>

<tbody>

<%

ps=con.prepareStatement(
"SELECT * FROM vehicle_complaints where status='Closed' ORDER BY complaint_date DESC");

rs=ps.executeQuery();

while(rs.next()){

String status=rs.getString("status");

%>

<tr>

<td><%=rs.getInt("complaint_id")%></td>

<td><%=rs.getString("vehicle_number")%></td>

<td><%=rs.getString("complaint_type")%></td>

<td><%=rs.getString("description")%></td>

<td><%=rs.getString("location")%></td>

<td><%=rs.getString("officer_name")%></td>

<td><%=rs.getString("police_station")%></td>

<td><%=rs.getString("complaint_date")%></td>

<td>

<%

if(status.equals("Open")){
%>

<span class="badge badge-open">
<i class="bi bi-clock"></i> Open
</span>

<%
}
else if(status.equals("Under Investigation")){
%>

<span class="badge badge-investigation">
<i class="bi bi-search"></i> Investigating
</span>

<%
}
else{
%>

<span class="badge badge-closed">
<i class="bi bi-check-circle"></i> Closed
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