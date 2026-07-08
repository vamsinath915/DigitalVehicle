<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>
<%@ page import="java.util.Date" %>

<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("v_login.jsp");
    return;
}

String ownerId = null;

/* ================= GET USER ================= */

PreparedStatement psUser = con.prepareStatement(
"SELECT uid FROM users WHERE uid=?"
);

psUser.setString(1, username);
ResultSet rsUser = psUser.executeQuery();

if(rsUser.next()){
    ownerId = rsUser.getString("uid");
}

/* ================= RENEWAL REQUEST INSERT ================= */

String message = "";

if("POST".equalsIgnoreCase(request.getMethod())){

    String licenseId = request.getParameter("licenseId");

    PreparedStatement checkRenew = con.prepareStatement(
    "SELECT * FROM license_requests WHERE owner_id=? AND request_type='Renewal' AND status='Pending'"
    );

    checkRenew.setString(1, ownerId);
    ResultSet rsCheck = checkRenew.executeQuery();

    if(!rsCheck.next()){

        PreparedStatement insertReq = con.prepareStatement(
        "INSERT INTO license_requests(owner_id, request_type, request_date, status) VALUES(?, 'Renewal', CURDATE(), 'Pending')"
        );

        insertReq.setString(1, ownerId);
        insertReq.executeUpdate();

        message = "Renewal Request Submitted Successfully!";

    }else{
        message = "You already have a pending renewal request.";
    }
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>License Details</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background: linear-gradient(135deg,#e3f2fd,#f8f9fa);
}

/* Header */

.page-header{
background: linear-gradient(135deg,#0d6efd,#6610f2);
color:white;
padding:25px;
border-radius:15px;
box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

/* Table Card */

.table-card{
background:white;
border-radius:20px;
box-shadow:0 15px 35px rgba(0,0,0,0.1);
padding:30px;
}

.table thead{
background: linear-gradient(135deg,#0d6efd,#6610f2);
color:white;
}

.table tbody tr:hover{
background-color:#f1f7ff;
transform:scale(1.01);
transition:0.3s;
}

/* Badges */

.badge{
padding:8px 14px;
border-radius:20px;
}

.badge-pending{ background:#ffc107; color:black; }
.badge-approved{ background:#198754; }
.badge-rejected{ background:#dc3545; }

/* Renewal Button */

.renew-btn{
background: linear-gradient(135deg,#20c997,#0dcaf0);
border:none;
color:white;
padding:6px 15px;
border-radius:25px;
transition:0.3s;
}

.renew-btn:hover{
transform:scale(1.05);
box-shadow:0 8px 20px rgba(0,0,0,0.2);
}

</style>

</head>

<body>

<div class="container mt-5">

<!-- Header -->

<div class="page-header text-center mb-4">
<h3>License Details</h3>
<p>Manage and Renew Your License</p>
</div>

<% if(!message.equals("")){ %>

<div class="alert alert-info text-center">
<%= message %>
</div>

<% } %>

<!-- Table Section -->

<div class="table-card">

<div class="table-responsive">

<table class="table table-bordered text-center align-middle">

<thead>

<tr>
<th>License ID</th>
<th>License Number</th>
<th>License Type</th>
<th>Issue Date</th>
<th>Expiry Date</th>
<th>Status</th>
<th>Action</th>
</tr>

</thead>

<tbody>

<%

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM licenses WHERE owner_id=? ORDER BY license_id DESC"
);

ps.setString(1, ownerId);

ResultSet rs = ps.executeQuery();

boolean found = false;

Date currentDate = new Date();

while(rs.next()){

found = true;

String status = rs.getString("status");

Date expiryDate = rs.getDate("expiry_date");

boolean enableRenewal = false;

if(expiryDate != null){

enableRenewal = currentDate.after(expiryDate) || currentDate.equals(expiryDate);

}

%>

<tr>

<td><%= rs.getInt("license_id") %></td>

<td>
<strong><%= rs.getString("license_number") %></strong>
</td>

<td><%= rs.getString("license_type") %></td>

<td><%= rs.getDate("issue_date") %></td>

<td>

<% if(expiryDate != null){ %>

<%= expiryDate %>

<% } else { %>

<span class="text-muted">Not Available</span>

<% } %>

</td>

<td>

<% if(status.equals("Pending")){ %>

<span class="badge badge-pending">Pending</span>

<% } else if(status.equals("Approved")){ %>

<span class="badge badge-approved">Approved</span>

<% } else { %>

<span class="badge badge-rejected">Rejected</span>

<% } %>

</td>

<td>

<% if(status.equals("Approved") && enableRenewal){ %>

<form method="post">

<input type="hidden" name="licenseId"
value="<%= rs.getInt("license_id") %>">

<button type="submit"
class="renew-btn">

Request Renewal

</button>

</form>

<% } else { %>

<span class="text-muted">Not Eligible</span>

<% } %>

</td>

</tr>

<%

}

if(!found){

%>

<tr>

<td colspan="7" class="text-muted">

No License Records Found

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

</body>
</html>