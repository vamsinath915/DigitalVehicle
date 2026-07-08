<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Insurance Companies</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background: transparent;   /* Important for iframe */
}

.page-wrapper{
    padding:30px;
}

.glass{
    background: rgba(255,255,255,0.18);
    backdrop-filter: blur(18px);
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.3);
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
    padding:30px;
}

.page-title{
    color:#fff;
    font-weight:600;
    margin-bottom:25px;
}

.table{
    background: rgba(255,255,255,0.25);
    border-radius:15px;
    overflow:hidden;
    color:#fff;
    vertical-align: middle;
}

.table thead{
    background: rgba(255,255,255,0.5);
    color:#222;
    font-weight:600;
}

.table tbody tr:hover{
    background: rgba(255,255,255,0.2);
}

.badge{
    font-size:13px;
    padding:7px 12px;
    border-radius:20px;
}

.btn-sm{
    border-radius:8px;
    padding:6px 10px;
}

.action-btn{
    display:flex;
    justify-content:center;
    gap:8px;
}

.alert{
    border-radius:12px;
}
</style>

</head>

<body>

<%
String message="";
String type="";

/* STATUS UPDATE LOGIC */
String activateId = request.getParameter("activate");
String deactivateId = request.getParameter("deactivate");

try{
    if(activateId != null){
        PreparedStatement ps = con.prepareStatement(
        "UPDATE insurance_companies SET status='Active' WHERE company_id=?");
        ps.setInt(1,Integer.parseInt(activateId));
        ps.executeUpdate();
        message="Company Activated Successfully!";
        type="success";
    }

    if(deactivateId != null){
        PreparedStatement ps = con.prepareStatement(
        "UPDATE insurance_companies SET status='Inactive' WHERE company_id=?");
        ps.setInt(1,Integer.parseInt(deactivateId));
        ps.executeUpdate();
        message="Company Deactivated Successfully!";
        type="warning";
    }

}catch(Exception e){
    message="Error: "+e.getMessage();
    type="danger";
}
%>

<div class="page-wrapper">
<div class="glass">

<h4 class="page-title">
<i class="fa-solid fa-building-circle-check"></i> Manage Insurance Companies
</h4>

<% if(!message.equals("")){ %>
<div class="alert alert-<%=type%>">
    <%=message%>
</div>
<% } %>

<div class="table-responsive">
<table class="table table-bordered table-hover text-center">

<thead>
<tr>
<th>ID</th>
<th>USER ID</th>
<th>Company Name</th>
<th>Email</th>
<th>Phone</th>
<th>City</th>
<th>Username</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>

<tbody>

<%
try{
PreparedStatement ps = con.prepareStatement(
"SELECT * FROM insurance_companies ORDER BY company_id ASC");
ResultSet rs = ps.executeQuery();

while(rs.next()){
String status = rs.getString("status");
%>

<tr>
<td><%=rs.getInt("company_id")%></td>
<td><%=rs.getString("uid")%></td>
<td><%=rs.getString("company_name")%></td>
<td><%=rs.getString("contact_email")%></td>
<td><%=rs.getString("contact_phone")%></td>
<td><%=rs.getString("city")%></td>
<td><%=rs.getString("username")%></td>

<td>
<% if(status.equals("Active")){ %>
<span class="badge bg-success">
<i class="fa fa-check-circle"></i> Active
</span>
<% } else { %>
<span class="badge bg-danger">
<i class="fa fa-times-circle"></i> Inactive
</span>
<% } %>
</td>

<td>
<div class="action-btn">

<% if(status.equals("Inactive")){ %>
<a href="manageInsuranceCompanies.jsp?activate=<%=rs.getInt("company_id")%>" 
   class="btn btn-success btn-sm"
   onclick="return confirm('Activate this company?');">
   <i class="fa fa-user-check"></i>
</a>
<% } else { %>
<a href="manageInsuranceCompanies.jsp?deactivate=<%=rs.getInt("company_id")%>" 
   class="btn btn-warning btn-sm"
   onclick="return confirm('Deactivate this company?');">
   <i class="fa fa-user-slash"></i>
</a>
<% } %>

</div>
</td>


</tr>

<%
}
}catch(Exception e){
out.println("Error: "+e.getMessage());
}
%>

</tbody>
</table>
</div>

</div>
</div>

</body>
</html>
