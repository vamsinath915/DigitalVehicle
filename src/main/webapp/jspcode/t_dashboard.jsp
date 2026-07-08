<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp" %>
<%
    String username = session.getAttribute("username").toString();
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    int total=0, paid=0,unpaid=0;
    String sql = "Select count(challan_id) from traffic_challans";
    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();
    if(rs.next())
    {
        total = rs.getInt(1);
    }
    String sql1 = "Select count(challan_id) from traffic_challans where status='Paid'";
    ps = con.prepareStatement(sql1);
    rs = ps.executeQuery();
    if(rs.next())
    {
        paid = rs.getInt(1);
    }
    
    String sql2 = "Select count(challan_id) from traffic_challans where status='UnPaid'";
    ps = con.prepareStatement(sql2);
    rs = ps.executeQuery();
    if(rs.next())
    {
        unpaid = rs.getInt(1);
    }
    
    
%>
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

<div class="container-fluid p-4">
<h4 class="mb-4">Traffic Admin Dashboard</h4>

<!-- ================= SUMMARY CARDS ================= -->

<div class="row g-4">

    <div class="col-md-4 col-sm-6">
        <div class="card dashboard-card bg-blue shadow">
            <div class="card-body d-flex justify-content-between">
                <div>
                    <h6>Total Challans</h6>
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
                    <h6>Paid Challans</h6>
                    <h3><%=paid%></h3>
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
                    <h6>Pending Challans</h6>
                    <h3><%=unpaid%></h3>
                </div>
                <div class="icon-box">
                    <i class="fa fa-clock"></i>
                </div>
            </div>
        </div>
    </div>

    
<!-- ================= DOUGHNUT CHARTS ================= -->

<div class="row mt-5">

    <div >
        <div class="card shadow p-3">
            <h6 class="text-center">Challan Status Overview</h6>
            <div class="chart-box">
                <canvas id="pcbrequests"></canvas>
            </div>
        </div>
    </div>

    

</div>

</div>

<script>
/* Challan Chart */
new Chart(document.getElementById("pcbrequests"), {
    type: 'doughnut',
    data: {
        labels: ['Paid', 'UnPaid'],
        datasets: [{
            data: [<%=paid%>, <%=unpaid%>],
            backgroundColor: ['#28a745','#ffc107']
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