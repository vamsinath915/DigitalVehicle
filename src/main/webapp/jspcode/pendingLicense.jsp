<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnection.jsp" %>
<%
if(session.getAttribute("username") == null){
%>
<script>
    window.top.location.href="login.jsp";
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
//    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    // APPROVE
    if(request.getParameter("approve")!=null){
        int id=Integer.parseInt(request.getParameter("approve"));
        ps=con.prepareStatement("UPDATE licenses SET issue_date = CURDATE(), expiry_date = DATE_ADD(CURDATE(), INTERVAL 3 YEAR), status = 'Approved' WHERE license_id=?");
        ps.setInt(1,id);
        ps.executeUpdate();
        message="License Approved Successfully.";
        alertType="success";
    }

    // REJECT
    if(request.getParameter("reject")!=null){
        int id=Integer.parseInt(request.getParameter("reject"));
        ps=con.prepareStatement("UPDATE licenses SET status='Rejected' WHERE license_id=?");
        ps.setInt(1,id);
        ps.executeUpdate();
        message="License Rejected Successfully.";
        alertType="warning";
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
<title>Pending Licenses</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body{
    background: linear-gradient(to right,#eef2f7,#f4f7fb);
    font-family: 'Segoe UI', sans-serif;
}

.main-card{
    border:none;
    border-radius:14px;
    box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.card-header{
    background:linear-gradient(45deg,#1f3c88,#0056b3);
    color:white;
    font-size:22px;
    font-weight:600;
    padding:18px;
    border-radius:14px 14px 0 0;
}

.table thead{
    background:#1f3c88;
    color:white;
    font-size:14px;
}

.badge-pending{
    background:#ffc107;
    color:#000;
    padding:6px 14px;
    border-radius:25px;
    font-size:12px;
    font-weight:600;
}

.btn-approve{
    background:#28a745;
    color:white;
    border-radius:25px;
    padding:5px 12px;
}

.btn-reject{
    background:#dc3545;
    color:white;
    border-radius:25px;
    padding:5px 12px;
}

.btn-approve:hover{ background:#218838; }
.btn-reject:hover{ background:#c82333; }

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
<i class="fas fa-clock mr-2"></i> Pending License Details
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
<th>License Number</th>
<th>Type</th>
<th>Issue Date</th>
<th>Expiry Date</th>
<th>Status</th>
<th>Actions</th>
</tr>
</thead>

<tbody>

<%
try{
    ps=con.prepareStatement("SELECT * FROM licenses WHERE status='Pending' ORDER BY license_id DESC");
    rs=ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%=rs.getInt("license_id")%></td>
<td><%=rs.getString("owner_id")%></td>
<td><%=rs.getString("license_number")%></td>
<td><%=rs.getString("license_type")%></td>
<td><%=rs.getString("issue_date")%></td>
<td><%=rs.getString("expiry_date")%></td>
<td><span class="badge-pending">Pending</span></td>

<td>

<a href="pendingLicense.jsp?approve=<%=rs.getInt("license_id")%>" 
   class="btn btn-approve btn-sm"
   onclick="return confirm('Approve this license?');">
<i class="fas fa-check-circle"></i>
</a>

<a href="pendingLicense.jsp?reject=<%=rs.getInt("license_id")%>" 
   class="btn btn-reject btn-sm"
   onclick="return confirm('Reject this license?');">
<i class="fas fa-times-circle"></i>
</a>

</td>

</tr>

<%
    }
}catch(Exception e){
    out.println("<tr><td colspan='8'>Error Loading Data</td></tr>");
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
