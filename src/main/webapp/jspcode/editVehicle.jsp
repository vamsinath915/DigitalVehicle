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

int vehicleId=0;

String ownerId="";
String vehicleNumber="";
String vehicleType="";
String brand="";
String model="";
String engineNo="";
String chassisNo="";
String registrationDate="";
String status="Active";

try{
//    Class.forName("com.mysql.jdbc.Driver");
//    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    if(request.getParameter("id")!=null){
        vehicleId = Integer.parseInt(request.getParameter("id"));

        ps = con.prepareStatement("SELECT * FROM vehicles WHERE vehicle_id=?");
        ps.setInt(1, vehicleId);
        rs = ps.executeQuery();

        if(rs.next()){
            ownerId = rs.getString("owner_id");
            vehicleNumber = rs.getString("vehicle_number");
            vehicleType = rs.getString("vehicle_type");
            brand = rs.getString("brand");
            model = rs.getString("model");
            engineNo = rs.getString("engine_no");
            chassisNo = rs.getString("chassis_no");
            registrationDate = rs.getString("registration_date");
            status = rs.getString("status");
        }
    }

    if(request.getMethod().equalsIgnoreCase("POST")){
        vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));

        ps = con.prepareStatement("UPDATE vehicles SET owner_id=?, vehicle_number=?, vehicle_type=?, brand=?, model=?, engine_no=?, chassis_no=?, registration_date=?, status=? WHERE vehicle_id=?");

        ps.setInt(1, Integer.parseInt(request.getParameter("owner_id")));
        ps.setString(2, request.getParameter("vehicle_number"));
        ps.setString(3, request.getParameter("vehicle_type"));
        ps.setString(4, request.getParameter("brand"));
        ps.setString(5, request.getParameter("model"));
        ps.setString(6, request.getParameter("engine_no"));
        ps.setString(7, request.getParameter("chassis_no"));
        ps.setString(8, request.getParameter("registration_date"));
        ps.setString(9, request.getParameter("status"));
        ps.setInt(10, vehicleId);

        int i = ps.executeUpdate();

        if(i>0){
            message="Vehicle details updated successfully.";
            alertType="success";
        }else{
            message="Update failed.";
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
<title>Edit Vehicle</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body{
    background: linear-gradient(to right,#eef2f7,#f8fbff);
    font-family:'Segoe UI',sans-serif;
}

.card{
    border:none;
    border-radius:12px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

.card-header{
    background:linear-gradient(45deg,#003366,#0056b3);
    color:white;
    font-size:20px;
    font-weight:600;
    padding:15px;
}

.form-control:focus{
    border-color:#0056b3;
    box-shadow:0 0 0 0.2rem rgba(0,86,179,0.25);
}

.btn-update{
    background:linear-gradient(45deg,#003366,#0056b3);
    border:none;
    color:white;
    padding:10px;
    border-radius:25px;
    font-weight:500;
}

.btn-update:hover{
    background:linear-gradient(45deg,#002244,#004080);
}
</style>
</head>

<body>

<div class="container mt-5 mb-5">
<div class="row justify-content-center">
<div class="col-lg-8">

<div class="card">

<div class="card-header text-center">
<i class="fas fa-edit"></i> Edit Vehicle Details
</div>

<div class="card-body">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
    <%=message%>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<% } %>

<form method="post">

<input type="hidden" name="vehicle_id" value="<%=vehicleId%>">

<div class="form-row">

<div class="form-group col-md-6">
<label>Owner ID</label>
<input type="number" name="owner_id" class="form-control" value="<%=ownerId%>" required>
</div>

<div class="form-group col-md-6">
<label>Vehicle Number</label>
<input type="text" name="vehicle_number" class="form-control" value="<%=vehicleNumber%>" required>
</div>

<div class="form-group col-md-6">
<label>Vehicle Type</label>
<input type="text" name="vehicle_type" class="form-control" value="<%=vehicleType%>">
</div>

<div class="form-group col-md-6">
<label>Brand</label>
<input type="text" name="brand" class="form-control" value="<%=brand%>">
</div>

<div class="form-group col-md-6">
<label>Model</label>
<input type="text" name="model" class="form-control" value="<%=model%>">
</div>

<div class="form-group col-md-6">
<label>Engine No</label>
<input type="text" name="engine_no" class="form-control" value="<%=engineNo%>">
</div>

<div class="form-group col-md-6">
<label>Chassis No</label>
<input type="text" name="chassis_no" class="form-control" value="<%=chassisNo%>">
</div>

<div class="form-group col-md-6">
<label>Registration Date</label>
<input type="date" name="registration_date" class="form-control" value="<%=registrationDate%>">
</div>

<div class="form-group col-md-6">
<label>Status</label>
<select name="status" class="form-control">
<option value="Active" <%=status.equals("Active")?"selected":""%>>Active</option>
<option value="Inactive" <%=status.equals("Inactive")?"selected":""%>>Inactive</option>
</select>
</div>

</div>

<div class="text-center">
<button type="submit" class="btn btn-update btn-block">
<i class="fas fa-save"></i> Update Vehicle
</button>
</div>

</form>

</div>
</div>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
