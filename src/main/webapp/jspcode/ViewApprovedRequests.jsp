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

<title>Approved Insurance Requests</title>

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
background:#198754;
color:white;
padding:15px;
border-radius:8px;
margin-bottom:20px;
}

.card{
border-radius:10px;
box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.status-approved{
color:#198754;
font-weight:bold;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="page-title">
Approved Insurance Requests
</div>

<div class="card">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead class="table-light">

<tr>

<th>Application ID</th>
<th>Vehicle Number</th>
<th>Policy Name</th>
<th>Insurance Company</th>
<th>Premium</th>
<th>Issue Date</th>
<th>Expiry Date</th>
<th>Status</th>

</tr>

</thead>

<tbody>

<%

ps=con.prepareStatement(

"SELECT a.*,p.policy_name,p.insurance_company,p.premium_amount "+
"FROM vehicle_insurance_applications a "+
"JOIN insurance_policies p ON a.policy_id=p.policy_id "+
"WHERE a.instype='New' and a.status='Approved'");

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getInt("application_id")%></td>

<td><%=rs.getString("vehicle_number")%></td>

<td><%=rs.getString("policy_name")%></td>

<td><%=rs.getString("insurance_company")%></td>

<td>₹<%=rs.getString("premium_amount")%></td>

<td><%=rs.getString("issue_date")%></td>

<td><%=rs.getString("expiry_date")%></td>

<td>

<span class="badge bg-success">
<i class="bi bi-check-circle"></i> Approved
</span>

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