<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnection.jsp" %>

<%
    String message = "";
    String ownerId = null;

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String username = (String) session.getAttribute("username");

    if(username == null){
        response.sendRedirect("v_login.jsp");
        return;
    }

    try {
        PreparedStatement ps1 = con.prepareStatement("SELECT uid FROM users WHERE uid=?");
        ps1.setString(1, username);
        ResultSet rs1 = ps1.executeQuery();

        if(rs1.next()){
            ownerId = rs1.getString("uid");
        }
    } catch(Exception e){
        message = "Error fetching user!";
    }

    // Handle Form Submit
    if(request.getMethod().equalsIgnoreCase("POST")){

        String vehicleId = request.getParameter("vehicle_id");
       // String issueDate = request.getParameter("issue_date");
        //String expiryDate = request.getParameter("expiry_date");

        try {

            String sql = "INSERT INTO pollution_certificates(vehicle_number) VALUES(?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, vehicleId);
            //ps.setDate(2, Date.valueOf(issueDate));
            //ps.setDate(3, Date.valueOf(expiryDate));

            int i = ps.executeUpdate();

            if(i > 0){
                message = "Pollution Certificate Applied Successfully!";
            } else {
                message = "Application Failed!";
            }

        } catch(Exception e){
            message = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply Pollution Certificate</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color:#f1f4f8;
            font-family:'Segoe UI',sans-serif;
        }

        .pc-card {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 5px rgba(13,110,253,0.4);
        }

        .submit-btn {
            background-color: #0d6efd;
            border: none;
        }

        .submit-btn:hover {
            background-color: #084298;
        }
    </style>

<!--    <script>
        function validateDates(){
            var issue = document.getElementById("issueDate").value;
            var expiry = document.getElementById("expiryDate").value;

            if(expiry <= issue){
                alert("Expiry date must be greater than Issue date");
                return false;
            }
            return true;
        }
    </script>-->
</head>

<body>

<div class="container d-flex justify-content-center align-items-center" style="min-height:100vh;">
    <div class="col-md-7">

        <div class="card pc-card p-4">

            <h4 class="text-center mb-3">Apply Pollution Certificate</h4>

            <% if(!message.equals("")) { %>
                <div class="alert alert-info text-center">
                    <%= message %>
                </div>
            <% } %>

            <form method="post" onsubmit="return validateDates()">

                <!-- Select Vehicle -->
                <div class="mb-3">
                    <label class="form-label">Select Vehicle</label>
                    <select name="vehicle_id" class="form-select" required>
                        <option value="">Select Vehicle</option>
                        <%
                            try {
                                PreparedStatement ps2 = con.prepareStatement(
                                    "SELECT vehicle_id, vehicle_number FROM vehicles WHERE owner_id=?"
                                );
                                ps2.setString(1, ownerId);
                                ResultSet rs2 = ps2.executeQuery();

                                while(rs2.next()){
                        %>
                            <option value="<%= rs2.getString("vehicle_number") %>">
                                <%= rs2.getString("vehicle_number") %>
                            </option>
                        <%
                                }
                            } catch(Exception e){}
                        %>
                    </select>
                </div>

                <!-- Issue Date -->
<!--                <div class="mb-3">
                    <label class="form-label">Issue Date</label>
                    <input type="date" id="issueDate" name="issue_date" class="form-control" required>
                </div>-->

                <!-- Expiry Date -->
<!--                <div class="mb-3">
                    <label class="form-label">Expiry Date</label>
                    <input type="date" id="expiryDate" name="expiry_date" class="form-control" required>
                </div>-->

                <div class="d-grid">
                    <button type="submit" class="btn submit-btn text-white">
                        Apply Certificate
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>

</body>
</html>
