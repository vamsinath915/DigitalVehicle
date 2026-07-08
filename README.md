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

### 👤 User Module
- User Registration
- User Login
- Apply for Learning License
- Apply for Permanent Driving License
- View Application Status
- Update Profile

## 🛠️ Technologies Used

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

## 📂 Project Structure

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

## 💾 Database

Database Name

```
digital_vehicle_system
```

Import the SQL file into MySQL before running the project.

## ⚙️ Software Requirements

- JDK 17 or above
- Eclipse IDE
- Apache Tomcat 9
- MySQL 8+
- MySQL Connector/J
- Git

## 🚀 How to Run

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
String dbPassword = "YOUR_PASSWORD";
```

6. Run the project on Tomcat.

## 🌐 Application URL

```
http://localhost:8080/DigitalVehicle/
```

or

```
http://localhost:8080/DigitalVehicle/jspcode/adminLogin.jsp
```

## 📸 Screenshots

You can add screenshots here.

```
screenshots/
```

## 📖 Future Enhancements

- Email Notifications
- OTP Verification
- Online Payment Integration
- PDF Receipt Generation
- Vehicle Insurance Module
- Responsive UI
- Spring Boot Migration

## 👨‍💻 Author

**Vamsi Nath**

GitHub:
https://github.com/vamsinath915

LinkedIn:
(Add your LinkedIn profile link)

---

⭐ If you found this project useful, don't forget to star the repository.
