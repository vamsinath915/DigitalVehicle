<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
//String user = "Admin";

    // Disable browser caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if(username == null) {
        response.sendRedirect("i_login.jsp"); // Redirect to login if session expired
        return;
    }

%>
<!DOCTYPE html>
<html>
<head>
<title>Vehicle Owner Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
body {
    overflow-x: hidden;
}

/* Sidebar */
.sidebar {
    height: 100vh;
    background: #1e293b;
    color: white;
    padding-top: 20px;
}

.sidebar a {
    color: #cbd5e1;
    padding: 10px 20px;
    display: block;
    text-decoration: none;
    font-size: 14px;
}

.sidebar a:hover, .sidebar a.active {
    background: #0d6efd;
    color: white;
}

.sidebar .menu-item {
    cursor: pointer;
    padding: 12px 20px;
    display: flex;
    align-items: center;
    justify-content: flex-start;
    transition: all 0.3s;
}

.sidebar .menu-item i {
    margin-right: 10px;
}

.sidebar .menu-item:hover {
    background: #334155;
}

.sidebar .menu-item.active {
    background: #0d6efd;
}


.sidebar .submenu {
    display: none;
    background: #273549;
}

.sidebar .submenu a {
    display: block;
    padding: 10px 40px;
    color: #cbd5e1;
    text-decoration: none;
    font-size: 13px;
    transition: all 0.3s;
}

.sidebar .submenu a:hover {
    background: #0d6efd;
    color: white;
}
/* iframe */
.content-frame {
    width: 100%;
    height: calc(100vh - 70px);
    border: none;
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container-fluid">
        <span class="navbar-brand fw-bold text-primary">Insurance Admin Panel</span>

        <div class="dropdown ms-auto">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                <i class="fa fa-user-circle"></i> <%=session.getAttribute("username")!=null?session.getAttribute("username"):"Owner"%>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item text-danger" href="i_logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
<div class="row">

<!-- SIDEBAR -->
<div class="col-md-2 sidebar">

    <a href="i_dashboard.jsp" target="contentFrame" class="menu-item active">
        <i class="fa fa-chart-pie"></i> Dashboard
    </a>

    <a data-bs-toggle="collapse" href="#licenseMenu"  class="menu-item" onclick="toggleMenu(this,'licenseSub')">
        <i class="fa fa-id-card"></i> Policy Info
        <i class="fa fa-chevron-down ms-auto"></i>
    </a>
    <div class="submenu" id="licenseSub">
        <a href="CreatePolicy.jsp" target="contentFrame"><i class="fa fa-check-circle small-icon"></i> Create Policy</a>
        <a href="ViewPolicies.jsp" target="contentFrame"><i class="fa fa-file-text small-icon"></i> Manage Policy</a>
    </div>

    <a data-bs-toggle="collapse" href="#pollutionMenu"  class="menu-item" onclick="toggleMenu(this,'pollutionSub')">
        <i class="fa fa-leaf"></i> New Requests
        <i class="fa fa-chevron-down ms-auto"></i>
    </a>
    <div class="submenu" id="pollutionSub">
        <a href="ViewApprovedRequests.jsp" target="contentFrame"><i class="fa fa-check small-icon"></i> Approved</a>
        <a href="ins_newrequests.jsp" target="contentFrame"><i class="fa fa-clock small-icon"></i> Pending </a>
    </div>

    <a data-bs-toggle="collapse" href="#insuranceMenu" class="menu-item" onclick="toggleMenu(this,'insuranceSub')">
        <i class="fa fa-shield-alt"></i> Renewal Requests
        <i class="fa fa-chevron-down ms-auto"></i>
    </a>
     <div class="submenu" id="insuranceSub">
         <a href="ins_renewalApproved.jsp" target="contentFrame"><i class="fa fa-check small-icon"></i> Approved </a>
         <a href="ins_renewalRequests.jsp" target="contentFrame"><i class="fa fa-clock small-icon"></i> Pending </a>
    </div>

<!--    <a data-bs-toggle="collapse" href="#challanMenu" class="menu-item" onclick="toggleMenu(this,'challanSub')">
        <i class="fa fa-file-invoice-dollar"></i> Traffic Challans
         <i class="fa fa-chevron-down ms-auto"></i>
    </a>
   <div class="submenu" id="challanSub">
        <a href="pending_challans.jsp" target="contentFrame"><i class="fa fa-clock small-icon"></i> Pending</a>
        <a href="challans_info.jsp" target="contentFrame"><i class="fa fa-check small-icon"></i> Paid</a>
    </div>

    <a data-bs-toggle="collapse" href="#policeMenu" class="menu-item" onclick="toggleMenu(this,'complaintSub')">
        <i class="fa fa-exclamation-triangle"></i> Police Complaints
        <i class="fa fa-chevron-down ms-auto"></i>
    </a>
    <div class="submenu" id="complaintSub">
        <a href="police_complaints.jsp" target="contentFrame"><i class="fa fa-info-circle small-icon"></i> Complaint Status</a>
        <a href="add_complaint.jsp" target="contentFrame"><i class="fa fa-plus-circle small-icon"></i> Add Complaint</a>
    </div>-->
    <a  href="changePassword.jsp" target="contentFrame" class="menu-item">
        <i class="fa fa-key"></i> Change Password
    </a>
<a  href="ins_Feedback.jsp" target="contentFrame" class="menu-item">
        <i class="fa fa-comment"></i> Feedback
        
    </a>
     
    <a href="i_logout.jsp" class="menu-item">
        <i class="fa fa-lock"></i> Logout
    </a>
</div>

<!-- RIGHT SIDE CONTENT -->
<div class="col-md-10 p-0">
    <iframe name="contentFrame" src="i_dashboard.jsp" class="content-frame"></iframe>
</div>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function toggleMenu(element, submenuId) {
    const submenus = document.querySelectorAll('.submenu');
    const menuItems = document.querySelectorAll('.menu-item');

    // Hide all other submenus
    submenus.forEach(menu => {
        if(menu.id !== submenuId) menu.style.display = 'none';
    });

    // Remove active class from other menu-items
    menuItems.forEach(item => {
        if(item !== element && !item.hasAttribute('href')) item.classList.remove('active');
    });

    // Toggle current submenu
    const submenu = document.getElementById(submenuId);
    if(submenu.style.display === 'block') {
        submenu.style.display = 'none';
        element.classList.remove('active');
    } else {
        submenu.style.display = 'block';
        element.classList.add('active');
    }
}

// Highlight active menu item when clicked
const sidebarLinks = document.querySelectorAll('.sidebar a');
sidebarLinks.forEach(link => {
    link.addEventListener('click', function() {
        sidebarLinks.forEach(l => l.classList.remove('active'));
        this.classList.add('active');
    });
});
</script>
</body>
</html>