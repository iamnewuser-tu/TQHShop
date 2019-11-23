<%-- 
    Document   : index
    Created on : Dec 16, 2017, 10:46:32 AM
    Author     : Tien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
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
        <script src="resource/themes/js/date-of-birth.js" type="text/javascript"></script>
        <link rel='stylesheet' href='https://cdn.rawgit.com/t4t5/sweetalert/v0.2.0/lib/sweet-alert.css'>
        <script src='https://cdn.rawgit.com/t4t5/sweetalert/v0.2.0/lib/sweet-alert.min.js'></script>
    </head>
    <body>
        <c:if test="${not empty message}">
            <script>
                window.addEventListener("load", function() {
                    $('#MessageModal').modal('show');
                })
            </script>
        </c:if>
        <c:if test="${not empty swalMessage}">
            <script>
                window.addEventListener("load", function() {
                    swal("${swalMessage}", "", "success");
                });
                setTimeout(function(){window.history.go(-1);}, 2000);
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



        <!--Phần dialog box Login-->
        <div class="modal fade login" id="loginModal">
            <div class="modal-dialog login animated">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Login with</h4>
                    </div>
                    <div class="modal-body">  
                        <div class="box">
                            <div class="content">
                                <div class="error"></div>
                                <div class="form loginBox">
                                    <form method="post" action="viewServlet">
                                        <input id="username" class="input-xlarge" type="text" name="username" pattern="[A-Za-z0-9]{4,30}" required title="Username contains 4 to 30 characters, no special characters"><br/>
                                        <input id="password" class="input-xlarge" type="password"  name="password" pattern=".{5,20}" required title="Password contains 5 to 20 characters"><br/>
                                        <input class="btn btn-inverse" style="width:285px;" type="submit" name="action" value="Login">
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="box">
                            <div class="content registerBox" style="display:none;">
                                <div class="form">
                                    <form method="post" action="addCustomerServlet">
                                        <b style="color: red;" id="note1"></b>
                                        <input id="email" class="input-xlarge" type="text" placeholder="Username" name="txtUsername" pattern="[A-Za-z0-9]{4,30}" required title="Username contains 4 to 30 characters, no special characters"><br/>
                                        <b style="color: red;" id="note2"></b>
                                        <input id="Regispassword" class="input-xlarge" type="password" placeholder="Password" name="txtPassword" pattern=".{5,20}" required title="Password contains 5 to 20 characters"><br/>
                                        <input id="Regispassword_confirmation" class="input-xlarge" type="password" placeholder="Repeat Password" name="password_confirmation" pattern=".{5,20}" required title="Repeat password contains 5 to 20 characters" onBlur="checkPass()"><br/>
                                        <input id="Regispassword2" class="input-xlarge" type="email" placeholder="Email" name="txtEmail" required title="Email must be in the correct format" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"><br/>
                                        <input id="Regispassword3" class="input-xlarge" type="text" placeholder="Full name" name="txtFullname" pattern=".{5,30}" required="true"><br/>
                                        <input id="Regispassword4" class="input-xlarge"  pattern='\d{9,15}' type="tel" placeholder="Phone" name="txtPhone" required title="Phone contains 9 to 15 digits"><br/>
                                        <input type="radio" name="role" value="customer" checked> Customer 
                                        <input type="radio" name="role" value="seller" > Seller <br/>
                                        <button class="btn btn-inverse" style="width:285px;" type="submit" name="action" value="register">Create An Account</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="forgot login-footer">
                            <span>Looking to 
                                <a href="javascript: showRegisterForm();">Register</a>
                                ?</span>
                        </div>
                        <div class="forgot register-footer" style="display:none">
                            <span>Already have an account?</span>
                            <a href="javascript: showLoginForm();">Login</a>
                        </div>
                    </div>        
                </div>
            </div>
        </div>
        <!--Kết thúc dialog box Login-->
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
                                            <c:if test="${type.typeStatus}">
                                                <li><a href="viewServlet?action=typeDetail&idType=${type.typeId}">${type.typeName}</a></li>	
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </section>
            <section  class="homepage-slider" id="home-slider">
                <div class="flexslider">
                    <ul class="slides">
                        <li>
                            <img src="https://cdn.pbrd.co/images/H29wE87.png" alt="" />
                        </li>
                        <li>
                            <img src="https://cdn.pbrd.co/images/H29wWUf.png" alt="" />
                        </li>
                    </ul>
                </div>			
            </section>
            <section class="header_text">
                At this century, you can not deny the evolution of technology. It’s nearly become the air that we are breathing. 
                <br/>Remember ! Technology is on the run, and we draw line for you to catch it up.
            </section>
            <section class="main-content">
                <div class="row">
                    <div class="span12">													
                        <div class="row">
                            <div class="span12">
                                <h4 class="title">
                                    <span class="pull-left"><span class="text"><span class="line">News <strong>Products</strong></span></span></span>
                                    <span class="pull-right">
                                        <a class="left button" href="#myCarousel" data-slide="prev"></a><a class="right button" href="#myCarousel" data-slide="next"></a>
                                    </span>
                                </h4>
                                <div id="myCarousel" class="myCarousel carousel slide">
                                    <div class="carousel-inner">
                                        <div class="active item">
                                            <ul class="thumbnails">	
                                                <c:forEach items="${ListProductByDatePost1}" var="item">
                                                    <li class="span3" style="line-height: none">
                                                        <div class="product-box" >
                                                            <span class="sale_tag"></span>
                                                            <p><a href="viewServlet?action=productDetail&idProduct=${item.productId}"><img src="${item.productImage[0]}" alt="${item.productName}" style="width: 200px; height: 200px" /></a></p>
                                                            <a href="viewServlet?action=productDetail&idProduct=${item.productId}" class="title" style="height: 60px;">${item.productName}</a><br/>
                                                                <p class="price">&#36;${item.productPrice - (item.productPrice * item.productDiscount / 100)}</p>
                                                                <div>
                                                                    <a class="btn btn-inverse" href="viewServlet?action=productDetail&idProduct=${item.productId}">Detail</a>
                                                                    <a class="btn btn-inverse" href="addOrderServlet?action=addToCart&idProduct=${item.productId}">Add to cart</a>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                            <div class="item">
                                                <ul class="thumbnails">
                                                    <c:forEach items="${ListProductByDatePost2}" var="item2">
                                                        <li class="span3" style="line-height: none">
                                                            <div class="product-box">
                                                                <p><a href="viewServlet?action=productDetail&idProduct=${item2.productId}"><img src="${item2.productImage[0]}" alt="${item2.productName}" style="width: 200px; height: 200px" /></a></p>
                                                                    <a href="viewServlet?action=productDetail&idProduct=${item2.productId}" class="title" style="height: 60px;">${item2.productName}</a><br/>
                                                                <p class="price">&#36;${item2.productPrice - (item2.productPrice * item2.productDiscount / 100)}</p>
                                                                <div>
                                                                    <a class="btn btn-inverse" href="viewServlet?action=productDetail&idProduct=${item2.productId}">Detail</a>
                                                                    <a class="btn btn-inverse" href="addOrderServlet?action=addToCart&idProduct=${item2.productId}">Add to cart</a>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </c:forEach>

                                                </ul>
                                            </div>
                                        </div>							
                                    </div>
                                </div>						
                            </div>
                            <br/>
                            <div class="row">
                                <div class="span12">
                                    <h4 class="title">
                                        <span class="pull-left"><span class="text"><span class="line">Discount <strong>Products</strong></span></span></span>
                                        <span class="pull-right">
                                            <a class="left button" href="#myCarousel-2" data-slide="prev"></a><a class="right button" href="#myCarousel-2" data-slide="next"></a>
                                        </span>
                                    </h4>
                                    <div id="myCarousel-2" class="myCarousel carousel slide">
                                        <div class="carousel-inner">
                                            <div class="active item">
                                                <ul class="thumbnails">
                                                    <c:forEach items="${ListProductByDiscount1}" var="itemDiscount">
                                                        <li class="span3" style="line-height: none">
                                                            <div class="product-box" style="line-height: none">
                                                                <span class="sale_tag"></span>
                                                                <p><a href="viewServlet?action=productDetail&idProduct=${itemDiscount.productId}"><img src="${itemDiscount.productImage[0]}" alt="${itemDiscount.productName}" style="width: 200px; height: 200px" /></a></p>
                                                                <a href="viewServlet?action=productDetail&idProduct=${itemDiscount.productId}" class="title" style="height: 60px;">${itemDiscount.productName}</a><br/>
                                                                    <p class="price">&#36;${itemDiscount.productPrice - (itemDiscount.productPrice * itemDiscount.productDiscount / 100)}</p>
                                                                    <div>
                                                                        <a class="btn btn-inverse" href="viewServlet?action=productDetail&idProduct=${itemDiscount.productId}">Detail</a>
                                                                        <a class="btn btn-inverse" href="addOrderServlet?action=addToCart&idProduct=${itemDiscount.productId}">Add to cart</a>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </c:forEach>    
                                                    </ul>
                                                </div>
                                                <div class="item">
                                                    <ul class="thumbnails">
                                                        <c:forEach items="${ListProductByDiscount2}" var="itemDiscount2">
                                                            <li class="span3" style="line-height: none">
                                                                <div class="product-box" >
                                                                    <p><a href="viewServlet?action=productDetail&idProduct=${itemDiscount2.productId}"><img src="${itemDiscount2.productImage[0]}" alt="${itemDiscount2.productName}" style="width: 200px; height: 200px"/></a></p>
                                                                        <a href="viewServlet?action=productDetail&idProduct=${itemDiscount2.productId}" class="title" style="height: 60px;">${itemDiscount2.productName}</a><br/>
                                                                    <p class="price">&#36;${itemDiscount2.productPrice - (itemDiscount2.productPrice * itemDiscount2.productDiscount / 100)}</p>
                                                                    <div>
                                                                        <a class="btn btn-inverse" href="viewServlet?action=productDetail&idProduct=${itemDiscount2.productId}">Detail</a>
                                                                        <a class="btn btn-inverse" href="addOrderServlet?action=addToCart&idProduct=${itemDiscount2.productId}">Add to cart</a>
                                                                    </div>
                                                                </div>
                                                            </li>     
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>							
                                        </div>
                                    </div>						
                                </div>
                                <div class="row">
                                    <div class="span12">
                                        <h4 class="title">
                                            <span class="pull-left"><span class="text"><span class="line">Seller <strong>Products</strong></span></span></span>
                                            <span class="pull-right">
                                                <a class="left button" href="#myCarousel-3" data-slide="prev"></a><a class="right button" href="#myCarousel-3" data-slide="next"></a>
                                            </span>
                                        </h4>
                                        <div id="myCarousel-3" class="myCarousel carousel slide">
                                            <div class="carousel-inner">
                                                <div class="active item">
                                                    <ul class="thumbnails">
                                                        <c:forEach items="${ListProductBySeller1}" var="itemSeller">
                                                            <li class="span3" style="line-height: none">
                                                                <div class="product-box" >
                                                                    <span class="sale_tag"></span>
                                                                    <p><a href="viewServlet?action=productDetail&idProduct=${itemSeller.productId}"><img src="${itemSeller.productImage[0]}" alt="" style="width: 200px; height: 200px"/></a></p>
                                                                    <a href="viewServlet?action=productDetail&idProduct=${itemSeller.productId}" class="title" style="height: 60px;">${itemSeller.productName}</a><br/>
                                                                        <p class="price">&#36;${itemSeller.productPrice - (itemSeller.productPrice * itemSeller.productDiscount / 100)}</p>
                                                                        <div>
                                                                            <a class="btn btn-inverse" href="viewServlet?action=productDetail&idProduct=${itemSeller.productId}">Detail</a>
                                                                            <a class="btn btn-inverse" href="addOrderServlet?action=addToCart&idProduct=${itemSeller.productId}">Add to cart</a>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </c:forEach>    
                                                        </ul>
                                                    </div>
                                                    <div class="item">
                                                        <ul class="thumbnails">
                                                            <c:forEach items="${ListProductBySeller2}" var="itemSeller2">
                                                                <li class="span3">
                                                                    <div class="product-box" style="line-height: none">
                                                                        <p><a href="viewServlet?action=productDetail&idProduct=${itemSeller2.productId}"><img src="${itemSeller2.productImage[0]}" alt="" style="width: 200px; height: 200px"/></a></p>
                                                                            <a href="viewServlet?action=productDetail&idProduct=${itemSeller2.productId}" class="title" style="height: 60px;">${itemSeller2.productName}</a><br/>
                                                                        <p class="price">&#36;${itemSeller2.productPrice - (itemSeller2.productPrice * itemSeller2.productDiscount / 100)}</p>
                                                                        <div>
                                                                            <a class="btn btn-inverse" href="viewServlet?action=productDetail&idProduct=${itemSeller2.productId}">Detail</a>
                                                                            <a class="btn btn-inverse" href="addOrderServlet?action=addToCart&idProduct=${itemSeller2.productId}">Add to cart</a>
                                                                        </div>
                                                                    </div>
                                                                </li>     
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>							
                                            </div>
                                        </div>						
                                    </div>
                                    <div class="row feature_box">						
                                        <div class="span4">
                                            <div class="service">
                                                <div class="responsive">	
                                                    <img src="resource/themes/images/feature_img_2.png" alt="" />
                                                    <h4>EXCLUSIVE <strong>INVENTIONS</strong></h4>
                                                    <p>Technology is not just smart phones or laptops or tablets. It also includes your tv, cars, motorbikes, vacum cleaner, and many simple things in your house that you use everyday. </p>									
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span4">	
                                            <div class="service">
                                                <div class="customize">			
                                                    <img src="resource/themes/images/feature_img_1.png" alt="" />
                                                    <h4>RIGHT <strong>DELIVERY</strong></h4>
                                                    <p>I think you will be happy to hear that there are many inventors around the world dedicated themselves to create new things serving for our lives.</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span4">
                                            <div class="service">
                                                <div class="support">	
                                                    <img src="resource/themes/images/feature_img_3.png" alt="" />
                                                    <h4>ENORMOUS <strong>MOTIVATION</strong></h4>
                                                    <p>Technology is on the run, and we draw line for you to catch it up.</p>
                                                </div>
                                            </div>
                                        </div>	
                                    </div>		
                                </div>				
                            </div>
                        </section>
                        <section class="our_client">
                            <h4 class="title"><span class="text">Manufactures</span></h4>
                            <div class="row">
                                <c:forEach items="${listBrands}" var="brand">
                                    <div class="span2">
                                        <img alt="${brand.brandName}" src="${brand.brandIcon}" style="width: 120px; height: 45px;">
                                    </div>
                                </c:forEach>
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
                                    <p class="logo"><img src="resource/themes/images/logo.png" class="site_logo" alt=""></p>
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
                    <script src="resource/themes/js/common.js"></script>
                    <script src="resource/themes/js/jquery.flexslider-min.js"></script>
                    <script type="text/javascript">
                                                        $(function() {
                                                            $(document).ready(function() {
                                                                $('.flexslider').flexslider({
                                                                    animation: "fade",
                                                                    slideshowSpeed: 4000,
                                                                    animationSpeed: 600,
                                                                    controlNav: false,
                                                                    directionNav: true,
                                                                    controlsContainer: ".flex-container" // the container that holds the flexslider
                                                                });
                                                            });
                                                        });
                    </script>
                </body>
            </html>
