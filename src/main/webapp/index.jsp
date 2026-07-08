<%-- 
    Document   : index
    Created on : 4 Feb, 2026, 4:29:19 AM
    Author     : SRIGANESH
--%>
<%
response.sendRedirect("jspcode/adminLogin.jsp");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            .image-navbar {
                background-image: url("images/banner.jpg");
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }

            /* Optional overlay for text readability */
            .image-navbar::before {
                content: "";
                position: absolute;
                inset: 0;
                background: rgba(0, 0, 0, 0.45);
                z-index: 0;
            }

            .image-navbar .container-fluid {
                position: relative;
                z-index: 1;
            }
            body{
                margin: 0;
                padding: 0;
                background: url("images/bg.jpg");
                background-size: cover;
            }
            .content-box {
                background: rgba(255, 255, 255, 0.25); /* transparent white */
                backdrop-filter: blur(12px);          /* glass blur */
                -webkit-backdrop-filter: blur(12px);  /* Safari support */

                border-radius: 16px;
                padding: 40px 35px;

                box-shadow:
                    0 8px 32px rgba(0, 0, 0, 0.25),
                    inset 0 1px 0 rgba(255, 255, 255, 0.4);

                    border: 1px solid rgba(255, 255, 255, 0.3);
            }
/*            .home-section {
    min-height: 100vh;
    background: linear-gradient(
        rgba(0,0,0,0.55),
        rgba(0,0,0,0.55)
    ),
    url("home-bg.jpg") center/cover no-repeat;
}

 Main Box 
.premium-box {
    position: relative;
    padding: 45px 40px;
    border-radius: 20px;

    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(14px);
    -webkit-backdrop-filter: blur(14px);

    border: 1px solid rgba(255, 255, 255, 0.35);

    box-shadow:
        0 20px 40px rgba(0, 0, 0, 0.35),
        inset 0 1px 0 rgba(255,255,255,0.4);

    color: #fff;
    transition: transform 0.35s ease, box-shadow 0.35s ease;
}

 Hover animation 
.premium-box:hover {
    transform: translateY(-8px) scale(1.01);
    box-shadow: 0 30px 55px rgba(0,0,0,0.45);
}

 Icon 
.icon-circle {
    width: 70px;
    height: 70px;
    margin: 0 auto;
    border-radius: 50%;
    background: linear-gradient(135deg, #0d6efd, #0b3c5d);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 30px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.3);
}

 Title 
.title {
    font-size: 34px;
    font-weight: 700;
    margin-top: 15px;
}

 Subtitle 
.subtitle {
    font-size: 17px;
    line-height: 1.7;
    color: #e0e0e0;
    margin-top: 10px;
}

 Buttons 
.btn-primary {
    border-radius: 30px;
}

.btn-outline-light {
    border-radius: 30px;
}*/
/* Background */
/*.home-section {
    min-height: 100vh;
    background:
        linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
        url("home-bg.jpg") center/cover no-repeat;
}

 Gradient Border Wrapper 
.gradient-border-box {
    position: relative;
    padding: 3px;
    border-radius: 24px;
    background: linear-gradient(
        270deg,
        #0d6efd,
        #00c6ff,
        #6f42c1,
        #0d6efd
    );
    background-size: 600% 600%;
    animation: gradientMove 6s ease infinite;
}

 Actual Content Box 
.content-box {
    background: rgba(255, 255, 255, 0.18);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);

    border-radius: 20px;
    padding: 45px 40px;
    color: #fff;

    box-shadow:
        0 20px 40px rgba(0,0,0,0.35),
        inset 0 1px 0 rgba(255,255,255,0.4);

    transition: transform 0.35s ease, box-shadow 0.35s ease;
}

 Hover Effect 
.gradient-border-box:hover .content-box {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 30px 60px rgba(0,0,0,0.45);
}

 Icon 
.icon-circle {
    width: 75px;
    height: 75px;
    margin: 0 auto;
    border-radius: 50%;
    background: linear-gradient(135deg, #0d6efd, #0b3c5d);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.4);
}

 Text 
.title {
    font-size: 36px;
    font-weight: 700;
    margin-top: 15px;
}

.subtitle {
    font-size: 17px;
    line-height: 1.7;
    color: #e0e0e0;
    margin-top: 12px;
}

 Buttons 
.btn-primary,
.btn-outline-light {
    border-radius: 30px;
}

 Gradient Animation 
@keyframes gradientMove {
    0%   { background-position: 0% 50%; }
    50%  { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}*/

/* Page Background */
.home-section {
    min-height: 100vh;
    background:
        linear-gradient(rgba(0,0,0,0.65), rgba(0,0,0,0.65)),
        url("vehicle-bg.jpg") center/cover no-repeat;
}

/* Animated Border Wrapper */
.gradient-border-box {
    position: relative;
    padding: 3px;
    border-radius: 26px;
    background: linear-gradient(
        270deg,
        #0d6efd,
        #00c6ff,
        #20c997,
        #6f42c1,
        #0d6efd
    );
    background-size: 600% 600%;
    animation: gradientMove 7s ease infinite;
}

