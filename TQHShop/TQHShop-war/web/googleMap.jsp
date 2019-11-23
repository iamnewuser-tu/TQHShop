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
        <link href="resource/themes/css/my-style.css" rel="stylesheet"/>  
        <link href="resource/themes/css/sweetalert.css" rel="stylesheet"/>
        <!-- scripts -->
        <script src="resource/themes/js/jquery-1.7.2.min.js"></script>
        <script src="resource/bootstrap/js/bootstrap.min.js"></script>				
        <script src="resource/themes/js/superfish.js"></script>	
        <script src="resource/themes/js/jquery.scrolltotop.js"></script>
        <script src="resource/themes/js/login-register.js" type="text/javascript"></script>
        <script src="resource/themes/js/google-map.js" type="text/javascript"></script>
        <script src="resource/themes/js/sweetalert.min.js" type="text/javascript"></script>
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
                    <form method="POST" action="addOrderServlet">
                    <div class="span12">	
                       
                        <h4 class="title"><span class="text"><strong>Transaction </strong> Service</span></h4>
                        <div class="delivery-panel"><!----- delivery-panel ----->
                            <div class="deliver-address"><!------deliver-address----->
                                <h3 style="font-weight:lighter; margin-top:0; background-color: #34495e; color: #FFF;">Provided Your Address</h3>

                                <b>Address :</b>
                                <input type="text" name="end" id="end" style="width:350px" required="true" maxlength="100"/>                              
                                <div>
                                    <h4 style="margin:10px 0 10px 20px; font-weight:lighter;display:inline;">Distance : </h4>
                                    <h4 style="margin:10px 0 10px 24px; font-weight:lighter;display:inline;" id="distanceID"></h4> <b>Km</b> 
                                </div><br/>
                                <div>
                                    <h4 style="margin:10px 0 10px 20px; font-weight:lighter;display:inline;">Time Delivery : </h4>
                                    <h4 style="margin:10px 0 10px 24px; font-weight:lighter;display:inline;" id="hourID"></h4> 
                                </div><br/>
                                <div>
                                    <h4 style="margin:10px 0 10px 20px; font-weight:lighter;display:inline;">Total Price : </h4>
                                    <h4 style="margin:10px 0 10px 24px; font-weight:lighter;display:inline;" id="deliveryFee2"></h4> &dollar; 
                                </div><br/>
                            </div><!------deliver-address end----->

                            <div class="deliver-map"><!-----deliver-map----->
                                <h3 style="font-weight:lighter; margin-top:0; background-color: #34495e; color: #FFF;">Map Transaction</h3>
                                <div id="journey-map">
                                    <div style="width: 100%;height: 100%; back" id="map"></div><!-----journey-map-----> 
                                </div><!-----journey-map end-----> 
                            </div><!-----deliver-map end----->
                        </div><!----- delivery-panel end-----><br/>

                        
                            <div class="note-request"><!----- note-request ----->
                                <h3 style="background-color: #34495e; color: #FFF; margin:0;">Information Delivery </h3>
                                <h4 style="margin:10px 0 10px 20px; font-weight:lighter;">Provided the delivery note</h4>
                                <div class="clearfix"></div>
                                <div>
                                    <textarea id="delivery-notice" name="deliveryRequest"></textarea>
                                </div>
                                <div class="clearfix"></div>
                                <div>
                                    <h4 style="margin:10px 0 10px 20px; font-weight:lighter;">Provided phone number</h4>
                                    <input type="text" style="width: 550px; float:left; margin-left:20px;" name="txtPhone" required title="Phone contains 9 to 15 digits" pattern="\d{9,15}"/>
                                </div>
                                <table class="orderinfo-total" style="margin-top: 30px;">
                                    <tr>
                                        <td><p>PRODUCT SUB TOTAL($)</p></td>
                                        <td width="17%">
                                            <input type="hidden" id="txtProductTotalPrice" value="${subtotal}"/>
                                            <b id="totalPrice">${subtotal}</b> &dollar;</td>                              
                                    </tr> 
                                    <tr>
                                        <td><p>MEMBER DISCOUNT($)</p></td>
                                        <td>
                                            <input type="hidden" id="txtMemberDiscounts" value="${memberDiscount}"/>
                                            <b id="memberDiscount" >${memberDiscount}</b> &dollar;</td>
                                    </tr>

                                    <tr>
                                        <td><p>SHIPMENT FEE($)</p></td>
                                        <td><b id="deliveryFee"></b> $</td>
                                    </tr>
                                    <tr>
                                        <td> 
                                            <input type="hidden" name="txtTotalPrice" id="txtTotalPrice"/>
                                            <input type="hidden" name="txtMemberDiscount" value="${memberDiscount}" id="memberDiscount"/>
                                            <input type="hidden" name="txtDeliveryPrice" id="deliveryFee"/>
                                            <input type="hidden" name="txtAddress" id="end"/>
                                            <p style="font-weight:bold; color:#900;">TOTAL($)</p></td>
                                        <td><b style="color:#900;" name="totalPriceOrder" id="totalPriceOrder"></b> &dollar;</td>
                                    </tr>              
                                </table>
                                <div class="clearfix"></div>
                            </div><!----- note-request end----->
                            <hr/>
                            <p class="buttons center">				
                                <button class="btn btn-inverse" type="submit" name="action" value="checkout" id="btnCheckOut">Check Out</button>
                            </p>    					
                    </div>
                  </form>
                </div>
            </section>  
            <section id="footer-bar">
                <div class="row">
                    <div class="span3">
                        <h4>Navigation</h4>
                        <ul class="nav">
                            <li><a href="./index.html">Homepage</a></li>  
                            <li><a href="./about.html">About Us</a></li>
                            <li><a href="./contact.html">Contac Us</a></li>
                            <li><a href="./cart.html">Your Cart</a></li>
                            <li><a href="./register.html">Login</a></li>							
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
        <script src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyDbmwYQw5nGav9Uu_iO0YYPW4FmD_38dwE&libraries=places&callback=initMap"
        async defer></script>
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
