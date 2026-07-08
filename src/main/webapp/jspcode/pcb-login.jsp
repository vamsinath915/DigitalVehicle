<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="login.css">
    <script src="login.js"></script>
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
        </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark image-navbar fixed-top">
            <div class="container-fluid">
                 
                <a class="navbar-brand d-flex align-items-center" href="login.jsp">
                    <img src="images/vehicle.png" alt="" width="80" height="74" class="d-inline-block align-text-top" >
                    <span class="brand-text">Digital Vehicle Information</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav ms-auto">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                        <a class="nav-link" href="login.jsp">Logins</a>
                 <!--       <a class="nav-link" href="#">Pricing</a>
                        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>-->
                    </div>
                </div>
            </div>
        </nav>
<div class="container-fluid login-page mt-5 pt-4" style="background:url('images/bg3.jpg');background-size: cover; ">
    <div class="row min-vh-100">

        <!-- LEFT SIDE (Optional image/info) -->
        <div class="col-lg-7 d-none d-lg-flex left-panel">
            
            <img src="images/POLLUTION.png" width="550" height="350" style="border-radius: 20px" alt="User Icon">
        </div>

        <!-- RIGHT SIDE LOGIN FORM -->
        <div class="col-lg-5 col-md-8 col-sm-10 m-auto mr-auto">
            <div class="login-box">

                <div class="user-icon">
                    <img src="images/POLLUTION.png" alt="User Icon">
                </div>

                <h3 class="text-center mb-4">PCB Sign In</h3>

                <!-- Username -->
                <div class="input-group-custom">
                    <i class="bi bi-person"></i>
                    <input type="text" required>
                    <label>Username</label>
                </div>

                <!-- Password -->
                <div class="input-group-custom">
                    <i class="bi bi-lock"></i>
                    <input type="password" id="password" required>
                    <label>Password</label>
                    <span class="toggle-password" onclick="togglePassword()">
                        <i class="bi bi-eye" id="eyeIcon"></i>
                    </span>
                </div>

                <button class="btn btn-primary w-100 mt-3">Login</button>

            </div>
        </div>

    </div>
</div>

<!-- JS -->
<script src="login.js"></script>

</body>
</html>
