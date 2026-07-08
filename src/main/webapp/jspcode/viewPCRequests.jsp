<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>

<%
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("v_login.jsp");
        return;
    }

    // Get logged-in user's id
   String pcbOfficerId = username;
    /*PreparedStatement psUser = con.prepareStatement(
        "SELECT user_id FROM users WHERE username=?"
    );
    psUser.setString(1, username);
    ResultSet rsUser = psUser.executeQuery();
    if(rsUser.next()){
        pcbOfficerId = rsUser.getInt("user_id");
    }
*/
    String message = "";

    // Handle Approve / Reject actions
    if(request.getParameter("action") != null){
        int certId = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        String sql = "UPDATE Pollution_certificates SET certificate_id = CONCAT('PCB', LPAD(id,5,'0')), pcb_officer_id = ?, "
                + "issue_date = CURDATE(), expiry_date = DATE_ADD(CURDATE(), INTERVAL 6 MONTH), status = ? "
                + "WHERE id = ?";
        PreparedStatement psUpdate = con.prepareStatement(sql);
        psUpdate.setString(1, username);
        psUpdate.setString(2, action);
        psUpdate.setInt(3, certId);
        System.out.println("Query"+psUpdate);
        int i = psUpdate.executeUpdate();
        if(i > 0){
            message = "Certificate " + action + " successfully!";
        } else {
            message = "Action failed!";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pollution Certificate Requests</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- FontAwesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(135deg,#f1f4f8,#e9f1fc);
    font-family: 'Segoe UI', sans-serif;
}

.page-header{
    background: linear-gradient(135deg,#0d6efd,#6610f2);
    color:white;
    padding:25px;
    border-radius:15px;
    box-shadow:0 10px 25px rgba(0,0,0,0.2);
    text-align:center;
}

.table-card{
    background: white;
    border-radius:20px;
    box-shadow:0 15px 35px rgba(0,0,0,0.1);
    padding:30px;
    margin-top:20px;
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

.action-btn{
    border:none;
    border-radius:8px;
    padding:6px 12px;
    margin:2px;
    cursor:pointer;
    color:white;
}

.approve-btn{ background:#198754; }
.reject-btn{ background:#dc3545; }

.action-btn:hover{
    transform:scale(1.05);
    box-shadow:0 6px 15px rgba(0,0,0,0.2);
}
</style>
</head>

<body>

<div class="container mt-5">

    <div class="page-header mb-4">
        <h3>Pollution Certificate Requests</h3>
        <p>Manage Pollution Certificates</p>
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
                        <th>Actions</th>
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
                        int id = rs.getInt("id");
                        String certId = rs.getString("certificate_id");
                        String vehicleNumber = rs.getString("vehicle_number");
                        String assignedPcb = rs.getString("pcb_officer_id");
                        Date issueDate = rs.getDate("issue_date");
                        Date expiryDate = rs.getDate("expiry_date");
                        String status = rs.getString("status");
                %>
                    <tr>
                        <td><%= certId %></td>
                        <td><%= vehicleNumber %></td>
                        <td><%= assignedPcb %></td>
                        <td><%= issueDate %></td>
                        <td><%= expiryDate %></td>
                        <td>
                            <% if(status.equals("Pending")){ %>
                                <span class="badge badge-pending"><%=status%></span>
                            <% } else if(status.equals("Approved")){ %>
                                <span class="badge badge-approved"><%=status%></span>
                            <% } else { %>
                                <span class="badge badge-rejected"><%=status%></span>
                            <% } %>
                        </td>
                        <td>
                            <% if(status.equals("Pending")){ %>
                                <form method="get" style="display:inline-block;">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <button type="submit" name="action" value="Approved" class="action-btn approve-btn">
                                        <i class="fa-solid fa-circle-check"></i> Approve
                                    </button>
                                    <button type="submit" name="action" value="Rejected" class="action-btn reject-btn">
                                        <i class="fa-solid fa-circle-xmark"></i> Reject
                                    </button>
                                </form>
                            <% } else { %>
                                <span class="text-muted">No Actions</span>
                            <% } %>
                        </td>
                    </tr>
                <%
                    }
                    if(!found){
                %>
                    <tr>
                        <td colspan="7" class="text-muted">No Pollution Certificate Requests Found</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
