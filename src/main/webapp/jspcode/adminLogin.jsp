<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Login | Digital Vehicle System</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    height:100vh;
    background: linear-gradient(135deg,#1e3c72,#2a5298);
    display:flex;
    justify-content:center;
    align-items:center;
    font-family: 'Segoe UI', sans-serif;
}

.login-card{
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(10px);
    border-radius:15px;
    padding:40px;
    width:100%;
    max-width:400px;
    box-shadow:0 10px 25px rgba(0,0,0,0.3);
    color:#fff;
}

.login-card h3{
    text-align:center;
    margin-bottom:25px;
    font-weight:600;
}

.form-control{
    border-radius:10px;
}

.btn-custom{
    background:#00c6ff;
    border:none;
    border-radius:10px;
    font-weight:600;
    transition:0.3s;
}

.btn-custom:hover{
    background:#0072ff;
}

.footer-text{
    text-align:center;
    margin-top:15px;
    font-size:14px;
}

.error-msg{
    color:#ffcccc;
    text-align:center;
    margin-bottom:10px;
}

@media(max-width:576px){
    .login-card{
        padding:25px;
    }
}
</style>

</head>
<body>

<div class="login-card">

    <h3>Admin Login</h3>

    <% if(request.getParameter("error")!=null){ %>
        <div class="error-msg">Invalid Username or Password</div>
    <% } %>

    <form action="adminLoginValidate.jsp" method="post">
        <div class="mb-3">
            <input type="text" name="username" class="form-control" placeholder="Enter Username" required>
        </div>

        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-custom">Login</button>
        </div>
    </form>

    <div class="footer-text">
        © 2026 Digital Vehicle Information System
    </div>

</div>

</body>
</html>
