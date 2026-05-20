<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - MobileAccessories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp">
        <jsp:param name="type" value="public"/>
    </jsp:include>

    <main class="main-content">
        <div class="container">
            <h1 class="mb-2">About MobileAccessories</h1>
            
            <div class="hero-buttons">
                   <!-- Browse Products -->
                   <a href="${pageContext.request.contextPath}/products"
                      class="btn">
                       Browse Products
                   </a>
                   <!-- Contact -->
                   <a href="${pageContext.request.contextPath}/contact"
                      class="btn btn-secondary">
                       Talk to Us
                   </a>
               </div>

            

            <div class="card mb-3">
                <div class="card-body">
                    <h2>Who We Are</h2>
                    <p class="mt-1">MobileAccessories is a premier online destination for mobile accessories, committed to providing high-quality products at competitive prices. We believe that every mobile device deserves the best accessories to enhance its functionality and protect its value.</p>
                    <p>
   					 Our platform offers a wide range of products including phone
    				cases, chargers, screen protectors, earphones, power banks,
   					 and other modern mobile accessories designed to meet the needs
    				of today’s technology users. We carefully select our products
   				    to ensure durability, quality, and customer satisfaction.
					</p>
					<p>
    				At MobileAccessories, we focus on delivering an easy, secure,
    				and convenient online shopping experience for customers across
    				Nepal. Our team is committed to professional customer service,
    				fast delivery, and continuous improvement to meet changing
    				market trends and customer expectations.
					</p>
					
                    
 
                    <h2 class="mt-3">Our Mission</h2>
                    <p class="mt-1">Our mission is to make quality mobile accessories accessible to everyone. We carefully curate our product selection to ensure only genuine,
                     high-quality items from trusted brands reach our customers.
                     In the future, MobileAccessories plans to expand its product
                     collection with the latest technology accessories while maintaining
                     affordable prices and excellent service standards. We also aim to
                     support innovation, digital growth, and customer convenience
                     through continuous improvement and modern e-commerce solutions.</p>

                    <h2 class="mt-3">What We Offer</h2>
                    <ul class="mt-1" style="padding-left:1.5rem">
                        <li>Wide range of mobile accessories including cases, chargers, earphones, screen protectors, and more</li>
                        <li>Products from top brands like Anker, Spigen, Samsung, Sony, and others</li>
                        <li>Competitive pricing with regular deals and discounts</li>
                        <li>Fast and reliable delivery across the country</li>
                        <li>Secure online shopping experience with encrypted transactions</li>
                        <li>24/7 customer support to assist with any queries</li>
                    </ul>

                    <h2 class="mt-3">Why Choose Us</h2>
                    <div class="stats-grid mt-2">
                        <div class="stat-card">
                            <div class="stat-icon blue">&#128230;</div>
                            <div class="stat-info">
                                <div class="stat-value">500+</div>
                                <div class="stat-label">Products Available</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon green">&#128101;</div>
                            <div class="stat-info">
                                <div class="stat-value">1000+</div>
                                <div class="stat-label">Happy Customers</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon yellow">&#9733;</div>
                            <div class="stat-info">
                                <div class="stat-value">4.8</div>
                                <div class="stat-label">Average Rating</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon red">&#128666;</div>
                            <div class="stat-info">
                                <div class="stat-value">Fast</div>
                                <div class="stat-label">Delivery Speed</div>
                            </div>
                        </div>
                    </div>

                    <h2 class="mt-3">Our Commitment to Ethics</h2>
                    <p class="mt-1">As a responsible e-commerce platform, MobileAccessories is committed to ethical business practices. 
                    We ensure fair pricing, transparent product descriptions, 
                    and honest customer reviews. We do not engage in deceptive 
                    marketing practices and prioritize customer satisfaction above all.</p>
                    <p> We do not engage in deceptive marketing practices, misleading
                     advertisements, or hidden charges. Every product displayed on
                     our platform is carefully verified to maintain quality,
                     authenticity, and customer satisfaction.
                     </p>
                     <p>
    				Our company values honesty, integrity, and accountability in
    				every business operation. We respect customer privacy, provide
    				secure online transactions, and work continuously to improve
    				user experience through reliable support and professional service.
					</p>

					<p>
    				MobileAccessories also believes in building long-term relationships
    				with customers by delivering high-quality products, fast delivery
   					services, and responsive customer care. Our mission is not only
    				to sell mobile accessories but also to create a trustworthy and
    				ethical online shopping environment for customers across Nepal.
					</p>
                    
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/includes/footer.jsp" />
</body>
</html>
