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

String message="";
String alertType="";

//Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{
//    Class.forName("com.mysql.jdbc.Driver");
//    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_vehicle_system","root","root");

    // DELETE LOGIC
    if(request.getParameter("delete_id") != null){
        int vid = Integer.parseInt(request.getParameter("delete_id"));
        ps = con.prepareStatement("DELETE FROM vehicles WHERE vehicle_id=?");
        ps.setInt(1, vid);
        int i = ps.executeUpdate();

        if(i>0){
            message="Vehicle deleted successfully.";
            alertType="success";
        }else{
            message="Vehicle deletion failed.";
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
<title>View Vehicles</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body{
    background: linear-gradient(to right, #eef2f7, #f8fbff);
    font-family: 'Segoe UI', sans-serif;
}

.card{
    border:none;
    border-radius:12px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

.card-header{
    background:linear-gradient(45deg,#003366,#0056b3);
    color:white;
    font-weight:600;
    font-size:20px;
    padding:15px;
}

.table th{
    background:#003366;
    color:white;
    font-size:14px;
}

.btn-edit{
    background:#17a2b8;
    color:white;
    border-radius:20px;
    padding:5px 12px;
}

.btn-delete{
    background:#dc3545;
    color:white;
    border-radius:20px;
    padding:5px 12px;
}
</style>
</head>

<body>

<div class="container mt-5 mb-5">
<div class="row">
<div class="col-lg-12">

<div class="card">

<div class="card-header text-center">
<i class="fas fa-car"></i> View Vehicle Details
</div>

<div class="card-body">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
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
<th>Vehicle No</th>
<th>Type</th>
<th>Brand</th>
<th>Model</th>
<th>Status</th>
<th>Actions</th>
</tr>
</thead>
<tbody>

<%
try{
    Statement st = con.createStatement();
    rs = st.executeQuery("SELECT * FROM vehicles ORDER BY vehicle_id DESC");

    while(rs.next()){
%>

<tr>
<td><%=rs.getInt("vehicle_id")%></td>
<td><%=rs.getString("owner_id")%></td>
<td><%=rs.getString("vehicle_number")%></td>
<td><%=rs.getString("vehicle_type")%></td>
<td><%=rs.getString("brand")%></td>
<td><%=rs.getString("model")%></td>
<td>
<% if(rs.getString("status").equals("Active")){ %>
<span class="badge badge-success">Active</span>
<% } else { %>
<span class="badge badge-secondary">Inactive</span>
<% } %>
</td>
<td>
<a href="editVehicle.jsp?id=<%=rs.getInt("vehicle_id")%>" class="btn btn-edit btn-sm">
<i class="fas fa-edit"></i>
</a>

<a href="viewVehicles.jsp?delete_id=<%=rs.getInt("vehicle_id")%>" 
onclick="return confirm('Are you sure you want to delete this vehicle?');"
class="btn btn-delete btn-sm">
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
