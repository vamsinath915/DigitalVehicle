<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnection.jsp" %>
<%
if(session.getAttribute("username") == null){
%>
<script>
    window.top.location.href="r_login.jsp";
</script>
<%
    return;
}

//Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String message="";
String alertType="";

try{
//    Class.forName("com.mysql.jdbc.Driver");
//    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    // DELETE ACTION
    if(request.getParameter("delete")!=null){
        int id=Integer.parseInt(request.getParameter("delete"));
        ps=con.prepareStatement("DELETE FROM license_requests WHERE request_id=?");
        ps.setInt(1,id);
        int i=ps.executeUpdate();

        if(i>0){
            message="Renewal Request Deleted Successfully.";
            alertType="success";
        }else{
            message="Deletion Failed.";
            alertType="danger";
        }
    }

}catch(Exception e){
    message="Error: "+e.getMessage();
    alertType="danger";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Approved Renewal Licenses</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body{
    background:linear-gradient(to right,#eef2f7,#f8fbff);
    font-family:'Segoe UI',sans-serif;
}

.main-card{
    border:none;
    border-radius:14px;
    box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.card-header{
    background:linear-gradient(45deg,#003366,#0056b3);
    color:white;
    font-size:22px;
    font-weight:600;
    padding:18px;
    border-radius:14px 14px 0 0;
}

.table thead{
    background:#003366;
    color:white;
}

.badge-approved{
    background:#28a745;
    padding:6px 14px;
    border-radius:25px;
    font-size:12px;
}

.btn-edit{
    background:#17a2b8;
    color:white;
    border-radius:25px;
    padding:5px 12px;
}

.btn-delete{
    background:#dc3545;
    color:white;
    border-radius:25px;
    padding:5px 12px;
}

.btn-edit:hover{ background:#138496; }
.btn-delete:hover{ background:#c82333; }

.alert{
    border-radius:10px;
}
</style>
</head>

<body>

<div class="container-fluid mt-5 mb-5">
<div class="row justify-content-center">
<div class="col-lg-11">

<div class="card main-card">

<div class="card-header text-center">
<i class="fas fa-sync-alt mr-2"></i>
Approved Renewal License Requests
</div>

<div class="card-body">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
<i class="fas fa-info-circle mr-2"></i>
<%=message%>
<button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<% } %>

<div class="table-responsive">

<table class="table table-bordered table-hover text-center">

<thead>
<tr>
<th>ID</th>
<th>Owner ID</th>
<th>Lic. Number</th>
<th>Request Type</th>
<th>Request Date</th>
<th>Status</th>
<th>Remarks</th>
<th>Actions</th>
</tr>
</thead>

<tbody>

<%
try{
    ps=con.prepareStatement(
    "SELECT * FROM license_requests WHERE request_type='Renewal' AND status='Approved' ORDER BY request_id DESC");
    rs=ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%=rs.getInt("request_id")%></td>
<td><%=rs.getString("owner_id")%></td>
<td><%=rs.getString("license_number")%></td>
<td><%=rs.getString("request_type")%></td>
<td><%=rs.getString("request_date")%></td>
<td><span class="badge-approved">Approved</span></td>
<td><%=rs.getString("remarks")%></td>

<td>

<a href="editRenewalRequest.jsp?id=<%=rs.getInt("request_id")%>" 
   class="btn btn-edit btn-sm">
<i class="fas fa-edit"></i>
</a>

<a href="viewApprovedRenewalLicenses.jsp?delete=<%=rs.getInt("request_id")%>" 
   class="btn btn-delete btn-sm"
   onclick="return confirm('Delete this renewal request?');">
<i class="fas fa-trash-alt"></i>
</a>

</td>

</tr>

<%
    }
}catch(Exception e){
    out.println("<tr><td colspan='7'>Error Loading Data</td></tr>");
}
%>

</tbody>
</table>

</div>

</div>
</div>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
