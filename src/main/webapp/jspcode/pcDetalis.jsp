<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.time.*" %>
<%@ include file="dbconnection.jsp" %>

<%
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("v_login.jsp");
        return;
    }

    String ownerId = username;
    /*PreparedStatement psUser = con.prepareStatement(
        "SELECT user_id FROM users WHERE username=?"
    );
    psUser.setString(1, username);
    ResultSet rsUser = psUser.executeQuery();
    if(rsUser.next()){
        ownerId = rsUser.getInt("user_id");
    }*/

    String message = "";

    // Handle Renewal Request Submission
    if("POST".equalsIgnoreCase(request.getMethod())){
        int certId = Integer.parseInt(request.getParameter("certificateId"));

        // Check if there is already a pending renewal request
        PreparedStatement checkReq = con.prepareStatement(
            "SELECT * FROM pollution_certificates WHERE certificate_id=? AND status='Pending'"
        );
        checkReq.setInt(1, certId);
        ResultSet rsCheck = checkReq.executeQuery();

        if(!rsCheck.next()){
            PreparedStatement insertReq = con.prepareStatement(
                "INSERT INTO pollution_certificates(certificate_id, request_date, status) VALUES(?, CURDATE(), 'Pending')"
            );
            insertReq.setInt(1, certId);
            insertReq.executeUpdate();
            message = "Pollution Certificate Renewal Requested Successfully!";
        } else {
            message = "You already have a pending renewal request for this certificate.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pollution Certificate Status</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background: linear-gradient(135deg,#e3f2fd,#f8f9fa);
}

.page-header{
    background: linear-gradient(135deg,#0d6efd,#6610f2);
    color:white;
    padding:25px;
    border-radius:15px;
    box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

.table-card{
    background: white;
    border-radius:20px;
    box-shadow:0 15px 35px rgba(0,0,0,0.1);
    padding:30px;
}

.table thead{
    background: linear-gradient(135deg,#0d6efd,#6610f2);
    color:white;
}

.table tbody tr:hover{
    background-color:#f1f7ff;
    transform:scale(1.01);
    transition:0.3s;
}

.badge{
    padding:8px 14px;
    border-radius:20px;
}

.badge-pending{ background:#ffc107; color:black; }
.badge-approved{ background:#198754; }
.badge-rejected{ background:#dc3545; }

.renew-btn{
    background: linear-gradient(135deg,#20c997,#0dcaf0);
    border:none;
    color:white;
    padding:6px 15px;
    border-radius:25px;
    transition:0.3s;
}

.renew-btn:hover{
    transform:scale(1.05);
    box-shadow:0 8px 20px rgba(0,0,0,0.2);
}
</style>
</head>

<body>

<div class="container mt-5">

    <div class="page-header text-center mb-4">
        <h3>Pollution Certificate Status</h3>
        <p>View your certificates and request renewal when nearing expiry</p>
    </div>

    <% if(!message.equals("")){ %>
        <div class="alert alert-info text-center">
            <%= message %>
        </div>
    <% } %>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>Certificate ID</th>
                        <th>Vehicle Number</th>
                        <th>PCB Officer ID</th>
                        <th>Issue Date</th>
                        <th>Expiry Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT * from pollution_certificates ORDER BY id DESC"
                    );
                    ResultSet rs = ps.executeQuery();

                    boolean found = false;

                    while(rs.next()){
                        found = true;
                        String certId = rs.getString("certificate_id");
                        String vehicleNumber = rs.getString("vehicle_number");
                        String status = rs.getString("status");
                        Date expiryDate = rs.getDate("expiry_date");

                        // Check if renewal is eligible (expiry within 30 days and approved)
                        
                        boolean eligibleForRenewal = false;
                        if(status.equals("Approved") && expiryDate != null){
                            LocalDate expDate = expiryDate.toLocalDate();
                            LocalDate today = LocalDate.now();
                            if(!expDate.isBefore(today) && !expDate.isAfter(today.plusDays(30))){
                                eligibleForRenewal = true;
                            }
                        }
                %>
                    <tr>
                        <td><%= certId %></td>
                        <td><%= vehicleNumber %></td>
                        <td><%= rs.getString("pcb_officer_id") %></td>
                        <td><%= rs.getDate("issue_date") %></td>
                        <td><%= expiryDate %></td>
                        <td>
                            <% if(status.equals("Pending")){ %>
                                <span class="badge badge-pending">Pending</span>
                            <% } else if(status.equals("Approved")){ %>
                                <span class="badge badge-approved">Approved</span>
                            <% } else { %>
                                <span class="badge badge-rejected">Rejected</span>
                            <% } %>
                        </td>
                        <td>
                            <% if(eligibleForRenewal){ %>
                                <form method="post">
                                    <input type="hidden" name="certificateId" value="<%= certId %>">
                                    <button type="submit" class="renew-btn">Request Renewal</button>
                                </form>
                            <% } else { %>
                                <span class="text-muted">
                                    <% if(status.equals("Approved")){ %>
                                        Renewal Not Due
                                    <% } else { %>
                                        Not Eligible
                                    <% } %>
                                </span>
                            <% } %>
                        </td>
                    </tr>
                <%
                    }
                    if(!found){
                %>
                    <tr>
                        <td colspan="7" class="text-muted">
                            No Pollution Certificate Records Found
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>
