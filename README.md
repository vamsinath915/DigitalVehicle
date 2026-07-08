# DigitalVehicle
Digital Vehicle System is a Java Full Stack web application developed using JSP, Servlets, JDBC, MySQL, HTML, CSS, and JavaScript. It provides vehicle-related services such as user registration, admin login, driving license management, and online application processing with secure database connectivity using Apache Tomcat.



##  Features

###  Admin Module
- Admin Login
- Dashboard
- Manage Users
- View Driving License Applications
- View Learning License Applications
- Approve/Reject Applications

###  User Module
- User Registration
- User Login
- Apply for Learning License
- Apply for Permanent Driving License
- View Application Status
- Update Profile

##  Technologies Used

- Java
- JSP
- Servlets
- JDBC
- MySQL
- HTML5
- CSS3
- JavaScript
- Apache Tomcat 9
- Eclipse IDE
- Git & GitHub

## Project Structure

```
DigitalVehicle
│
├── src/main/java
│   ├── controller
│   ├── dao
│   ├── model
│   └── utility
│
├── src/main/webapp
│   ├── jspcode
│   ├── css
│   ├── images
│   ├── js
│   └── WEB-INF
│
└── pom.xml (if Maven project)
```

##  Database

Database Name

```
digital_vehicle_system
```

Import the SQL file into MySQL before running the project.

##  Software Requirements

- JDK 17 or above
- Eclipse IDE
- Apache Tomcat 9
- MySQL 8+
- MySQL Connector/J
- Git

##  How to Run

1. Clone the repository

```bash
git clone https://github.com/vamsinath915/DigitalVehicle.git
```

2. Import the project into Eclipse.

3. Configure Apache Tomcat.

4. Import the MySQL database.

5. Update database credentials in:

```
dbconnection.jsp
```

```java
String dbURL = "jdbc:mysql://localhost:3306/digital_vehicle_system";
String dbUser = "root";
String dbPassword = "**********";
```

6. Run the project on Tomcat.

##  Application URL

```
http://localhost:8080/DigitalVehicle/
```

or

```
http://localhost:8080/DigitalVehicle/jspcode/adminLogin.jsp
```

##  Screenshots

<img width="1916" height="847" alt="Screenshot 2026-05-13 101355" src="https://github.com/user-attachments/assets/a1529a2b-e69b-4617-a890-984d26015504" />
<img width="1887" height="924" alt="Screenshot 2026-05-13 101842" src="https://github.com/user-attachments/assets/3d3c7fa9-639b-4bd9-9540-6fc967233599" />
<img width="1879" height="924" alt="Screenshot 2026-05-13 101900" src="https://github.com/user-attachments/assets/dd866022-e1ed-4ecb-b9f7-9342a24f9d5f" />
<img width="1880" height="885" alt="Screenshot 2026-05-13 121826" src="https://github.com/user-attachments/assets/895b89a6-ba84-4dfd-a03e-d3e04227786a" />
<img width="1885" height="908" alt="Screenshot 2026-05-13 115311" src="https://github.com/user-attachments/assets/bef26db8-4352-4efb-9e00-b9a56463f9d9" />
<img width="1920" height="1080" alt="Screenshot (143)" src="https://github.com/user-attachments/assets/3fcc4e0d-2e8b-4bac-be22-f88a12eaf7af" />
<img width="1920" height="1080" alt="Screenshot (137)" src="https://github.com/user-attachments/assets/e0063ffb-f051-438c-a8ad-6ea9daed1ba3" />







```

##  Future Enhancements

- Email Notifications
- OTP Verification
- Online Payment Integration
- PDF Receipt Generation
- Vehicle Insurance Module
- Responsive UI
- Spring Boot Migration

## Author

**Vamsi Nath**

GitHub:
https://github.com/vamsinath915



⭐ If you found this project useful, don't forget to star the repository.
