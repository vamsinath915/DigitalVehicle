<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>

<%

String username=session.getAttribute("username").toString();

PreparedStatement ps=null;
ResultSet rs=null;

/* PAYMENT UPDATE */

if(request.getParameter("pay_challan")!=null){

String challan_id=request.getParameter("challan_id");
String utir=request.getParameter("utir");

PreparedStatement ps2=con.prepareStatement(
"UPDATE traffic_challans SET status='Paid', UTIRNo=? WHERE challan_id=?");

ps2.setString(1, utir);
ps2.setString(2, challan_id);

ps2.executeUpdate();

out.println("<script>alert('Payment Successful');window.location='ViewChallans.jsp';</script>");

}

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

.pay-btn{
font-size:18px;
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
<th>Challan Date</th>
<th>UTIR NO</th>
<th>Status</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

ps=con.prepareStatement(
"SELECT tc.* FROM traffic_challans tc JOIN vehicles v "
+"ON tc.vehicle_number=v.vehicle_number "
+"WHERE v.owner_id=? ORDER BY tc.challan_date DESC");

ps.setString(1,username);

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

<td><%=rs.getString("challan_date")%></td>

<td><%=rs.getString("UTIRNo")%></td>

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

<td>

<%

if(status.equals("Unpaid")){
%>

<button class="btn btn-success btn-sm pay-btn"
data-bs-toggle="modal"
data-bs-target="#payModal"
onclick="setChallan('<%=rs.getInt("challan_id")%>')">

<i class="bi bi-credit-card"></i>

</button>

<%
}else{
%>

<i class="bi bi-check-circle text-success"></i>

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


<!-- Payment Modal -->

<div class="modal fade" id="payModal">

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5 class="modal-title">
<i class="bi bi-credit-card"></i> Pay Traffic Challan
</h5>

<button type="button" class="btn-close" data-bs-dismiss="modal"></button>

</div>

<div class="modal-body text-center">

    <img src="images/QR.jpeg" width="200">

<p class="mt-2">Scan QR Code and complete the payment</p>

<form method="post">

<input type="hidden" name="challan_id" id="challan_id">

<input type="text"
name="utir"
class="form-control"
placeholder="Enter UTR / UTIR Number"
required>

<br>

<button class="btn btn-primary w-100" name="pay_challan">

Submit Payment

</button>

</form>

</div>

</div>

</div>

</div>


<script>

function setChallan(id){

document.getElementById("challan_id").value=id;

}

</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>