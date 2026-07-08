<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
if(session.getAttribute("admin")==null){
    response.sendRedirect("adminLogin.jsp");
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

    <a href="javascript:void(0)" onclick="showDashboard()">
        <i class="fa fa-home"></i> Dashboard
    </a>

    <a href="javascript:void(0)" onclick="toggleMenu()">
        <i class="fa fa-users"></i> Users
        <i class="fa fa-chevron-down float-end"></i>
    </a>

    <div class="submenu" id="userMenu">
        <a href="addUser.jsp" target="contentFrame">
            <i class="fa fa-user-plus"></i> Add User
        </a>
        <a href="manageUsers.jsp" target="contentFrame">
            <i class="fa fa-user-gear"></i> Manage Users
        </a>
    </div>

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
                <h2>150</h2>
                <i class="fa fa-users fa-2x"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
            <div class="glass stat-card">
                <h6>Total Vehicles</h6>
                <h2>420</h2>
                <i class="fa fa-car fa-2x"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
            <div class="glass stat-card">
                <h6>Total Licenses</h6>
                <h2>300</h2>
                <i class="fa fa-id-card fa-2x"></i>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
            <div class="glass stat-card">
                <h6>Total Complaints</h6>
                <h2>50</h2>
                <i class="fa fa-exclamation-triangle fa-2x"></i>
            </div>
        </div>

    </div>

    <!-- iframe -->
    <iframe name="contentFrame" id="iframeBox" style="display:none;"></iframe>

</div>

<script>

function toggleMenu(){
    var menu=document.getElementById("userMenu");
    menu.style.display=(menu.style.display==="block")?"none":"block";
}

function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("active");
}

document.querySelectorAll('.submenu a').forEach(link=>{
    link.addEventListener('click',function(){
        document.getElementById("dashboardSection").style.display="none";
        document.getElementById("iframeBox").style.display="block";
    });
});

function showDashboard(){
    document.getElementById("dashboardSection").style.display="flex";
    document.getElementById("iframeBox").style.display="none";
}

</script>

</body>
</html>
