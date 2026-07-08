<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String username = (String) session.getAttribute("username");

    if(username == null){
        response.sendRedirect("v_login.jsp");
        return;
    }

    int ownerId = 0;

    PreparedStatement psUser = con.prepareStatement("SELECT user_id FROM users WHERE username=?");
    psUser.setString(1, username);
    ResultSet rsUser = psUser.executeQuery();

    if(rsUser.next()){
        ownerId = rsUser.getInt("user_id");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>License Status Details</title>
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
    background: rgba(255,255,255,0.95);
    backdrop-filter: blur(10px);
    border-radius:20px;
    box-shadow:0 15px 35px rgba(0,0,0,0.1);
    padding:30px;
}

/* Table Styling */
.table thead{
    background: linear-gradient(135deg,#0d6efd,#6610f2);
    color:white;
    font-weight:600;
}

.table tbody tr{
    transition:0.3s;
}

.table tbody tr:hover{
    background-color:#f1f7ff;
    transform:scale(1.01);
}

/* Badge Styles */
.badge{
    padding:8px 14px;
    font-size:13px;
    border-radius:20px;
}

.badge-pending{ background:#ffc107; color:black; }
.badge-approved{ background:#198754; }
.badge-rejected{ background:#dc3545; }
.badge-renewal{ background:#6f42c1; }

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
        <h3>License Status Details</h3>
        <p class="mb-0">View and track your license applications</p>
    </div>

    <!-- Table Section -->
    <div class="table-card">

        <div class="table-responsive">
            <table class="table table-bordered table-striped align-middle text-center">

                <thead>
                    <tr>
                        <th>License ID</th>
                        <th>License Number</th>
                        <th>License Type</th>
                        <th>Issue Date</th>
                        <th>Expiry Date</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM licenses WHERE owner_id=? ORDER BY license_id DESC"
                    );
                    ps.setInt(1, ownerId);
                    ResultSet rs = ps.executeQuery();

                    boolean found = false;

                    while(rs.next()){
                        found = true;
                        String status = rs.getString("status");
                %>

                    <tr>
                        <td><%= rs.getInt("license_id") %></td>
                        <td><strong><%= rs.getString("license_number") %></strong></td>
                        <td><%= rs.getString("license_type") %></td>
                        <td><%= rs.getDate("issue_date") %></td>
                        <td><%= rs.getDate("expiry_date") %></td>
                        <td>
                            <% if(status.equals("Pending")){ %>
                                <span class="badge badge-pending">Pending</span>
                            <% } else if(status.equals("Approved")){ %>
                                <span class="badge badge-approved">Approved</span>
                            <% } else if(status.equals("Rejected")){ %>
                                <span class="badge badge-rejected">Rejected</span>
                            <% } else { %>
                                <span class="badge badge-renewal">Renewal Pending</span>
                            <% } %>
                        </td>
                    </tr>

                <%
                    }

                    if(!found){
                %>
                    <tr>
                        <td colspan="6" class="text-muted">No License Records Found</td>
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
