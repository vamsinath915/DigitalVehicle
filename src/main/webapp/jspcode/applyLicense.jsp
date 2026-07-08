<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.UUID" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>

<%
    String message = "";
    String ownerId = "";
    String generatedLicenseNumber = "";

    // Prevent back button cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String username = session.getAttribute("username").toString();
    
    if(session.getAttribute("username") == null){
        response.sendRedirect("v_login.jsp");
        return;
    }

    try {
        // Get owner_id from users table
        PreparedStatement ps1 = con.prepareStatement("SELECT uid FROM users WHERE uid=?");
        ps1.setString(1, username);
        ResultSet rs1 = ps1.executeQuery();

        if(rs1.next()){
            ownerId = rs1.getString("uid");
        }
        System.out.println("Owner ID:"+ownerId);

    } catch(Exception e){
        message = "Error fetching user: " + e.getMessage();
    }

    // Handle Form Submission
    if(request.getMethod().equalsIgnoreCase("POST")){

        String licenseType = request.getParameter("license_type");

        // Generate License Number
        generatedLicenseNumber = "LIC-" + UUID.randomUUID().toString().substring(0,6).toUpperCase();

        try {

            String sql = "INSERT INTO licenses(owner_id, license_number, license_type) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, ownerId);
            ps.setString(2, generatedLicenseNumber);
            ps.setString(3, licenseType);

            int i = ps.executeUpdate();

            if(i > 0){
                message = "License Applied Successfully! License No: " + generatedLicenseNumber;
            } else {
                message = "Application Failed!";
            }

        } catch(Exception e){
            message = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply License</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
             background-color:#f1f4f8;
             font-family:'Segoe UI',sans-serif;
        }

        .apply-card {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 5px rgba(13,110,253,0.4);
        }

        .submit-btn {
            background-color: #0d6efd;
            border: none;
        }

        .submit-btn:hover {
            background-color: #084298;
        }
    </style>
</head>

<body>

<div class="container d-flex justify-content-center align-items-center" style="min-height:100vh;">
    <div class="col-md-6">

        <div class="card apply-card p-4">

            <h4 class="text-center mb-3">Apply for License</h4>

            <% if(!message.equals("")) { %>
                <div class="alert alert-info text-center">
                    <%= message %>
                </div>
            <% } %>

            <form method="post">

                <!-- License Number Preview -->
                <div class="mb-3">
                    <label class="form-label">License Number</label>
                    <input type="text" class="form-control"
                           value="<%= generatedLicenseNumber.equals("") ? "Will be generated after submit" : generatedLicenseNumber %>"
                           readonly>
                </div>

                <!-- Owner ID -->
                <div class="mb-3">
                    <label class="form-label">Owner ID</label>
                    <input type="text" class="form-control"
                           value="<%= ownerId %>"
                           readonly>
                </div>

                <!-- License Type -->
                <div class="mb-3">
                    <label class="form-label">License Type</label>
                    <select name="license_type" class="form-select" required>
                        <option value="">Select License Type</option>
                        <option>LMV</option>
                        <option>MCWG</option>
                        <option>HMV</option>
                        <option>Transport</option>
                    </select>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn submit-btn text-white">
                        Apply License
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>

</body>
</html>
