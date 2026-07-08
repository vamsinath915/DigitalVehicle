<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="dbconnection.jsp" %>

<%
if(session.getAttribute("admin")==null){
    response.sendRedirect("adminLogin.jsp");
}
%>
<%
int totalUsers = 0;
int totalVehicles = 0;
int totalLicenses = 0;
int totalComplaints = 0;

try{

    // Total Users
    PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM users");
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()){
        totalUsers = rs1.getInt(1);
    }

    // Total Vehicles
    PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM vehicles");
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next()){
        totalVehicles = rs2.getInt(1);
    }

    // Total Licenses
    PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) FROM licenses");
    ResultSet rs3 = ps3.executeQuery();
    if(rs3.next()){
        totalLicenses = rs3.getInt(1);
    }

    // Total Complaints
    PreparedStatement ps4 = con.prepareStatement("SELECT COUNT(*) FROM vehicle_complaints");
    ResultSet rs4 = ps4.executeQuery();
    if(rs4.next()){
        totalComplaints = rs4.getInt(1);
    }

}catch(Exception e){
    out.println("Error: "+e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Glass Admin Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>

/* Animated Gradient Background */
body{
    margin:0;
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(-45deg,#6a11cb,#2575fc,#ff512f,#dd2476);
    background-size:400% 400%;
    animation: gradientBG 12s ease infinite;
    overflow-x:hidden;
}

@keyframes gradientBG{
    0%{background-position:0% 50%;}
    50%{background-position:100% 50%;}
    100%{background-position:0% 50%;}
}

/* Glass Effect */
.glass{
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.3);
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
}

/* Sidebar */
.sidebar{
    position:fixed;
    height:100vh;
    width:260px;
    padding:20px;
    color:#fff;
}

.sidebar h4{
    text-align:center;
    margin-bottom:30px;
    font-weight:600;
}

.sidebar a{
    display:block;
    padding:12px 15px;
    margin:8px 0;
    color:#fff;
    text-decoration:none;
    border-radius:12px;
    transition:0.3s;
}

.sidebar a:hover{
    background:rgba(255,255,255,0.2);
    transform:translateX(5px);
}

.submenu{
    display:none;
    padding-left:15px;
}

.submenu a{
    font-size:14px;
}

/* Content */
.content{
    margin-left:280px;
    padding:25px;
}

/* Topbar */
.topbar{
    padding:15px 20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    color:#fff;
}

/* Cards */
.stat-card{
    padding:25px;
    color:#fff;
    text-align:center;
    transition:0.3s;
}

.stat-card:hover{
    transform:translateY(-8px);
}

/* iframe */
iframe{
    width:100%;
    height:600px;
    border:none;
    border-radius:20px;
    margin-top:20px;
}

/* Mobile */
@media(max-width:768px){
    .sidebar{
        left:-260px;
        transition:0.3s;
    }
    .sidebar.active{
        left:0;
    }
    .content{
        margin-left:0;
    }
}

</style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar glass" id="sidebar">

    <h4>🚗 DVIS Admin</h4>

    <!-- Dashboard -->
    <a href="javascript:void(0)" onclick="showDashboard()">
        <i class="fa fa-home"></i> Dashboard
    </a>

    <!-- Users Menu -->
    <a href="javascript:void(0)" onclick="toggleUserMenu()">
        <i class="fa fa-users"></i> Users
        <i class="fa fa-chevron-down float-end"></i>
    </a>

    <div class="submenu" id="userMenu">
        <a href="addUser.jsp" target="contentFrame" class="menu-link">
            <i class="fa fa-user-plus"></i> Add User
        </a>
        <a href="manageUsers.jsp" target="contentFrame" class="menu-link">
            <i class="fa fa-user-gear"></i> Manage Users
        </a>
    </div>

    <!-- Insurance Company Menu -->
    <a href="javascript:void(0)" onclick="toggleInsuranceMenu()">
        <i class="fa fa-building"></i> Insurance Co.s
        <i class="fa fa-chevron-down float-end"></i>
    </a>

    <div class="submenu" id="insuranceMenu">
        <a href="manageInsuranceCompanies.jsp" target="contentFrame" class="menu-link">
            <i class="fa fa-briefcase"></i> Manage Companies
        </a>
    </div>

    <!-- Logout -->
    <a href="adminLogout.jsp">
        <i class="fa fa-sign-out-alt"></i> Logout
    </a>

</div>

<!-- Content -->
<div class="content">

    <!-- Topbar -->
    <div class="topbar glass">
        <button class="btn btn-light d-md-none" onclick="toggleSidebar()">
            <i class="fa fa-bars"></i>
        </button>

        <h5>Welcome, <%=session.getAttribute("admin")%></h5>

        <a href="adminLogout.jsp" class="btn btn-danger btn-sm">
            Logout
        </a>
    </div>

    <!-- Dashboard Cards -->
    <div class="row mt-4" id="dashboardSection">

        <div class="col-md-3 col-sm-6 mb-4">
            <div class="glass stat-card">
                <h6>Total Users</h6>
                <h2><%=totalUsers%></h2>
                <i class="fa fa-users fa-2x"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
            <div class="glass stat-card">
                <h6>Total Vehicles</h6>
                <h2><%=totalVehicles%></h2>
                <i class="fa fa-car fa-2x"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
            <div class="glass stat-card">
                <h6>Total Licenses</h6>
                <h2><%=totalLicenses%></h2>
                <i class="fa fa-id-card fa-2x"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
            <div class="glass stat-card">
                <h6>Total Complaints</h6>
                <h2><%=totalComplaints%></h2>
                <i class="fa fa-exclamation-triangle fa-2x"></i>
            </div>
        </div>

    </div>

    <!-- iframe -->
    <iframe name="contentFrame" id="iframeBox" style="display:none;"></iframe>

</div>

<script>

// Toggle Users Menu
function toggleUserMenu(){
    let menu = document.getElementById("userMenu");
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
}

// Toggle Insurance Menu
function toggleInsuranceMenu(){
    let menu = document.getElementById("insuranceMenu");
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
}

// Toggle Sidebar (Mobile)
function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("active");
}

// Hide Dashboard when any submenu link clicked
document.querySelectorAll('.menu-link').forEach(link=>{
    link.addEventListener('click',function(){
        document.getElementById("dashboardSection").style.display="none";
        document.getElementById("iframeBox").style.display="block";
    });
});

// Show Dashboard Again
function showDashboard(){
    document.getElementById("dashboardSection").style.display="flex";
    document.getElementById("iframeBox").style.display="none";
}

</script>


</body>
</html>
