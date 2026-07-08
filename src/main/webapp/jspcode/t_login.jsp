<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Responsive Split Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            //background-color: #f8f9fa;
            background: url('images/bg_f.jpg');
            background-size: cover;
        }

        .navbar {
            background-color: white;
            margin-bottom: 100px; 
        }

        .login-section {
            min-height: 100vh;
        }

        .left-side {
           // background: url('https://images.unsplash.com/photo-1553877522-43269d4ea984') no-repeat center center;
            background-size: cover;
        }

        .login-card {
            
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .logo {
           
            width: 60px;
            border-radius: 50px;
            margin-bottom: 10px;
            
        }

        .input-group-text {
            background-color: #f1f1f1;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #0d6efd;
        }

        .login-btn {
            background-color: #0d6efd;
            border: none;
        }

        .login-btn:hover {
            background-color: #084298;
        }

        .links a {
            text-decoration: none;
            font-size: 14px;
        }

        .links a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .left-side {
                display: none;
            }
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
                    <span class="navbar-toggler-icon"></span>-->
                </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="menu.jsp">Logins</a></li>
               <!-- <li class="nav-item"><a class="nav-link" href="#">Projects</a></li>-->
                <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- ? Login Section -->
<div class="container-fluid login-section">
    <div class="row">

        <!-- LEFT SIDE (Optional image/info) -->
        <div class="col-md-6 d-none d-lg-flex left-panel">
            
            <img src="images/TRAFFIC.png" width="550" height="350" style="border-radius: 20px;margin-left: 100px;box-shadow: 4px 4px 8px 0 rgba(0, 0, 0, 0.5); " alt="User Icon">
        </div>

        <!-- Right Login Form -->
        <div class="col-md-6 d-flex justify-content-center align-items-center">
            <div class="col-md-8 col-lg-6">
                <div class="card login-card p-4">

                    <div class="text-center">
                        <img src="images/TRAFFIC.png"  class="logo" alt="Logo">
                        <h4 class="mb-3">Login</h4>
                    </div>

                    <form method="POST" action="usersLoginValidate.jsp">

                        <!-- Username -->
                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-person-fill"></i>
                                </span>
                                <input type="text" class="form-control" name="username" placeholder="User ID" required>
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-lock-fill"></i>
                                </span>
                                <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
                                <span class="input-group-text" onclick="togglePassword()" style="cursor:pointer;">
                                    <i class="bi bi-eye-fill" id="toggleIcon"></i>
                                </span>
                            </div>
                        </div>

                        <!-- Login Button -->
                        <div class="d-grid">
                            <button type="submit" class="btn login-btn text-white">Login</button>
                        </div>

                        <!-- Links -->
                        <div class="text-center mt-3 links">
                            <a href="#">Forgot Password?</a> 
<!--                            |
                            <a href="#">New User?</a>-->
                        </div>

                    </form>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- ? Show/Hide Password Script -->
<script>
    function togglePassword() {
        var password = document.getElementById("password");
        var icon = document.getElementById("toggleIcon");

        if (password.type === "password") {
            password.type = "text";
            icon.classList.remove("bi-eye-fill");
            icon.classList.add("bi-eye-slash-fill");
        } else {
            password.type = "password";
            icon.classList.remove("bi-eye-slash-fill");
            icon.classList.add("bi-eye-fill");
        }
    }
</script>

</body>
</html>