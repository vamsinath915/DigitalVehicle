<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
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
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Approved Pollution Certificates</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- FontAwesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{
    background: linear-gradient(135deg,#eef2f7,#f8fbff);
    font-family: 'Segoe UI', sans-serif;
}

/* Header */
.page-header{
    background: linear-gradient(135deg,#198754,#20c997);
    color:white;
    padding:25px;
    border-radius:15px;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
    text-align:center;
}

/* Card */
.table-card{
    background: white;
    border-radius:20px;
    box-shadow:0 15px 35px rgba(0,0,0,0.1);
    padding:30px;
    margin-top:20px;
}

/* Table */
.table thead{
    background: linear-gradient(135deg,#198754,#20c997);
    color:white;
    font-weight:600;
}

.table tbody tr{
    transition:0.3s;
}

.table tbody tr:hover{
    background-color:#e9f9f1;
    transform:scale(1.01);
}

/* Approved Badge */
.badge-approved{
    background:#198754;
    padding:8px 14px;
    border-radius:20px;
    font-size:13px;
}

/* Certificate Icon */
.cert-icon{
    color:#198754;
    font-size:18px;
}
</style>
</head>

<body>

<div class="container mt-5">

    <!-- Header -->
    <div class="page-header mb-4">
        <h3><i class="fa-solid fa-file-shield"></i> Approved Pollution Certificates</h3>
        <p>View your successfully approved certificates</p>
    </div>

    <!-- Table Card -->
    <div class="table-card">

        <div class="table-responsive">
            <table class="table table-bordered text-center align-middle">

                <thead>
                    <tr>
                        <th>Certificate ID</th>
                        <th>Vehicle Number</th>
                        <th>Issue Date</th>
                        <th>Expiry Date</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT * from pollution_certificates where status='Approved' and pcb_officer_id=? " +
                        "ORDER BY id DESC"
                    );

                    ps.setString(1, ownerId);
                    ResultSet rs = ps.executeQuery();

                    boolean found = false;

                    while(rs.next()){
                        found = true;
                %>

                    <tr>
                        <td>
                            <i class="fa-solid fa-certificate cert-icon"></i>
                            <%= rs.getString("certificate_id") %>
                        </td>
                        <td><strong><%= rs.getString("vehicle_number") %></strong></td>
                        <td><%= rs.getDate("issue_date") %></td>
                        <td><%= rs.getDate("expiry_date") %></td>
                        <td>
                            <span class="badge badge-approved">
                                <i class="fa-solid fa-check"></i> Approved
                            </span>
                        </td>
                    </tr>

                <%
                    }

                    if(!found){
                %>
                    <tr>
                        <td colspan="5" class="text-muted">
                            No Approved Pollution Certificates Found
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
