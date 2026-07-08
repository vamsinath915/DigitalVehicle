<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.UUID" %>
<%@include file="dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Add User</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background: transparent;
}

/* Glass Container */
.glass{
    background: rgba(255,255,255,0.18);
    backdrop-filter: blur(18px);
    -webkit-backdrop-filter: blur(18px);
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.3);
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
    padding:35px;
}

.page-wrapper{
    padding:30px;
}

.page-title{
    color:#fff;
    font-weight:600;
    margin-bottom:25px;
}

/* Form Controls */
.form-control{
    background: rgba(255,255,255,0.25);
    border:1px solid rgba(255,255,255,0.4);
    border-radius:12px;
    color:#fff;
}

.form-control::placeholder{
    color:#f1f1f1;
}

.form-control:focus{
    background: rgba(255,255,255,0.35);
    box-shadow:none;
    border-color:#fff;
    color:#fff;
}

select.form-control option{
    background:#ffffff;
    color:#333;
}

label{
    color:#fff;
    font-weight:500;
}

/* Button */
.btn-custom{
    background:#ffffff;
    color:#333;
    border-radius:12px;
    padding:10px 25px;
    font-weight:500;
    transition:0.3s;
}

.btn-custom:hover{
    background:#f1f1f1;
    transform:translateY(-2px);
}
</style>
</head>

<body>

    <%
String message = "";
String type = "";

if("POST".equalsIgnoreCase(request.getMethod())){

    String full_name = request.getParameter("full_name");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String userId = null;
    int generatedAutoIncrementId = 0;
    
    try{
        String sql = "SELECT count(user_id) FROM users where role=?";
        PreparedStatement ps1 = con.prepareStatement(sql);
        ps1.setString(1,role);
        ResultSet rs1 = ps1.executeQuery();
        if(rs1.next())
        {
            generatedAutoIncrementId = rs1.getInt(1)+1;
        }
        else
        {
            generatedAutoIncrementId = 1;
        }
        
    ///int autoId = generatedAutoIncrementId;
    if(role.equals("TRAFFIC"))
    {
        userId = "TO_"+ String.format("%03d", generatedAutoIncrementId);
    }
    else if(role.equals("POLICE"))
    {
        userId = "PO_"+ String.format("%03d", generatedAutoIncrementId);
    }
    else
    {
        userId = role+"_"+ String.format("%03d", generatedAutoIncrementId);
    }
        // Duplicate Check
        PreparedStatement check = con.prepareStatement(
        "SELECT * FROM users WHERE username=? OR email=?");
        check.setString(1, username);
        check.setString(2, email);

        ResultSet rs = check.executeQuery();

        if(rs.next()){
            message = "Username or Email already exists!";
            type = "danger";
        }else{

            PreparedStatement ps = con.prepareStatement(
            "INSERT INTO users(full_name,email,mobile,username,password,role,address,city, uid) VALUES(?,?,?,?,?,?,?,?,?)");

            ps.setString(1, full_name);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, username);
            ps.setString(5, password);
            ps.setString(6, role);
            ps.setString(7, address);
            ps.setString(8, city);
            ps.setString(9, userId);
            
            ps.executeUpdate();

            message = "User Added Successfully!" +"User ID:"+userId;
            type = "success";
        }

        con.close();

    }catch(Exception e){
        message = "Error: " + e.getMessage();
        type = "danger";
    }
}
%>

<!-- Toast Message -->
<% if(!message.equals("")){ %>
<div class="alert alert-<%=type%> toast-msg">
    <%= message %>
</div>
<% } %>
<div class="page-wrapper">

    <div class="glass">

        <h4 class="page-title">
            <i class="fa fa-user-plus"></i> Add New User
        </h4>

        <form method="post">

            <div class="row">

                <!-- Full Name -->
                <div class="col-md-6 mb-3">
                    <label>Full Name *</label>
                    <input type="text" name="full_name" class="form-control"
                           placeholder="Enter full name" required>
                </div>

                <!-- Username -->
                <div class="col-md-6 mb-3">
                    <label>Username *</label>
                    <input type="text" name="username" class="form-control"
                           placeholder="Enter username" required>
                </div>

                <!-- Email -->
                <div class="col-md-6 mb-3">
                    <label>Email *</label>
                    <input type="email" name="email" class="form-control"
                           placeholder="Enter email" required>
                </div>

                <!-- Mobile -->
                <div class="col-md-6 mb-3">
                    <label>Mobile (10 digits)</label>
                    <input type="text" name="mobile" class="form-control"
                           pattern="[0-9]{10}"
                           maxlength="10"
                           placeholder="Enter 10 digit mobile number">
                </div>

                <!-- Password -->
                <div class="col-md-6 mb-3">
                    <label>Password *</label>
                    <input type="password" name="password" class="form-control"
                           placeholder="Enter password" required>
                </div>

                <!-- Role -->
                <div class="col-md-6 mb-3">
                    <label>User Role *</label>
                    <select name="role" class="form-control" required>
                        <option value="">Select Role</option>
                        <option value="RTO">RTO</option>
<!--                        <option value="OWNER">OWNER</option>-->
                        <option value="PCB">PCB</option>
<!--                        <option value="INSURANCE">INSURANCE</option>-->
                        <option value="TRAFFIC">TRAFFIC</option>
                        <option value="POLICE">POLICE</option>
                    </select>
                </div>

                <!-- City -->
                <div class="col-md-6 mb-3">
                    <label>City</label>
                    <input type="text" name="city" class="form-control"
                           placeholder="Enter city">
                </div>

                <!-- Address -->
                <div class="col-12 mb-3">
                    <label>Address</label>
                    <textarea name="address" class="form-control"
                              rows="3"
                              placeholder="Enter address"></textarea>
                </div>

            </div>

            <div class="text-end mt-3">
                <button type="submit" class="btn btn-custom">
                    <i class="fa fa-save"></i> Save User
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>
