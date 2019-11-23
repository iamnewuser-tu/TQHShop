<%-- 
    Document   : customer
    Created on : Jan 1, 2018, 1:35:08 PM
    Author     : tatyuki1209
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Customer</title>
        <link href="resource/bootstrap/css/bootstrap.min.css" rel="stylesheet">      
        <link href="resource/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">

        <link href="resource/themes/css/bootstrappage.css" rel="stylesheet"/>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet" />

        <!-- global styles -->
        <link href="resource/themes/css/flexslider.css" rel="stylesheet"/>
        <link href="resource/themes/css/main.css" rel="stylesheet"/>
        <link href="resource/themes/css/my-style.css" rel="stylesheet"/>    
        <!-- scripts -->
        <script src="resource/themes/js/jquery-1.7.2.min.js"></script>
        <script src="resource/bootstrap/js/bootstrap.min.js"></script>				
        <script src="resource/themes/js/superfish.js"></script>	
        <script src="resource/themes/js/jquery.scrolltotop.js"></script>
        <script src="resource/themes/js/login-register.js" type="text/javascript"></script>
        <script src="resource/themes/js/date-of-birth.js" type="text/javascript"></script>
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
                                    <form method="post" action="register.html">
                                        <b style="color: red;" id="note1"></b>
                                        <input id="email" class="input-xlarge" type="text" placeholder="Username" name="username" onBlur="checkEmail()" required="true"><br/>
                                        <b style="color: red;" id="note2"></b>
                                        <input id="Regispassword" class="input-xlarge" pattern="[A-Za-z0-9]{6,20}" type="password" placeholder="Password" name="password" required="true"><br/>
                                        <input id="Regispassword_confirmation" class="input-xlarge" pattern="[A-Za-z0-9]{6,20}" type="password" placeholder="Repeat Password" name="password_confirmation" required="true" onBlur="checkPass()"><br/>
                                        <input class="btn btn-inverse" id="btnRegister" value="Create account" name="action" type="submit">
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

        <!--Phần dialog box Change Password-->
        <div class="modal fade login" id="PasswordModal">
            <div class="modal-dialog login animated">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Change Password</h4>
                    </div>
                    <div class="modal-body">  
                        <div class="box">
                            <div class="content">
                                <div class="error"></div>
                                <div class="form loginBox">
                                    <form method="post" action="editCustomerServlet">
                                        <input id="oldPass" class="input-xlarge" pattern="[A-Za-z0-9@a-z.com]{2,30}" type="password" name="txtOldPassword" required="true" required title="This is your current password"><br/>
                                        <input id="newPass" class="input-xlarge" pattern="[A-Za-z0-9]{2,30}" type="password"  name="txtNewPass" required="true" required title="This is your new password"><br/>
                                        <input id="confirmPass" class="input-xlarge" pattern="[A-Za-z0-9]{2,30}" type="password"  name="txtConfirmPass" required="true" required title="Please re-type your new password"><br/>
                                        <button class="btn btn-inverse" style="width:285px;" type="submit" name="action" value="cusChangePassword" onclick="return validatePass()">Change Password</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="forgot login-footer">
                            <span>Note: Change the password remember</span>
                        </div>

                    </div>        
                </div>
            </div>
        </div>
        <!--Kết thúc dialog box Change Password-->
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
            <section class="main-content">
                <div class="row">
                    <div class="span12">
                        <div class="my-main"><!-----!!!!!!!!!!!!!!!!!!!!!!!!.my-main Phan than noi dung trang!!!!!!!!!!!!!!!!!!!!!!!!!!!!----->
                            <button onclick="topFunction()" id="myBtn" title="Go to top">Go to top</button>
                            <h3>My Account Information</h3>

                            <div class="cus-info"><!----- .cus-info ---->
                                <h4>Customer Features</h4>
                                <div class="customer-links"><!----- .customer-links ----->
                                    <ul>
                                        <li><i class="fa fa-shopping-cart"></i><a href="viewServlet?action=viewShoppingCart" id="customer-cart" onclick="return isNull(<%= session.getAttribute("cart") != null%>);">My Cart</a></li>
                                        <li><i class="fa fa-cubes"></i><a href="viewServlet?action=OrderHistory" id="customer-history">Order History</a></li>
                                        <li><i class="fa fa-unlock-alt"></i><a href="javascript:void(0)" data-toggle="modal" onclick="openPasswordModal();">Change Password</a></li>
                                    </ul>
                                </div><!----- .customer-links end ----->
                                <h4>Personal Information</h4>
                                <form action="editCustomerServlet" method="post">
                                    <table style="border:#003 2px solid; border-radius:5px;">
                                        <tbody>
                                            <tr>
                                                <td id="cus-info-1">Full Name</td>
                                                <td id="cus-info-2" colspan="3"><input type="text" id="cusNameEdit" name="txtName" style="width:100%;" value="${user.fullname}" placeholder="Enter your full name" required=""></td>
                                                <td id="cus-info-3"></td>
                                            </tr>
                                            <tr>
                                                <td id="cus-info-1">Date Of Birth</td>
                                                <td id="cus-info-2"><label>Day
                                                        <select name='ddlDay' id='ddlDay' class="form-control"><c:forEach items="${listDate}" var="listDate">
                                                                <option value="${listDate}" ${date == listDate ? 'selected="selected"' : ''}>${listDate}</option></c:forEach>
                                                            </select></label></td>
                                                    <td id="cus-info-2"><label>Month
                                                            <select name='ddlMonth' id='ddlMonth' class="form-control" onchange='loadDay()'><c:forEach items="${listMonth}" var="listMonth">
                                                                <option value="${listMonth}" ${month == listMonth? 'selected="selected"' : ''}>${listMonth}</option></c:forEach>
                                                            </select></label></td>
                                                    <td id="cus-info-2"><label>Year
                                                            <select name='ddlYear' id='ddlYear' class="form-control" onchange='loadDay()'><c:forEach items="${listYear}" var="listYear">
                                                                <option value="${listYear}" ${year == listYear ? 'selected="selected"' : ''}>${listYear}</option></c:forEach>
                                                            </select></label></td>
                                                    <td id="cus-info-3"></td>
                                                </tr>
                                                <tr>
                                                    <td id="cus-info-1">Phone</td>
                                                    <td id="cus-info-2" colspan="3"><input  type="tel" id="cusPhoneEdit" name="txtPhone" style="width:100%;" pattern='\d{9,15}' value="${user.phone}" required title="Phone contains 9-15 digits"/></td>
                                                <td id="cus-info-3"></td>
                                            </tr>
                                            <tr>
                                                <td id="cus-info-1">Email</td>
                                                <td id="cus-info-2" colspan="3"><input type="email" id="cusEmailEdit" name="txtEmail" style="width:100%;" value="${user.email}" placeholder="Enter your email" required title="Email must be in the correct format" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" maxlength="50"></td>
                                                <td id="cus-info-3"></td>
                                            </tr>

                                            <tr>
                                                <td id="cus-info-1">Address:</td>
                                                <td id="cus-info-2" colspan="3"><input type="text" id="address" name="txtAddress" style="width:100%;" value="${customer.address}" placeholder="Enter your address" required maxlength="1000"></td>
                                                <td id="cus-info-3"></td>
                                            </tr>
                                            <tr>
                                                <td id="cus-info-1">Gender:</td>
                                                <td id="cus-info-2">
                                                    <input type="radio" name="gender" value="male" ${customer.gender == 'male' ? 'checked' : ''}> Male 
                                                    <input type="radio" name="gender" value="female" ${customer.gender == 'female' ? 'checked' : ''}> Female
                                                </td>
                                                <td id="cus-info-3" colspan="3"></td>
                                            </tr>
                                            <tr>
                                                <td id="cus-info-1">Point</td>
                                                <td id="cus-info-2">${customer.point}<i class="fa fa-star" style="color: blue;"></i></td>
                                                <td id="cus-info-3" colspan="3"></td>
                                            </tr>
                                            <!--                                        <tr>
                                                                                        <td id="cus-info-1">Discount</td>
                                                                                        <td id="cus-info-2">13%</td>
                                                                                        <td id="cus-info-3"></td>
                                                                                    </tr>-->
                                            <tr>
                                                <td id="cus-info-1"></td>
                                                <td id="cus-info-2" style="float: right;"><button name="action" value="editProfileCustomer" class="btn-success btn-large" type="submit">Edit Profile</button></td>
                                                <td id="cus-info-3" colspan="3"></td>
                                            </tr>    
                                        </tbody>
                                    </table>
                                </form>
                            </div><!----- .cus-info end ---->
                            <div class="clearfix"></div>                      
                        </div><!-----.my-main end----->
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