/* Glass Content Box */
.content-box {
    background: rgba(255, 255, 255, 0.18);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);

    border-radius: 22px;
    padding: 50px 45px;
    color: #ffffff;

    box-shadow:
        0 25px 50px rgba(0,0,0,0.45),
        inset 0 1px 0 rgba(255,255,255,0.4);

    transition: transform 0.4s ease, box-shadow 0.4s ease;
}

/* Hover Lift */
.gradient-border-box:hover .content-box {
    transform: translateY(-10px) scale(1.02);
    box-shadow: 0 35px 70px rgba(0,0,0,0.55);
}

/* Icon */
.icon-circle {
    width: 80px;
    height: 80px;
    margin: 0 auto;
    border-radius: 50%;
    background: linear-gradient(135deg, #0d6efd, #0b3c5d);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 34px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.45);
}

/* Title */
.title {
    font-size: 38px;
    font-weight: 800;
    margin-top: 18px;
}

/* Description */
.subtitle {
    font-size: 17px;
    line-height: 1.8;
    color: #e5e5e5;
    margin-top: 15px;
}

/* User Tags */
.user-tags {
    margin-top: 15px;
}

.user-tags span {
    display: inline-block;
    margin: 6px 6px;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 14px;
    background: rgba(255,255,255,0.2);
    border: 1px solid rgba(255,255,255,0.3);
}

/* Buttons */
.btn-primary,
.btn-outline-light {
    border-radius: 30px;
}

/* Gradient Animation */
@keyframes gradientMove {
    0%   { background-position: 0% 50%; }
    50%  { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

        </style>
    </head>
    <body>
<!--        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    
                    Digital Vehicle Information
                </a>
            </div>
        </nav>-->
<!--        <nav class="navbar navbar-expand-lg navbar-dark image-navbar">
            <div class="container-fluid">
                 
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <img src="images/vehicle.png" alt="" width="80" height="74" class="d-inline-block align-text-top" >
                    <span class="brand-text">Digital Vehicle Information</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav ms-auto">
                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                        <a class="nav-link" href="#">Features</a>
                        <a class="nav-link" href="#">Pricing</a>
                        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                    </div>
                </div>
            </div>
        </nav>-->
<!--<section class="hero-section d-flex align-items-center">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-7 col-md-9" style="margin-top: 100px;">

        <div class="content-box text-center" >
          <h1 class="mb-3" style="color:#fff;">Welcome to Smart Transport Portal</h1>
          <p class="mb-4" style="color:#fff;">
            One integrated platform for RTO services, vehicle ownership,
            insurance verification, traffic management, and police coordination.
          </p>

          <a href="login.jsp" class="btn btn-dark btn-lg">
            Get Started ->
          </a>
        </div>

      </div>
    </div>
  </div>
</section>-->
<!--<section class="home-section d-flex justify-content-center align-items-center">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-7 col-md-9">

        <div class="premium-box text-center">
          <div class="icon-circle mb-3">
            🚦
          </div>

          <h1 class="title">Smart Transport Portal</h1>

          <p class="subtitle">
            A unified digital platform connecting RTO, Vehicle Owners,
            Insurance, Traffic & Police Departments for smarter governance.
          </p>

          <div class="mt-4">
            <a href="login.jsp" class="btn btn-primary btn-lg px-4 me-2">
              Get Started
            </a>
            <a href="about.jsp" class="btn btn-outline-light btn-lg px-4">
              Learn More
            </a>
          </div>
        </div>

      </div>
    </div>
  </div>
</section>-->

<section class="home-section d-flex justify-content-center align-items-center">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-8 col-md-10">

        <div class="gradient-border-box">
          <div class="content-box text-center">

            <div class="icon-circle mb-3">🚘</div>

            <h1 class="title">Digital Vehicle Information System</h1>

            <p class="subtitle">
              A unified e-Governance platform enabling seamless information
              sharing among <strong>RTO</strong>, <strong>Vehicle Owners</strong>,
              <strong>Pollution Control Board</strong>, <strong>Insurance</strong>,
              <strong>Traffic</strong>, and <strong>Police Departments</strong>
              for secure, transparent, and efficient vehicle management.
            </p>

<!--            <div class="user-tags mt-3">
              <span>RTO</span>
              <span>Vehicle Owner</span>
              <span>PCB</span>
              <span>Insurance</span>
              <span>Traffic Dept</span>
              <span>Police Dept</span>
            </div>-->

            <div class="mt-4">
              <a href="menu.jsp" class="btn btn-dark btn-lg px-4 me-2">
                Get Started <i class="bi bi-arrow-right ms-2"></i>
              </a>
<!--              <a href="about.jsp" class="btn btn-outline-light btn-lg px-4">
                Learn More
              </a>-->
            </div>

          </div>
        </div>

      </div>
    </div>
  </div>
</section>


    </body>
</html>
