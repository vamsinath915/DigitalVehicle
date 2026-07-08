<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Owner Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
.dashboard-card {
    border-radius: 12px;
    color: white;
    transition: 0.3s;
}
.dashboard-card:hover {
    transform: translateY(-5px);
}

.bg-blue { background: linear-gradient(45deg,#007bff,#00c6ff); }
.bg-green { background: linear-gradient(45deg,#28a745,#85e085); }
.bg-orange { background: linear-gradient(45deg,#ff9800,#ffc107); }
.bg-red { background: linear-gradient(45deg,#dc3545,#ff6b6b); }
.bg-purple { background: linear-gradient(45deg,#6f42c1,#a084e8); }
.bg-darkblue { background: linear-gradient(45deg,#343a40,#6c757d); }

.icon-box {
    font-size: 26px;
}

.chart-box {
    height: 300px;
}
</style>

</head>
<body>
<%
    int total =0, approved = 0, pending = 0, rtotal=0, rapproved=0, rpending=0;
    String username = session.getAttribute("username").toString();
    ResultSet rs = null;
    
    PreparedStatement ps = null;
    String sql = "Select count(application_id) from vehicle_insurance_applications where instype='New'";
    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();
    if(rs.next())
    {
        total = rs.getInt(1);
    }
    String sql1 = "Select count(application_id) from vehicle_insurance_applications where instype='New' and status='Approved'";
    ps = con.prepareStatement(sql1);
    rs = ps.executeQuery();
    if(rs.next())
    {
        approved = rs.getInt(1);
    }
    
    String sql2 = "Select count(application_id) from vehicle_insurance_applications where instype='New' and status='Pending'";
    ps = con.prepareStatement(sql2);
    rs = ps.executeQuery();
    if(rs.next())
    {
        pending = rs.getInt(1);
    }
    
    String sql3 = "Select count(application_id) from vehicle_insurance_applications where instype='Renewal'";
    ps = con.prepareStatement(sql3);
    rs = ps.executeQuery();
    if(rs.next())
    {
        rtotal = rs.getInt(1);
    }
    
    String sql4 = "Select count(application_id) from vehicle_insurance_applications where instype='Renewal' and status='Approved'";
    ps = con.prepareStatement(sql4);
    rs = ps.executeQuery();
    if(rs.next())
    {
        rapproved = rs.getInt(1);
    }
    
    String sql5 = "Select count(application_id) from vehicle_insurance_applications where instype='Renewal' and status='Pending'";
    ps = con.prepareStatement(sql5);
    rs = ps.executeQuery();
    if(rs.next())
    {
        rpending = rs.getInt(1);
    }
    
%>
<div class="container-fluid p-4">
<h4 class="mb-4">Insurance Admin Dashboard</h4>

<!-- ================= SUMMARY CARDS ================= -->

<div class="row g-4">

    <div class="col-md-4 col-sm-6">
        <div class="card dashboard-card bg-darkblue shadow">
            <div class="card-body d-flex justify-content-between">
                <div>
                    <h6>Total New Requests</h6>
                    <h3><%=total%></h3>
                </div>
                <div class="icon-box">
                    <i class="fa fa-file-invoice-dollar"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-4 col-sm-6">
        <div class="card dashboard-card bg-green shadow">
            <div class="card-body d-flex justify-content-between">
                <div>
                    <h6>Approved Requests</h6>
                    <h3><%=approved%></h3>
                </div>
                <div class="icon-box">
                    <i class="fa fa-check-circle"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-4 col-sm-6">
        <div class="card dashboard-card bg-orange shadow">
            <div class="card-body d-flex justify-content-between">
                <div>
                    <h6>Pending Requests</h6>
                    <h3><%=pending%></h3>
                </div>
                <div class="icon-box">
                    <i class="fa fa-clock"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-4 col-sm-6">
        <div class="card dashboard-card bg-purple shadow">
            <div class="card-body d-flex justify-content-between">
                <div>
                    <h6>Total Renewal Requests</h6>
                    <h3><%=rtotal%></h3>
                </div>
                <div class="icon-box">
                    <i class="fa fa-exclamation-triangle"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-4 col-sm-6">
        <div class="card dashboard-card bg-blue shadow">
            <div class="card-body d-flex justify-content-between">
                <div>
                    <h6>Approved Renewal Requests</h6>
                    <h3><%=rapproved%></h3>
                </div>
                <div class="icon-box">
                    <i class="fa fa-check"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-4 col-sm-6">
        <div class="card dashboard-card bg-red shadow">
            <div class="card-body d-flex justify-content-between">
                <div>
                    <h6>Pending Renewal Requests</h6>
                    <h3><%=rpending%></h3>
                </div>
                <div class="icon-box">
                    <i class="fa fa-hourglass-half"></i>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- ================= DOUGHNUT CHARTS ================= -->

<div class="row mt-5">

    <div class="col-md-6">
        <div class="card shadow p-3">
            <h6 class="text-center">New Insurance Request Status Overview</h6>
            <div class="chart-box">
                <canvas id="challanChart"></canvas>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card shadow p-3">
            <h6 class="text-center">Renewal Insurance Request Status Overview</h6>
            <div class="chart-box" >
                <canvas id="complaintChart"></canvas>
            </div>
        </div>
    </div>

</div>
<!--<div class="chart-container">
    <canvas id="barChart"></canvas>
</div>-->

</div>
<script>
/* Challan Chart */
new Chart(document.getElementById("challanChart"), {
    type: 'doughnut',
    data: {
        labels: ['Approved', 'Pending'],
        datasets: [{
            data: [<%=approved%>, <%=pending%>],
            backgroundColor: ['#28a745','#ffc107']
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});

/* Complaint Chart */
new Chart(document.getElementById("complaintChart"), {
    type: 'doughnut',
    data: {
        labels: ['Approved', 'Pending'],
        datasets: [{
            data: [<%=rapproved%>, <%=rpending%>],
            backgroundColor: ['#007bff','#dc3545']
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});
</script>
</body>
</html>