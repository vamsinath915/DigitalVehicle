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
String vid="";

try{
//    Class.forName("com.mysql.jdbc.Driver");
//    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_vehicle_system","root","root");

    // Auto Vehicle ID
    Statement st = con.createStatement();
    rs = st.executeQuery("select count(*) from vehicles");
    int c=0;
    if(rs.next()){
        c = rs.getInt(1);
    }
    c++;
    vid="VID"+c;

    // Insert Logic
    if(request.getParameter("submit") != null){

        String owner_id = request.getParameter("owner_id");
        String vehicle_number = request.getParameter("vehicle_number");
        String vehicle_type = request.getParameter("vehicle_type");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String engine_no = request.getParameter("engine_no");
        String chassis_no = request.getParameter("chassis_no");
        String registration_date = request.getParameter("registration_date");
        String status = request.getParameter("status");

        ps = con.prepareStatement(
        "INSERT INTO vehicles(owner_id,vehicle_number,vehicle_type,brand,model,engine_no,chassis_no,registration_date,status) VALUES(?,?,?,?,?,?,?,?,?)");

        ps.setString(1, owner_id);
        ps.setString(2, vehicle_number);
        ps.setString(3, vehicle_type);
        ps.setString(4, brand);
        ps.setString(5, model);
        ps.setString(6, engine_no);
        ps.setString(7, chassis_no);
        ps.setString(8, registration_date);
        ps.setString(9, status);

        int i = ps.executeUpdate();

        if(i>0){
            message="Vehicle added successfully.";
            alertType="success";
        }else{
            message="Vehicle adding failed.";
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
<title>Add Vehicle</title>
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

.form-control{
    border-radius:8px;
    border:1px solid #dcdcdc;
    transition:0.3s;
}

.form-control:focus{
    border-color:#0056b3;
    box-shadow:0 0 5px rgba(0,86,179,0.3);
}

.btn-custom{
    background:linear-gradient(45deg,#003366,#0056b3);
    color:white;
    border-radius:30px;
    padding:8px 25px;
}

.btn-custom:hover{
    transform:translateY(-2px);
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}
</style>
</head>

<body>

<div class="container mt-5 mb-5">
<div class="row justify-content-center">
<div class="col-lg-10">

<div class="card">

<div class="card-header text-center">
<i class="fas fa-car"></i> Add Vehicle Details
</div>

<div class="card-body p-4">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
    <%=message%>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<% } %>

<form method="post">

<div class="form-row">

<div class="form-group col-md-6">
<label>Vehicle ID</label>
<input type="text" value="<%=vid%>" class="form-control" readonly>
</div>

<div class="form-group col-md-6">
<label>Owner ID</label>
<input type="text" name="owner_id" class="form-control" required>
</div>

</div>

<div class="form-row">

<div class="form-group col-md-6">
<label>Vehicle Number</label>
<input type="text" name="vehicle_number" class="form-control" required>
</div>

<div class="form-group col-md-6">
<label>Vehicle Type</label>
<select name="vehicle_type" class="form-control" required>
<option value="">--Select Type--</option>
<option>Car</option>
<option>Bike</option>
<option>Truck</option>
<option>Bus</option>
</select>
</div>

</div>

<div class="form-row">

<div class="form-group col-md-6">
<label>Brand</label>
<input type="text" name="brand" class="form-control" required>
</div>

<div class="form-group col-md-6">
<label>Model</label>
<input type="text" name="model" class="form-control" required>
</div>

</div>

<div class="form-row">

<div class="form-group col-md-6">
<label>Engine Number</label>
<input type="text" name="engine_no" class="form-control" required>
</div>

<div class="form-group col-md-6">
<label>Chassis Number</label>
<input type="text" name="chassis_no" class="form-control" required>
</div>

</div>

<div class="form-row">

<div class="form-group col-md-6">
<label>Registration Date</label>
<input type="date" name="registration_date" class="form-control" required>
</div>

<div class="form-group col-md-6">
<label>Status</label>
<select name="status" class="form-control">
<option value="Active">Active</option>
<option value="Inactive">Inactive</option>
</select>
</div>

</div>

<div class="text-center mt-4">
<button type="submit" name="submit" class="btn btn-custom">
<i class="fas fa-save"></i> Create Vehicle
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
