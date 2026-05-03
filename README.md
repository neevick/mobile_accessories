<<<<<<< HEAD
# mobile_accessories
=======
# GadgetZone - Mobile Accessories Online Shop

A Java EE web application for an online mobile accessories shop built with MVC architecture.

## Tech Stack
- **Java 11** - Core language
- **Java EE (Servlet/JSP)** - Web framework
- **MySQL** - Database
- **JSP + CSS** - Frontend (no Bootstrap, uses Flexbox & media queries)
- **BCrypt** - Password encryption
- **Maven** - Build tool

## Project Structure (MVC Architecture)

```
GadgetZone/
├── sql/                          # Database scripts
│   └── database.sql              # Schema + sample data
├── src/main/java/
│   └── com/mobileshop/
│       ├── model/                # Model layer (entity classes)
│       │   ├── User.java
│       │   ├── Product.java
│       │   ├── Category.java
│       │   ├── Order.java
│       │   ├── OrderItem.java
│       │   ├── WishlistItem.java
│       │   ├── Contact.java
│       │   └── Review.java
│       ├── dao/                   # Data Access Objects
│       │   ├── UserDAO.java
│       │   ├── ProductDAO.java
│       │   ├── CategoryDAO.java
│       │   ├── OrderDAO.java
│       │   ├── WishlistDAO.java
│       │   ├── ContactDAO.java
│       │   └── ReviewDAO.java
│       ├── service/              # Business logic layer
│       │   ├── UserService.java
│       │   ├── ProductService.java
│       │   ├── OrderService.java
│       │   ├── WishlistService.java
│       │   ├── ContactService.java
│       │   └── ReviewService.java
│       ├── controller/           # Controller layer (Servlets)
│       │   ├── AuthServlet.java
│       │   ├── AdminDashboardServlet.java
│       │   ├── AdminProductServlet.java
│       │   ├── AdminCategoryServlet.java
│       │   ├── AdminOrderServlet.java
│       │   ├── AdminUserServlet.java
│       │   ├── ProductServlet.java
│       │   ├── OrderServlet.java
│       │   ├── WishlistServlet.java
│       │   ├── ProfileServlet.java
│       │   └── ContactServlet.java
│       ├── filter/               # Authentication filter
│       │   └── AuthFilter.java
│       └── util/                 # Utility classes
│           ├── DBUtil.java
│           ├── ValidationUtil.java
│           ├── EncryptionUtil.java
│           └── DateUtil.java
├── src/main/webapp/
│   ├── css/style.css             # Responsive CSS (Flexbox + media queries)
│   ├── index.jsp                 # Homepage
│   ├── about.jsp                 # About page
│   ├── contact.jsp               # Contact page
│   ├── auth/                     # Authentication views
│   │   ├── login.jsp
│   │   └── register.jsp
│   ├── admin/                    # Admin dashboard views
│   │   ├── dashboard.jsp
│   │   ├── products.jsp
│   │   ├── product-form.jsp
│   │   ├── categories.jsp
│   │   ├── category-form.jsp
│   │   ├── orders.jsp
│   │   ├── order-detail.jsp
│   │   └── users.jsp
│   ├── user/                     # User portal views
│   │   ├── products.jsp
│   │   ├── product-detail.jsp
│   │   ├── cart.jsp
│   │   ├── checkout.jsp
│   │   ├── order-history.jsp
│   │   ├── order-detail.jsp
│   │   ├── wishlist.jsp
│   │   ├── profile.jsp
│   │   ├── edit-profile.jsp
│   │   └── change-password.jsp
│   ├── error/                    # Error pages
│   │   ├── 404.jsp
│   │   ├── 500.jsp
│   │   └── error.jsp
│   └── WEB-INF/web.xml           # Deployment descriptor
└── pom.xml                       # Maven configuration
```

## Setup Instructions

### Prerequisites
1. **JDK 11+** installed
2. **Apache Tomcat 9+** installed
3. **MySQL 8+** installed and running
4. **Maven** installed

### Database Setup
1. Open MySQL and run the script:
   ```sql
   source /path/to/GadgetZone/sql/database.sql
   ```
2. Update database credentials in `DBUtil.java` if needed (default: root with no password)

### Build & Deploy
1. Build the project:
   ```bash
   mvn clean package
   ```
2. Deploy the WAR file (`target/GadgetZone.war`) to Tomcat's `webapps/` folder
3. Access the application at: `http://localhost:8080/GadgetZone/`

### Default Admin Account
- **Username:** admin
- **Password:** admin123

## Features

### Admin Dashboard
- Product CRUD (Create, Read, Update, Delete)
- Category CRUD
- Order management with status updates
- User management with registration approval
- Dashboard statistics

### User Portal
- User registration with validation
- Secure login with BCrypt encryption
- Product browsing with search and category filter
- Shopping cart with session management
- Checkout and order placement
- Wishlist functionality
- Product reviews and ratings
- Profile management and password change

### Security & Architecture
- MVC architecture (Model-View-Controller)
- Role-based access control (Admin/User)
- Session management with cookies
- Authentication filter for protected URLs
- BCrypt password encryption
- Input validation and XSS prevention
- Custom error pages (404, 500)
- Responsive design (CSS Flexbox + media queries)
>>>>>>> 4a1e7f6 (Initial commit)
