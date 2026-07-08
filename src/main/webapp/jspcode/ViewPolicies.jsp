<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%


PreparedStatement ps=null;
ResultSet rs=null;


/* DELETE POLICY */

if(request.getParameter("delete_id")!=null){

String id=request.getParameter("delete_id");

PreparedStatement psd=con.prepareStatement(
"DELETE FROM insurance_policies WHERE policy_id=?");

psd.setString(1,id);
psd.executeUpdate();

out.println("<script>alert('Policy Deleted Successfully')</script>");

}

/* UPDATE POLICY */

if(request.getParameter("update_policy")!=null){

String id=request.getParameter("policy_id");
String name=request.getParameter("policy_name");
String type=request.getParameter("vehicle_type");
String company=request.getParameter("insurance_company");
String ptype=request.getParameter("policy_type");
String coverage=request.getParameter("coverage_details");
String premium=request.getParameter("premium_amount");
String duration=request.getParameter("policy_duration");

PreparedStatement psu=con.prepareStatement(
"UPDATE insurance_policies SET policy_name=?,vehicle_type=?,insurance_company=?,policy_type=?,coverage_details=?,premium_amount=?,policy_duration=? WHERE policy_id=?");

psu.setString(1,name);
psu.setString(2,type);
psu.setString(3,company);
psu.setString(4,ptype);
psu.setString(5,coverage);
psu.setString(6,premium);
psu.setString(7,duration);
psu.setString(8,id);

psu.executeUpdate();

out.println("<script>alert('Policy Updated Successfully')</script>");

}

%>

<!DOCTYPE html>
<html>
<head>

<title>View Insurance Policies</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

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

.header-title{
background:#2b6edc;
color:white;
padding:15px;
border-radius:10px;
margin-bottom:20px;
}

.card{
border-radius:10px;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

table th{
background:#eef1f5;
}
.btn i{
font-size:16px;
}

.btn-success{
background:#28a745;
border:none;
}

.btn-danger{
background:#dc3545;
border:none;
}
.actions{
display:flex;
gap:8px;
align-items:center;
}

.actions i{
font-size:16px;
}
</style>

</head>

<body>


<!-- Main Content -->

<div class="main">

<div class="header-title">
View Insurance Policies
</div>

<div class="card">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-hover">

<thead>

<tr>

<th>ID</th>
<th>Policy Name</th>
<th>Vehicle Type</th>
<th>Company</th>
<th>Policy Type</th>
<th>Premium</th>
<th>Duration</th>
<th>Actions</th>

</tr>

</thead>

<tbody>

<%

ps=con.prepareStatement("SELECT * FROM insurance_policies ORDER BY policy_id DESC");
rs=ps.executeQuery();

while(rs.next()){

%>

<form method="post">

<tr>

<td>
<%=rs.getInt("policy_id")%>
<input type="hidden" name="policy_id" value="<%=rs.getInt("policy_id")%>">
</td>

<td>
<input type="text" name="policy_name" class="form-control"
value="<%=rs.getString("policy_name")%>">
</td>

<td>
<input type="text" name="vehicle_type" class="form-control"
value="<%=rs.getString("vehicle_type")%>">
</td>

<td>
<input type="text" name="insurance_company" class="form-control"
value="<%=rs.getString("insurance_company")%>">
</td>

<td>
<input type="text" name="policy_type" class="form-control"
value="<%=rs.getString("policy_type")%>">
</td>

<td>
<input type="text" name="premium_amount" class="form-control"
value="<%=rs.getString("premium_amount")%>">
</td>

<td>
<input type="text" name="policy_duration" class="form-control"
value="<%=rs.getString("policy_duration")%>">
</td>

<td>

<div class="d-flex gap-2">

<button name="update_policy" class="btn btn-success btn-sm" title="Update">

<i class="bi bi-pencil-square"></i>

</button>

<a href="ViewPolicies.jsp?delete_id=<%=rs.getInt("policy_id")%>"
class="btn btn-danger btn-sm"
title="Delete"
onclick="return confirm('Delete this policy?')">

<i class="bi bi-trash"></i>

</a>

</div>

</td>

</tr>

</form>

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