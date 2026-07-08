<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Modern Card Layout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .navbar {
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .card {
            border: none;
            border-radius: 15px;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .card img {
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            height: 200px;
            object-fit: cover;
        }

        footer {
            background-color: #212529;
            color: white;
            padding: 15px;
            text-align: center;
            margin-top: 50px;
        }
    </style>
</head>

<body>

<!-- ? Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm">
    <div class="container">
       <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                    <img src="images/vehicle.png" alt="" width="80" height="74" class="d-inline-block align-text-top" >
                    <span class="brand-text">Digital Vehicle Information</span>
                </a>
                <!--<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>-->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="adminLogin.jsp">Admin Login</a>
<!--                <li class="nav-item"><a class="nav-link" href="#">Projects</a></li>-->
                <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- ? Cards Section -->
<div class="container mt-5">
    <div class="row g-4">

        <!-- Card 1 -->
        <div class="col-md-4">
            <div class="card">
                <img src="images/RTO.png" class="card-img-top" alt="Tech">
                <div class="card-body">
                    <h5 class="card-title">RTO</h5>
                    <p class="card-text">A government authority responsible for vehicle registration, driving licenses.</p>
                    <a href="r_login.jsp" class="btn btn-primary">Login</a>
                </div>
            </div>
        </div>

        <!-- Card 2 -->
        <div class="col-md-4">
            <div class="card">
                <img src="images/VEHICLE_OWNER.png" class="card-img-top" alt="Business">
                <div class="card-body">
                    <h5 class="card-title">VEHICLE OWNER</h5>
                    <p class="card-text">A person who legally owns and is responsible for a motor vehicle.</p>
                    <a href="v_login.jsp" class="btn btn-success">Login</a>
                </div>
            </div>
        </div>

        <!-- Card 3 -->
        <div class="col-md-4">
            <div class="card">
                <img src="images/POLLUTION.png" class="card-img-top" alt="Education">
                <div class="card-body">
                    <h5 class="card-title">POLLUTION CONTROL BOARD</h5>
                    <p class="card-text">Board ensures that vehicles comply with emission standards.</p>
                    <a href="pcb_login.jsp" class="btn btn-danger">Login</a>
                </div>
            </div>
        </div>

        <!-- Card 4 -->
        <div class="col-md-4">
            <div class="card">
                <img src="images/INSURANCE.png" class="card-img-top" alt="Coding">
                <div class="card-body">
                    <h5 class="card-title">INSURANCE COMPANY</h5>
                    <p class="card-text">A vehicle insurance company provides financial protection against damages, accidents, theft.</p>
                    <a href="i_login.jsp" class="btn btn-warning">Login</a>
                </div>
            </div>
        </div>

        <!-- Card 5 -->
        <div class="col-md-4">
            <div class="card">
                <img src="images/TRAFFIC.png" class="card-img-top" alt="AI">
                <div class="card-body">
                    <h5 class="card-title">TRAFFIC DEPARTMENT</h5>
                    <p class="card-text">The Traffic Department is responsible for regulating road safety, managing vehicle movement, and enforcing traffic laws.</p>
                    <a href="t_login.jsp" class="btn btn-info">Login</a>
                </div>
            </div>
        </div>

        <!-- Card 6 -->
        <div class="col-md-4">
            <div class="card">
                <img src="images/POLICE.png" class="card-img-top" alt="Startup">
                <div class="card-body">
                    <h5 class="card-title">POLICE DEPARTMENT</h5>
                    <p class="card-text">The Police Department is a government organization responsible for maintaining law and order, preventing crime.</p>
                    <a href="p_login.jsp" class="btn btn-dark">Login</a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- ? Footer -->
<footer>
    © 2026 Digital Vehicle | My Batch
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>