<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnection.jsp" %>
<%
String username = session.getAttribute("username").toString();
if(session.getAttribute("username")==null){
%>
<script>
    window.top.location.href="r_login.jsp";
</script>
<%
    return;
}

//Connection con=null;
PreparedStatement ps=null, ps1=null;
ResultSet rs=null;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Feedback</title>
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

.table thead{
    background-color:#e9ecef;
}

.badge{
    font-size:13px;
    padding:6px 10px;
}

.rating i{
    color:#f4c150;
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
        <i class="fa-solid fa-comments me-2"></i>
        Feedback Management
    </h4>
</div>

<div class="card">
<div class="card-body p-4">

<div class="table-responsive">
<table class="table table-hover align-middle">
<thead>
<tr>
<th>ID</th>
<th>User</th>
<th>Department</th>
<th>Message</th>
<th>Rating</th>
<th>Date</th>
</tr>
</thead>
<tbody>

<%
try{
//    Class.forName("com.mysql.jdbc.Driver");
//    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/studentinnvotive","root","root");
    String dept = null;
    String sql = "select role from users where uid ='"+username+"'";
    ps1 = con.prepareStatement(sql);
    rs = ps1.executeQuery();
    if(rs.next())
    {
        dept = rs.getString(1);
    }

    String query="SELECT * FROM feedback WHERE department='"+dept+"' ORDER BY feedback_date DESC";
    ps=con.prepareStatement(query);
    rs=ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%=rs.getInt("feedback_id")%></td>
<td><%=rs.getString("user_id")%></td>

<td>
<%
String dept1=rs.getString("department");
String badgeColor="secondary";

if(dept1.equals("RTO")) badgeColor="primary";
else if(dept.equals("PCB")) badgeColor="success";
else if(dept.equals("INSURANCE")) badgeColor="warning";
else if(dept.equals("TRAFFIC")) badgeColor="info";
else if(dept.equals("POLICE")) badgeColor="danger";
%>
<span class="badge bg-<%=badgeColor%>"><%=dept%></span>
</td>

<td style="max-width:250px;">
<%=rs.getString("message")%>
</td>

<td class="rating">
<%
int rating=rs.getInt("rating");
for(int i=1;i<=5;i++){
    if(i<=rating){
%>
<i class="fa-solid fa-star"></i>
<%
    }else{
%>
<i class="fa-regular fa-star text-muted"></i>
<%
    }
}
%>
</td>

<td><%=rs.getTimestamp("feedback_date")%></td>
</tr>

<%
    }
}catch(Exception e){
    out.println("<tr><td colspan='6' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
}
%>

</tbody>
</table>
</div>

</div>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
