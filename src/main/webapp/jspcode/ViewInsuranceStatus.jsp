<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%


PreparedStatement ps=null;
ResultSet rs=null;


String username=(String)session.getAttribute("username");

%>

<!DOCTYPE html>
<html>
<head>

<title>My Insurance Policies</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>

body{
background:#f4f6f9;
font-family:Arial;
}

.page-title{
background:#2b6edc;
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
color:green;
font-weight:bold;
}

.status-pending{
color:orange;
font-weight:bold;
}

.status-rejected{
color:red;
font-weight:bold;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="page-title">
My Insurance Status
</div>

<div class="card">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead class="table-light">

<tr>

<th>Vehicle Number</th>
<th>Policy Name</th>
<th>Insurance Company</th>
<th>Premium</th>
<th>Issue Date</th>
<th>Expiry Date</th>
<th>Status</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

ps=con.prepareStatement(

"SELECT a.*,p.policy_name,p.insurance_company,p.premium_amount "+
"FROM vehicle_insurance_applications a "+
"JOIN insurance_policies p ON a.policy_id=p.policy_id "+
"WHERE owner_id=?");

ps.setString(1,username);

rs=ps.executeQuery();

while(rs.next()){

String status=rs.getString("status");

%>

<tr>

<td><%=rs.getString("vehicle_number")%></td>

<td><%=rs.getString("policy_name")%></td>

<td><%=rs.getString("insurance_company")%></td>

<td>₹<%=rs.getString("premium_amount")%></td>

<td><%=rs.getString("issue_date")%></td>

<td><%=rs.getString("expiry_date")%></td>

<td>

<%

if(status.equals("Approved")){

%>

<span class="status-approved">Approved</span>

<%
}
else if(status.equals("Pending")){
%>

<span class="status-pending">Pending</span>

<%
}
else{
%>

<span class="status-rejected">Rejected</span>

<%
}
%>

</td>

<td>

<%

java.sql.Date expiry=rs.getDate("expiry_date");

if(expiry!=null){

java.util.Date today=new java.util.Date();

if(today.after(expiry)){

%>

<a href="RenewPolicy.jsp?id=<%=rs.getInt("application_id")%>"
class="btn btn-warning btn-sm">

Renew

</a>

<%
}
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