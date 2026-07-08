<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
if(session.getAttribute("username") == null){
%>
<script>
    window.top.location.href="r_login.jsp";
</script>
<%
    return;
}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String message="";
String alertType="";

int licenseId=0;

String ownerId="";
String licenseNumber="";
String licenseType="";
String issueDate="";
String expiryDate="";
String status="Pending";

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

    // Fetch Existing Data
    if(request.getParameter("id")!=null){
        licenseId = Integer.parseInt(request.getParameter("id"));

        ps = con.prepareStatement("SELECT * FROM licenses WHERE license_id=?");
        ps.setInt(1, licenseId);
        rs = ps.executeQuery();

        if(rs.next()){
            ownerId = rs.getString("owner_id");
            licenseNumber = rs.getString("license_number");
            licenseType = rs.getString("license_type");
            issueDate = rs.getString("issue_date");
            expiryDate = rs.getString("expiry_date");
            status = rs.getString("status");
        }
    }

    // Update Logic
    if(request.getMethod().equalsIgnoreCase("POST")){
        licenseId = Integer.parseInt(request.getParameter("license_id"));

        ps = con.prepareStatement(
        "UPDATE licenses SET owner_id=?, license_number=?, license_type=?, issue_date=?, expiry_date=?, status=? WHERE license_id=?");

        ps.setInt(1, Integer.parseInt(request.getParameter("owner_id")));
        ps.setString(2, request.getParameter("license_number"));
        ps.setString(3, request.getParameter("license_type"));
        ps.setString(4, request.getParameter("issue_date"));
        ps.setString(5, request.getParameter("expiry_date"));
        ps.setString(6, request.getParameter("status"));
        ps.setInt(7, licenseId);

        int i = ps.executeUpdate();

        if(i>0){
            message="License updated successfully.";
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
<title>Edit License</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body{
    background:linear-gradient(to right,#eef2f7,#f8fbff);
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

.form-control:focus{
    border-color:#0066cc;
    box-shadow:0 0 0 0.2rem rgba(0,102,204,0.25);
}

.btn-update{
    background:linear-gradient(45deg,#004080,#0066cc);
    border:none;
    color:white;
    padding:10px;
    border-radius:25px;
    font-weight:500;
}

.btn-update:hover{
    background:linear-gradient(45deg,#003366,#0052a3);
}
</style>
</head>

<body>

<div class="container mt-5 mb-5">
<div class="row justify-content-center">
<div class="col-lg-8">

<div class="card">

<div class="card-header text-center">
<i class="fas fa-id-card"></i> Edit License Details
</div>

<div class="card-body">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
    <%=message%>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<% } %>

<form method="post">

<input type="hidden" name="license_id" value="<%=licenseId%>">

<div class="form-row">

<div class="form-group col-md-6">
<label>Owner ID</label>
<input type="number" name="owner_id" class="form-control" 
       value="<%=ownerId%>" required>
</div>

<div class="form-group col-md-6">
<label>License Number</label>
<input type="text" name="license_number" class="form-control" 
       value="<%=licenseNumber%>" required>
</div>

<div class="form-group col-md-6">
<label>License Type</label>
<input type="text" name="license_type" class="form-control" 
       value="<%=licenseType%>">
</div>

<div class="form-group col-md-6">
<label>Issue Date</label>
<input type="date" name="issue_date" class="form-control" 
       value="<%=issueDate%>">
</div>

<div class="form-group col-md-6">
<label>Expiry Date</label>
<input type="date" name="expiry_date" class="form-control" 
       value="<%=expiryDate%>">
</div>

<div class="form-group col-md-6">
<label>Status</label>
<select name="status" class="form-control">

<option value="Pending" <%=status.equals("Pending")?"selected":""%>>
Pending
</option>

<option value="Approved" <%=status.equals("Approved")?"selected":""%>>
Approved
</option>

<option value="Rejected" <%=status.equals("Rejected")?"selected":""%>>
Rejected
</option>

<option value="Renewal Pending" 
<%=status.equals("Renewal Pending")?"selected":""%>>
Renewal Pending
</option>

</select>
</div>

</div>

<div class="text-center">
<button type="submit" class="btn btn-update btn-block">
<i class="fas fa-save"></i> Update License
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
