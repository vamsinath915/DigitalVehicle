<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnection.jsp" %>
<%
if(session.getAttribute("username")==null){
%>
<script>
    window.top.location.href="login.jsp";
</script>
<%
    return;
}

//Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String message="";
String alertType="";

try{
    if(request.getMethod().equalsIgnoreCase("POST")){

        String userId="";
        String username=(String)session.getAttribute("username");
        String department=request.getParameter("department");
        String feedbackMsg=request.getParameter("message");
        int rating=Integer.parseInt(request.getParameter("rating"));

//        Class.forName("com.mysql.jdbc.Driver");
//        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");

        // Get user_id
        /* ps=con.prepareStatement("SELECT user_id FROM users WHERE username=?");
        ps.setString(1,username);
        rs=ps.executeQuery();
        if(rs.next()){
            userId=rs.getString("uid");
        }*/
        
        // Insert feedback
        ps=con.prepareStatement("INSERT INTO feedback(user_id,department,message,rating) VALUES(?,?,?,?)");
        ps.setString(1,username);
        ps.setString(2,department);
        ps.setString(3,feedbackMsg);
        ps.setInt(4,rating);

        int i=ps.executeUpdate();

        if(i>0){
            message="Feedback submitted successfully.";
            alertType="success";
        }else{
            message="Failed to submit feedback.";
            alertType="danger";
        }
    }

}catch(Exception e){
    message="Error: "+e.getMessage();
    alertType="danger";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Feedback</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{
    background-color:#f1f4f8;
    font-family:'Segoe UI',sans-serif;
}

.page-header{
    background-color:#0d6efd;
    color:white;
    padding:20px 30px;
    border-radius:8px;
    margin-bottom:25px;
    box-shadow:0 3px 10px rgba(0,0,0,0.1);
}

.card{
    border:none;
    border-radius:10px;
    box-shadow:0 4px 20px rgba(0,0,0,0.08);
}

.form-label{
    font-weight:500;
}

.star-rating i{
    font-size:22px;
    cursor:pointer;
    color:#ced4da;
}

.star-rating i.active{
    color:#f4c150;
}

.btn-primary{
    border-radius:6px;
    font-weight:500;
}

textarea{
    resize:none;
}

@media(max-width:768px){
    .page-header{
        text-align:center;
    }
}
</style>
</head>

<body>

<div class="container-fluid p-4">

<!-- Header -->
<div class="page-header">
    <h4 class="mb-0">
        <i class="fa-solid fa-pen-to-square me-2"></i>
        Submit Feedback
    </h4>
</div>

<div class="row justify-content-center">
<div class="col-lg-6 col-md-8">

<div class="card">
<div class="card-body p-4">

<% if(!message.equals("")){ %>
<div class="alert alert-<%=alertType%> alert-dismissible fade show">
<%=message%>
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>

<form method="post">

<!-- Department -->
<div class="mb-3">
<label class="form-label">Select Department</label>
<select name="department" class="form-select" required>
<option value="">-- Choose Department --</option>
<option value="RTO">RTO</option>
<option value="PCB">PCB</option>
<option value="INSURANCE">INSURANCE</option>
<option value="TRAFFIC">TRAFFIC</option>
<option value="POLICE">POLICE</option>
</select>
</div>

<!-- Message -->
<div class="mb-3">
<label class="form-label">Your Feedback</label>
<textarea name="message" class="form-control" rows="4" placeholder="Enter your feedback here..." required></textarea>
</div>

<!-- Rating -->
<div class="mb-3">
<label class="form-label">Rating</label>
<div class="star-rating">
<i class="fa-solid fa-star" data-value="1"></i>
<i class="fa-solid fa-star" data-value="2"></i>
<i class="fa-solid fa-star" data-value="3"></i>
<i class="fa-solid fa-star" data-value="4"></i>
<i class="fa-solid fa-star" data-value="5"></i>
</div>
<input type="hidden" name="rating" id="ratingValue" required>
</div>

<div class="d-grid mt-3">
<button type="submit" class="btn btn-primary">
<i class="fa-solid fa-paper-plane me-2"></i>
Submit Feedback
</button>
</div>

</form>

</div>
</div>

</div>
</div>

</div>

<script>
const stars=document.querySelectorAll(".star-rating i");
const ratingInput=document.getElementById("ratingValue");

stars.forEach(star=>{
    star.addEventListener("click",function(){
        let value=this.getAttribute("data-value");
        ratingInput.value=value;

        stars.forEach(s=>s.classList.remove("active"));
        for(let i=0;i<value;i++){
            stars[i].classList.add("active");
        }
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
