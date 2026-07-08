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
//    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    // Delete Action
    if(request.getParameter("delete")!=null){
        int id = Integer.parseInt(request.getParameter("delete"));

        ps = con.prepareStatement("DELETE FROM licenses WHERE license_id=?");
        ps.setInt(1,id);
        int i = ps.executeUpdate();

        if(i>0){
            message="License deleted successfully.";
            alertType="success";
        }else{
            message="Deletion failed.";
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
<title>Approved Licenses</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body{
    background:linear-gradient(to right,#eef2f7,#f9fbfd);
    font-family:'Segoe UI',sans-serif;
}

.card{
    border:none;
    border-radius:12px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

.card-header{
    background:linear-gradient(45deg,#004080,#0066cc);
    color:white;
    font-size:20px;
    font-weight:600;
    padding:15px;
}

.table thead{
    background:#004080;
    color:white;
}

.badge-approved{
    background:#28a745;
    padding:6px 10px;
    font-size:13px;
    border-radius:20px;
}

.btn-action{
    padding:5px 10px;
    border-radius:20px;
    font-size:13px;
}

.btn-edit{
    background:#17a2b8;
    color:white;
}

.btn-delete{
    background:#dc3545;
    color:white;
}
</style>
</head>

<body>

<div class="container-fluid mt-5 mb-5">
<div class="row justify-content-center">
<div class="col-lg-11">

<div class="card">

<div class="card-header text-center">
<i class="fas fa-id-card"></i> Approved License Details
</div>

<div class="card-body">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
    <%=message%>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<% } %>

<div class="table-responsive">
<table class="table table-bordered table-hover">

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
    ps = con.prepareStatement("SELECT * FROM licenses WHERE status='Approved'");
    rs = ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%=rs.getInt("license_id")%></td>
<td><%=rs.getString("owner_id")%></td>
<td><%=rs.getString("license_number")%></td>
<td><%=rs.getString("license_type")%></td>
<td><%=rs.getString("issue_date")%></td>
<td><%=rs.getString("expiry_date")%></td>
<td><span class="badge-approved">Approved</span></td>

<td>
<a href="editLicense.jsp?id=<%=rs.getInt("license_id")%>" 
   class="btn btn-action btn-edit">
<i class="fas fa-edit"></i>
</a>

<a href="viewApprovedLicenses.jsp?delete=<%=rs.getInt("license_id")%>" 
   class="btn btn-action btn-delete"
   onclick="return confirm('Are you sure to delete this license?');">
<i class="fas fa-trash"></i>
</a>
</td>

</tr>

<%
    }
}catch(Exception e){
    out.println("<tr><td colspan='8'>Error loading data</td></tr>");
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
