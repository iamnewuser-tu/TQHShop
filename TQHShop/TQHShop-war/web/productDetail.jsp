<%-- 
    Document   : productDetail
    Created on : Dec 16, 2017, 11:48:43 AM
    Author     : Tien
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail</title>
        <!-- bootstrap -->
        <link href="resource/bootstrap/css/bootstrap.min.css" rel="stylesheet">      
        <link href="resource/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">		
        <link href="resource/themes/css/bootstrappage.css" rel="stylesheet"/>

        <!-- global styles -->
        <link href="resource/themes/css/main.css" rel="stylesheet"/>
        <link href="resource/themes/css/jquery.fancybox.css" rel="stylesheet"/>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet" />
        <link href="http://fonts.googleapis.com/css?family=Arvo" rel="stylesheet" type="text/css" />
        <!-- scripts -->
        <script src="resource/themes/js/jquery-1.7.2.min.js"></script>
        <script src="resource/bootstrap/js/bootstrap.min.js"></script>				
        <script src="resource/themes/js/superfish.js"></script>	
        <script src="resource/themes/js/jquery.scrolltotop.js"></script>
        <script src="resource/themes/js/jquery.fancybox.js"></script>
        <script src="resource/themes/js/login-register.js" type="text/javascript"></script>
        <!--add dialog-->
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
                    swal("${swalMessage}", "Thank you", "success");
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
                                <li><a href="seller/home.jsp">Hi, ${user.fullname}</a></li>  
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
                                        <input id="username" class="input-xlarge" pattern="[A-Za-z0-9@a-z.com]{2,30}" type="text" name="username" required="true"><br/>
                                        <input id="password" class="input-xlarge" pattern="[A-Za-z0-9]{2,30}" type="password"  name="password" required="true"><br/>
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
                                        <input id="Regispassword" class="input-xlarge" type="email" placeholder="Email" name="txtEmail" required title="Email must be in the correct format" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"><br/>
                                        <input id="Regispassword" class="input-xlarge" type="text" placeholder="Full name" name="txtFullname" required="true"><br/>
                                        <input id="Regispassword" class="input-xlarge"  pattern='\d{9,15}' type="tel" placeholder="Phone" name="txtPhone" required title="Phone contains 9 to 15 digits"><br/>
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
            <section class="header_text sub">
                <img class="pageBanner" src="https://cdn.pbrd.co/images/H29wWUf.png" alt="New products" >
                <h4><span>${product.productName}</span></h4>
            </section>
            <section class="main-content">				
                <div class="row">						
                    <div class="span9">
                        <div class="row">
                            <div class="span4">
                                <a href="${product.productImage[0]}" class="thumbnail" data-fancybox-group="group1" title="${product.productName}"><img alt="" src="${product.productImage[0]}" ></a>												
                                <ul class="thumbnails small">								
                                    <c:if test="${product.productImage[1] != null}">
                                        <li class="span1">
                                            <a href="${product.productImage[1]}" class="thumbnail" data-fancybox-group="group1" title="${product.productName}"><img src="${product.productImage[1]}" alt="" style="width: 50px; height: 50px"></a>
                                        </li>								
                                    </c:if>
                                    <c:if test="${product.productImage[2] != null}">
                                        <li class="span1">
                                            <a href="${product.productImage[2]}" class="thumbnail" data-fancybox-group="group1" title="${product.productName}"><img src="${product.productImage[2]}" alt="" style="width: 50px; height: 50px"></a>
                                        </li>
                                    </c:if>
                                    <c:if test="${product.productImage[3] != null}">
                                        <li class="span1">
                                            <a href="${product.productImage[3]}" class="thumbnail" data-fancybox-group="group1" title="${product.productName}"><img src="${product.productImage[3]}" alt="" style="width: 50px; height: 50px"></a>
                                        </li>
                                    </c:if>
                                    <c:if test="${product.productImage[4] != null}">
                                        <li class="span1">
                                            <a href="${product.productImage[4]}" class="thumbnail" data-fancybox-group="group1" title="${product.productName}"><img src="${product.productImage[4]}" alt="" style="width: 50px; height: 50px"></a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                            <div class="span5">
                                <address>
                                    <strong>Product Code:</strong> <span>${product.productId}</span><br>
                                    <strong>Brand:</strong> <span>${product.brandName}</span><br>
                                    <strong>Weight:</strong> <span>${product.productWeight} (kg)</span><br>
                                    <strong>Width:</strong> <span>${product.productWidth} (cm)</span><br>
                                    <strong>Height:</strong> <span>${product.productHeigth} (cm)</span><br>
                                    <strong>Length:</strong> <span>${product.productLength} (cm)</span><br>
                                    <strong>Rating Points:</strong> ${product.productRating} / 
                                        <c:forEach begin="1" end="5" varStatus="point">
                                            <a href="addProductsServlet?action=rating&point=${point.index}&pid=${product.productId}"><i class="fa fa-star" style="color: yellow; font-size: 20px"></i></a>
                                        </c:forEach> <br/>
                                    <strong>Availability:</strong> ${product.productQuantity>0?'<span style="color: green;">- Còn Hàng</span>':'<span style="color: red;">Out Of Stock -</span>'}<br>								
                                </address>									
                                <h4>Price: <strong style="color: red;">&#36;${product.productPrice - (product.productPrice * product.productDiscount / 100)}</strong> <strong><strike> ${product.productPrice}</strike></strong></h4>
                            </div>
                            <div class="span5">
                                <form class="form-inline" action="addOrderServlet" method="POST">                                    
                                    <label>Qty:</label>
                                    <input type="number" value="1" class="span1" name="quantity" min="1" max="20">
                                    <input type="hidden" name="idProduct" value="${product.productId}"/>
                                    <button class="btn btn-inverse" name="action" value="addToCart" type="submit">Add to cart</button>
                                </form>
                            </div>							
                        </div>
                        <div class="row">
                            <div class="span9">
                                <ul class="nav nav-tabs" id="myTab">
                                    <li class="active"><a href="#home">Description</a></li>
                                    <li class=""><a href="#profile">Summary</a></li>
                                </ul>							 
                                <div class="tab-content">
                                    <div class="tab-pane active" id="home">${product.productDesc}</div>
                                    <div class="tab-pane" id="profile">${product.productSummary}</div>
                                </div>							
                            </div>
                            <div class="span9">
                                <h4 class="title">
                                    <span class="pull-left"><span class="text"><strong>Comment</strong></span></span>
                                    <span class="pull-right">
                                    </span>
                                </h4>
                                <div class="accordion-panel"><!---.accordion-panel--->
                                    <div id="comments-section"><!---Start #comments-section Binh luan cua khach hang ve san pham--->
                                        <c:forEach items="${product.productsCommentCollection}" var="productComment">
                                            <h4>${productComment.userId.fullname}</h4>
                                            <p>${productComment.commentContent}</p>
                                            <hr/>
                                        </c:forEach>
                                    </div><!---End #comments-section--->
                                    <div id="write-review-rating"><!---Start #write-review-rating Phan viet binh luan va cham sao cho product--->
                                        <form method="post" action="addProductsServlet">
                                            <input type="hidden" name="productID" value="${product.productId}">
                                            <h4>Comment</h4>
                                            <h5>Comment is limited to 500 words</h5>
                                            <textarea name="commentContent" rows="9" cols="200" style="margin: 0px 0px 10px; width: 845px; height: 181px;"></textarea>
                                            <div class="clearfix"></div>
                                            <button type="submit" id="submit-review" style="height:50px;" value="comment" name="action"><i class="fa fa-check-circle"></i> Send Comment</button>
                                        </form>
                                    </div><br>  <!---End #write-review-rating--->
                                </div><!---.accordion-panel end--->       
                            </div>                  
                        </div>                    
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
                        <div class="block">								
                            <h4 class="title"><strong>Best</strong> Seller</h4>								
                            <ul class="small-product">
                                <c:forEach items="${listTopProduct}" var="top">
                                    <li style="text-align:center;">
                                        <div>
                                            <a href="viewServlet?action=productDetail&idProduct=${top.id}" title="${top.name}">
                                                <img src="${top.image}" style="width: 150px; height: 150px">
                                            </a>
                                        </div>
                                        <a href="viewServlet?action=productDetail&idProduct=${top.id}">${top.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>
            <section>
                <div class="row">
                    <div class="span12">	
                        <br>
                        <h4 class="title">
                            <span class="pull-left"><span class="text"><strong>Related</strong> Products</span></span>
                            <span class="pull-right">
                                <a class="left button" href="#myCarousel-1" data-slide="prev"></a><a class="right button" href="#myCarousel-1" data-slide="next"></a>
                            </span>
                        </h4>
                        <div id="myCarousel-1" class="carousel slide">
                            <div class="carousel-inner">
                                <div class="active item">
                                    <ul class="thumbnails listing-products">
                                        <c:forEach items="${listProductRelated1}" var="items">
                                            <li class="span3">
                                                <div class="product-box">
                                                    <span class="sale_tag"></span>												
                                                    <a href="viewServlet?action=productDetail&idProduct=${items.productId}"><img alt="${items.productName}" src="${items.productImage[0]}" style="width: 200px; height: 200px"></a><br/>
                                                    <a href="viewServlet?action=productDetail&idProduct=${items.productId}" class="title" style="height: 60px;">${items.productName}</a><br/>
                                                    <p class="price">${items.productPrice - (items.productPrice * items.productDiscount / 100)}</p>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <c:if test="${listProductRelated2 != null}">
                                    <div class="item">
                                        <ul class="thumbnails listing-products">
                                            <c:forEach items="${listProductRelated2}" var="items2">
                                                <li class="span3">
                                                    <div class="product-box">
                                                        <span class="sale_tag"></span>												
                                                        <a href="viewServlet?action=productDetail&idProduct=${items2.productId}"><img alt="${items2.productName}" src="${items2.productImage[0]}" style="width: 200px; height: 200px"></a><br/>
                                                        <a href="viewServlet?action=productDetail&idProduct=${items2.productId}" class="title" style="height: 60px;">${items2.productName}</a><br/>
                                                        <p class="price">${items2.productPrice - (items2.productPrice * items2.productDiscount / 100)}</p>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>
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
        <script>
                                            $(function() {
                                                $('#myTab a:first').tab('show');
                                                $('#myTab a').click(function(e) {
                                                    e.preventDefault();
                                                    $(this).tab('show');
                                                })
                                            })
                                            $(document).ready(function() {
                                                $('.thumbnail').fancybox({
                                                    openEffect: 'none',
                                                    closeEffect: 'none'
                                                });

                                                $('#myCarousel-2').carousel({
                                                    interval: 2500
                                                });
                                            });
        </script>
    </body>
</html>
