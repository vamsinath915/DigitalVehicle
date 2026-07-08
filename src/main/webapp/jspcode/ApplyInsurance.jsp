<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%
String username = session.getAttribute("username").toString();
PreparedStatement ps=null;
String instype="New";

/* APPLY POLICY */

if(request.getParameter("apply_policy")!=null){

String vehicle_number=request.getParameter("vehicle_number");
String owner_id=request.getParameter("owner_id");
String policy_id=request.getParameter("policy_id");

PreparedStatement ps2=con.prepareStatement(
"INSERT INTO vehicle_insurance_applications(vehicle_number,owner_id,policy_id,instype) VALUES(?,?,?,?)");

ps2.setString(1,vehicle_number);
ps2.setString(2,owner_id);
ps2.setString(3,policy_id);
ps2.setString(4,instype);
ps2.executeUpdate();

out.println("<script>alert('Insurance Policy Applied Successfully')</script>");

}

%>

<!DOCTYPE html>
<html>
<head>

<title>Apply Insurance Policy</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>

body{
background:#f4f6f9;
font-family:Arial;
}

.card{
border-radius:10px;
box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.page-title{
background:#2b6edc;
color:white;
padding:15px;
border-radius:10px;
margin-bottom:20px;
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="page-title">
Apply for Insurance Policy
</div>

<div class="card">

<div class="card-body">

<form method="post">

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">Vehicle Number</label>

<input type="text" name="vehicle_number" class="form-control"
placeholder="AP09AB1234" required>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">Owner ID</label>

<input type="text" name="owner_id" class="form-control"
value="<%=session.getAttribute("username")%>" readonly>

</div>

</div>

<div class="mb-3">

<label class="form-label">Select Policy</label>

<select name="policy_id" class="form-control">

<option>Select Policy</option>

<%

PreparedStatement psp=con.prepareStatement(
"SELECT * FROM insurance_policies");

ResultSet rs=psp.executeQuery();

while(rs.next()){

%>

<option value="<%=rs.getInt("policy_id")%>">

<%=rs.getString("policy_name")%> |
Vehicle: <%=rs.getString("vehicle_type")%> |
Premium: ₹<%=rs.getString("premium_amount")%>

</option>

<%
}
%>

</select>

</div>

<div class="text-center mt-3">

<button class="btn btn-primary px-4"
name="apply_policy">

Apply Policy

</button>

</div>

</form>

</div>

</div>

</div>

</body>
</html>