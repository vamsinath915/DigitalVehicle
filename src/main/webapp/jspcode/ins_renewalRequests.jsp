<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%

PreparedStatement ps=null;
ResultSet rs=null;


/* APPROVE REQUEST */

if(request.getParameter("approve_id")!=null){

String id=request.getParameter("approve_id");

PreparedStatement ps1=con.prepareStatement(
"UPDATE vehicle_insurance_applications SET status='Approved',issue_date=CURDATE(),expiry_date=DATE_ADD(CURDATE(),INTERVAL 1 YEAR) WHERE application_id=?");

ps1.setString(1,id);

ps1.executeUpdate();

out.println("<script>alert('Insurance Approved')</script>");

}


/* REJECT REQUEST */

if(request.getParameter("reject_id")!=null){

String id=request.getParameter("reject_id");

PreparedStatement ps2=con.prepareStatement(
"UPDATE vehicle_insurance_applications SET status='Rejected' WHERE application_id=?");

ps2.setString(1,id);

ps2.executeUpdate();

out.println("<script>alert('Insurance Rejected')</script>");

}

%>

<!DOCTYPE html>
<html>
<head>

<title>Insurance Requests</title>

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
background:#4B1AFF;
color:white;
padding:15px;
border-radius:8px;
margin-bottom:20px;
}

.card{
border-radius:10px;
box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.actions{
display:flex;
gap:8px;
}

.icon-btn{
border:none;
padding:6px 10px;
border-radius:5px;
}

.approve{
background:#28a745;
color:white;
}

.reject{
background:#dc3545;
color:white;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="page-title">
Pending Insurance Requests
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
"WHERE a.instype='Renewal' and a.status='Pending'");

rs=ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getInt("application_id")%></td>

<td><%=rs.getString("vehicle_number")%></td>

<td><%=rs.getString("policy_name")%></td>

<td><%=rs.getString("insurance_company")%></td>

<td>₹<%=rs.getString("premium_amount")%></td>

<td>
<span class="badge bg-warning">Pending</span>
</td>

<td>

<div class="actions">

<a href="ins_newrequests.jsp?approve_id=<%=rs.getInt("application_id")%>"
class="icon-btn approve"
title="Approve">

<i class="bi bi-check-lg"></i>

</a>

<a href="ins_newrequests.jsp?reject_id=<%=rs.getInt("application_id")%>"
class="icon-btn reject"
title="Reject"
onclick="return confirm('Reject this request?')">

<i class="bi bi-x-lg"></i>

</a>

</div>

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