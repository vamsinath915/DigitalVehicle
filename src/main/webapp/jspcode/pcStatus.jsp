<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>

<%
    String username = (String) session.getAttribute("username");

    if(username == null){
        response.sendRedirect("v_login.jsp");
        return;
    }

    String ownerId = null;

    // Get logged-in user ID
    PreparedStatement psUser = con.prepareStatement(
        "SELECT uid FROM users WHERE uid=?"
    );
    psUser.setString(1, username);
    ResultSet rsUser = psUser.executeQuery();
    if(rsUser.next()){
        ownerId = rsUser.getString("uid");
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

/* Header */
.page-header{
    background: linear-gradient(135deg,#0d6efd,#6610f2);
    color:white;
    padding:25px;
    border-radius:15px;
    box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

/* Table Card */
.table-card{
    background: white;
    border-radius:20px;
    box-shadow:0 15px 35px rgba(0,0,0,0.1);
    padding:30px;
}

/* Table Styling */
.table thead{
    background: linear-gradient(135deg,#0d6efd,#6610f2);
    color:white;
}

.table tbody tr:hover{
    background-color:#f1f7ff;
    transform:scale(1.01);
    transition:0.3s;
}

/* Badge Styles */
.badge{
    padding:8px 14px;
    border-radius:20px;
}

.badge-pending{ background:#ffc107; color:black; }
.badge-approved{ background:#198754; }
.badge-rejected{ background:#dc3545; }

/* Responsive */
@media(max-width:768px){
    .page-header{
        text-align:center;
    }
}
</style>
</head>

<body>

<div class="container mt-5">

    <!-- Header -->
    <div class="page-header text-center mb-4">
        <h3>Pollution Certificate Status</h3>
        <p>View your Pollution Certificate applications</p>
    </div>

    <!-- Table Section -->
    <div class="table-card">

        <div class="table-responsive">
            <table class="table table-bordered text-center align-middle">

                <thead>
                    <tr>
                        <th>Certificate ID</th>
                        <th>Vehicle ID</th>
                        <th>PCB Officer ID</th>
                        <th>Issue Date</th>
                        <th>Expiry Date</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT *from pollution_certificates ORDER BY id DESC"
                    );
                    ResultSet rs = ps.executeQuery();

                    boolean found = false;

                    while(rs.next()){
                        found = true;
                        String status = rs.getString("status");
                %>

                <tr>
                    <td><%= rs.getString("certificate_id") %></td>
                    <td><%= rs.getString("vehicle_number") %></td>
                    <td><%= rs.getString("pcb_officer_id") %></td>
                    <td><%= rs.getDate("issue_date") %></td>
                    <td><%= rs.getDate("expiry_date") %></td>
                    <td>
                        <% if(status.equals("Pending")){ %>
                            <span class="badge badge-pending">Pending</span>
                        <% } else if(status.equals("Approved")){ %>
                            <span class="badge badge-approved">Approved</span>
                        <% } else { %>
                            <span class="badge badge-rejected">Rejected</span>
                        <% } %>
                    </td>
                </tr>

                <%
                    }

                    if(!found){
                %>
                    <tr>
                        <td colspan="6" class="text-muted">
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
