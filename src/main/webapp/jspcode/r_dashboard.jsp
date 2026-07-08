<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="dbconnection.jsp" %>
<%
int vehicles=0, total=0, approved=0, pending=0;

try{

    // Total Users
    PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM vehicles");
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()){
        vehicles = rs1.getInt(1);
    }

    // Total Vehicles
    PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM licenses");
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next()){
        total = rs2.getInt(1);
    }

    // Total Licenses
    PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) FROM licenses where status='Approved'");
    ResultSet rs3 = ps3.executeQuery();
    if(rs3.next()){
        approved = rs3.getInt(1);
    }

    // Total Complaints
    PreparedStatement ps4 = con.prepareStatement("SELECT COUNT(*) FROM licenses where status='Pending'");
    ResultSet rs4 = ps4.executeQuery();
    if(rs4.next()){
        pending = rs4.getInt(1);
    }

}catch(Exception e){
    out.println("Error: "+e.getMessage());
}
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="p-4">
<h4>RTO Admin Dashboard</h4>

<div class="row">

  <div class="col-md-3">
    <div class="card text-white bg-primary shadow">
      <div class="card-body">
        <h6>Total Registered Vehicles</h6>
        <h3><%=vehicles%></h3>
      </div>
    </div>
  </div>

  <div class="col-md-3">
    <div class="card text-white bg-warning shadow">
      <div class="card-body">
        <h6>Total License Requests</h6>
        <h3><%=total%></h3>
      </div>
    </div>
  </div>

  <div class="col-md-3">
    <div class="card text-white bg-success shadow">
      <div class="card-body">
        <h6>Approved Requests</h6>
        <h3><%=approved%></h3>
      </div>
    </div>
  </div>

  <div class="col-md-3">
    <div class="card text-white bg-danger shadow">
      <div class="card-body">
        <h6>Pending Requests</h6>
        <h3><%=pending%></h3>
      </div>
    </div>
  </div>

</div>

<!--<div class="row">
<div class="col-md-3"><div class="card p-3 text-center"><h6>Total Vehicles</h6><h3><%=vehicles%></h3></div></div>
<div class="col-md-3"><div class="card p-3 text-center"><h6>Total Requests</h6><h3><%=total%></h3></div></div>
<div class="col-md-3"><div class="card p-3 text-center"><h6>Approved</h6><h3 class="text-success"><%=approved%></h3></div></div>
<div class="col-md-3"><div class="card p-3 text-center"><h6>Pending</h6><h3 class="text-danger"><%=pending%></h3></div></div>
</div>-->

<div class="mt-4 d-flex justify-content-center">
    <div style="width:250px; height:250px;">
        <h5>License Request Status</h5>
        <canvas id="licenseChart"></canvas>
    </div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
<script>
const ctx = document.getElementById('licenseChart');

new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: ['Approved', 'Pending'],
        datasets: [{
            data: [<%=approved%>,<%=pending%>],   // Your counts here
            backgroundColor: ['#28a745', '#D63A3A'],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'bottom'
            },
            datalabels: {
                color: '#000',
                font: {
                    weight: 'bold',
                    size: 14
                },
                formatter: function(value) {
                    return value;   // Shows count inside chart
                }
            }
        }
    },
    plugins: [ChartDataLabels]
});
</script>