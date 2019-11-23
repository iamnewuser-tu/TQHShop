<%-- 
    Document   : cart
    Created on : Dec 27, 2017, 11:47:20 PM
    Author     : tatyuki1209
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Page</title>
        <link href="resource/bootstrap/css/bootstrap.min.css" rel="stylesheet">      
        <link href="resource/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">

        <link href="resource/themes/css/bootstrappage.css" rel="stylesheet"/>

        <!-- global styles -->
        <link href="resource/themes/css/flexslider.css" rel="stylesheet"/>
        <link href="resource/themes/css/main.css" rel="stylesheet"/>

        <!-- scripts -->
        <script src="resource/themes/js/jquery-1.7.2.min.js"></script>
        <script src="resource/bootstrap/js/bootstrap.min.js"></script>				
        <script src="resource/themes/js/superfish.js"></script>	
        <script src="resource/themes/js/jquery.scrolltotop.js"></script>
        <script src="resource/themes/js/login-register.js" type="text/javascript"></script>
    </head>
    <body>	
        <c:if test="${not empty message}">
            <script>
                window.addEventListener("load", function() {
                    $('#MessageModal').modal('show');
                })
            </script>
        </c:if>
        <div id="top-bar" class="container">
            <div class="row">
                <div class="span4">
                    <form method="POST" action="searchProductsServlet">
                        <input type="text" name="txtProductName" class="search-query" Placeholder="eg Sony">
                        <button value="Search" name="action" class="btn-success btn">Search</button>
                    </form>
                </div>
                <div class="span8">
                    <div class="account pull-right">
                        <ul class="user-menu">	
                            <li><a class="btn" href="viewServlet?action=viewShoppingCart">Cart</a></li>
                                <%
                                    if (session.getAttribute("user") == null) {
                                %>
                            <li><a class="btn" data-toggle="modal" href="javascript:void(0)" onclick="openLoginModal();">Log in</a></li>
                                <%
                                    }
                                %>
                                <%
                                    if (session.getAttribute("user") != null) {
                                %>
                                <c:if test="${user.role=='admin'}">
                                <li><a href="viewServlet?action=homeAdmin">Hi, ${user.fullname}</a></li>  
                                </c:if>

                            <c:if test="${user.role=='seller'}">
                                <li><a href="viewServlet?action=homeSeller">Hi, ${user.fullname}</a></li>  
                                </c:if>

                            <c:if test="${user.role=='customer'}">
                                <li><a href="viewServlet?action=homeCustomer">Hi, ${user.fullname}</a></li>  
                                </c:if>
                            <li><a class="btn" href="viewServlet?action=Logout">Log out</a></li>
                                <%
                                    }
                                %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!--Phần dialog box Message-->
        <div class="modal fade login" id="MessageModal">
            <div class="modal-dialog login animated">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #ff6666">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" style="color: #fff">ERROR</h4>
                    </div>
                    <div class="modal-body">  
                        <div class="box">
                            <div class="content">
                                <div class="error" style="font-size: 20px;">${message}</div>                  
                            </div>
                        </div>                      
                    </div>        
                </div>
                <div class="modal-footer">
                    <div class="forgot login-footer">
                        <span>Tech Line In The Best</span>
                    </div>
                </div>           
            </div>
        </div>
        <!--Kết thúc dialog box Message-->              
        <div id="wrapper" class="container">
            <section class="navbar main-menu">
                <div class="navbar-inner main-menu">				
                    <nav id="menu" class="pull-right">
                        <ul>
                            <li>
                                <a href="RedirectServlet?action=backToHome">Home</a>	          
                            </li>
                            <c:forEach items="${listCategories}" var="item">
                                <li>
                                    <a href="viewServlet?action=cateDetail&idCate=${item.categoryId}">${item.categoryName}</a>	
                                    <ul>
                                        <c:forEach items="${item.productTypesCollection}" var="type">
                                            <li><a href="viewServlet?action=typeDetail&idType=${type.typeId}">${type.typeName}</a></li>	
                                            </c:forEach>
                                    </ul>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </section>				
            <section class="header_text sub">
                <img class="pageBanner" src="https://cdn.pbrd.co/images/H29wWUf.png" alt="New products" >
                <h4><span>Shopping Cart</span></h4>
            </section>
            <section class="main-content">				
                <div class="row">
                    <div class="span9">					
                        <h4 class="title"><span class="text"><strong>Your</strong> Cart</span></h4>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th>Total</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${cart}" var="item">
                                    <tr>
                                        <td><a href="product_detail.html"><img alt="" src="${item.image}" style="width:200px; height:200px;"></a></td>
                                        <td>${item.name}</td>
                                        <td>${item.quantity}</td>
                                        <td>$${item.price}</td>
                                        <td>$${item.total}</td>
                                        <td><a href="deleteOrderServlet?action=removeFromCart&idProduct=${item.productId}"><img src="https://d30y9cdsu7xlg0.cloudfront.net/png/36770-200.png" width="40px"/></a></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>			
                        <hr>
                        <p class="cart-total right">
                            <strong>Sub-Total</strong>:	$${subtotal}<br>
                            <strong>Member Discount</strong>: $${memberDiscount}<br>
                            <strong>SHIPMENT FEE</strong>: Counting .... <br/>
                            <strong>Total</strong>: Counting .... <br>
                        </p>
                        <hr/>
                        <form method="POST" action="RedirectServlet">
                            <p class="buttons center">		
                                <input type="hidden" value="${subtotal}" name="subtotal"/>
                                <input type="hidden" value="${memberDiscount}" name="memberDiscount"/>
                                <button class="btn" type="submit" value="backToHome" name="action">Back Home</button>
                                <button class="btn btn-inverse" value="goToMap" name="action">Continue</button>
                            </p>	
                        </form>

                    </div>
                    <div class="span3 col">

                        <div class="block">
                            <h4 class="title">
                                <span class="pull-left"><span class="text">Randomize</span></span>
                                <span class="pull-right">
                                    <a class="left button" href="#myCarousel" data-slide="prev"></a><a class="right button" href="#myCarousel" data-slide="next"></a>
                                </span>
                            </h4>
                            <div id="myCarousel" class="carousel slide">
                                <div class="carousel-inner">
                                    <c:if test="${randomizes != null}">
                                        <c:forEach items="${randomizes}" var="rd" varStatus="rdCount">
                                            <div class="${rdCount.index == 0 ? "active item" : "item"}">
                                                <ul class="thumbnails listing-products">
                                                    <li class="span3">
                                                        <div class="product-box">
                                                            <span class="sale_tag"></span>												
                                                            <img alt="${rd.productName}" src="${rd.productImage[0]}" style="width: 150px; height: 150px;"><br/>
                                                            <a href="viewServlet?action=productDetail&idProduct=${rd.productId}" class="title" style="height: 60px;">${rd.productName}</a><br/>
                                                            <p class="price">${rd.productPrice - (rd.productPrice * rd.productDiscount / 100)}</p>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </div>						
                    </div>
                </div>
            </section>			
            <section id="footer-bar">
                <div class="row">
                    <div class="span3">
                        <h4>Navigation</h4>
                        <ul class="nav">
                            <li><a href="HomeServlet">Homepage</a></li>  
                            <li><a href="viewServlet?action=viewShoppingCart">Your Cart</a></li>
                            <li><a href="HomeServlet">Login</a></li>							
                        </ul>					
                    </div>
                    <div class="span4">
                    </div>
                    <div class="span5">
                        <p class="logo"><img src="themes/images/logo.png" class="site_logo" alt=""></p>
                        <p>At this century, you can not deny the evolution of technology. It’s nearly become the air that we are breathing.</p>
                        <br/>
                        <span class="social_icons">
                            <a class="facebook" href="#">Facebook</a>
                            <a class="twitter" href="#">Twitter</a>
                            <a class="skype" href="#">Skype</a>
                            <a class="vimeo" href="#">Vimeo</a>
                        </span>
                    </div>					
                </div>	
            </section>
            <section id="copyright">
                <span>Copyright 2013  All right reserved.</span>
            </section>
        </div>
        <script src="themes/js/common.js"></script>
        <script>
                                $(document).ready(function() {
                                    $('#checkout').click(function(e) {
                                        document.location.href = "checkout.html";
                                    })
                                });
        </script>		
    </body>
</html>
