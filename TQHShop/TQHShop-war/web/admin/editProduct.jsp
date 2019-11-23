<%-- 
    Document   : addProduct
    Created on : Dec 27, 2017, 1:42:24 AM
    Author     : tatyuki1209
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Product Page</title>

        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />

        <!-- Bootstrap core CSS     -->
        <link href="resource/assets/css/bootstrap.min.css" rel="stylesheet" />

        <!--  Material Dashboard CSS    -->
        <link href="resource/assets/css/material-dashboard.css" rel="stylesheet"/>

        <!--  CSS for Demo Purpose, don't include it in your project     -->
        <link href="resource/assets/css/demo.css" rel="stylesheet" />

        <!--     Fonts and icons     -->
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
        <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css'>

        <!--Richtext-->
        <script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
        <script type="text/javascript">bkLib.onDomLoaded(nicEditors.allTextAreas);</script>
        <script src="resource/themes/js/date-of-birth.js" type="text/javascript"></script>
    </head>
    <body>
        <c:if test="${not empty message}">
            <script>
                window.addEventListener("load", function() {
                    alert("${message}");
                })
            </script>
        </c:if>
        <div class="wrapper">
            <div class="sidebar" data-color="purple" data-image="resource/assets/img/sidebar-1.jpg">
                <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"
            Tip 2: you can also add an image using data-image tag

                -->

                <div class="logo">
                    <a href="RedirectServlet?action=backToHome" class="simple-text">
                        <img src="resource/assets/img/tim_80x80.png"/>
                    </a>
                </div>


                <div class="sidebar-wrapper">
                    <ul class="nav">
                        <li>
                            <a href="viewServlet?action=homeAdmin">
                                <i class="material-icons">dashboard</i>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showCustomer">
                                <i class="material-icons">person</i>
                                <p>Customer List</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showSeller">
                                <i class="material-icons">person</i>
                                <p>Seller List</p>
                            </a>
                        </li>
                        <li class="active">
                            <a href="viewServlet?action=showProductAdmin">
                                <i class="material-icons">content_paste</i>
                                <p>Product List</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showCategories">
                                <i class="material-icons">library_books</i>
                                <p>Categories</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showProductType">
                                <i class="material-icons">bubble_chart</i>
                                <p>Type Product</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showBrand">
                                <i class="material-icons">bubble_chart</i>
                                <p>Brand</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showOrder">
                                <i class="material-icons">location_on</i>
                                <p>Orders</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="main-panel">
                <nav class="navbar navbar-transparent navbar-absolute">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="#">Profile</a>
                        </div>
                        <div class="collapse navbar-collapse">
                            <ul class="nav navbar-nav navbar-right">
                                <li>
                                    <a href="#pablo" class="dropdown-toggle" data-toggle="dropdown">
                                        <i class="material-icons">dashboard</i>
                                        <p class="hidden-lg hidden-md">Dashboard</p>
                                    </a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        <i class="material-icons">notifications</i>
                                        <span class="notification">5</span>
                                        <p class="hidden-lg hidden-md">Notifications</p>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a href="#">Mike John responded to your email</a></li>
                                        <li><a href="#">You have 5 new tasks</a></li>
                                        <li><a href="#">You're now friend with Andrew</a></li>
                                        <li><a href="#">Another Notification</a></li>
                                        <li><a href="#">Another One</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#pablo" class="dropdown-toggle" data-toggle="dropdown">
                                        <i class="material-icons">person</i>
                                        <p class="hidden-lg hidden-md">Profile</p>
                                    </a>
                                </li>
                            </ul>

                            <form class="navbar-form navbar-right" role="search">
                                <div class="form-group  is-empty">
                                    <input type="text" class="form-control" placeholder="Search">
                                    <span class="material-input"></span>
                                </div>
                                <button type="submit" class="btn btn-white btn-round btn-just-icon">
                                    <i class="material-icons">search</i><div class="ripple-container"></div>
                                </button>
                            </form>
                        </div>
                    </div>
                </nav>

                <div class="content"> 
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-10">
                                <div class="card">
                                    <div class="card-header" data-background-color="purple">
                                        <h4 class="title">Product</h4>
                                        <p class="category">Update Your Own Product</p>
                                    </div>
                                    <div class="card-content">
                                        <form action="editProductsServlet" method="post">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Product ID</label>
                                                        <input type="text" class="form-control" name="txtProductID" value="${product.productId}" readonly="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Product Name</label>
                                                        <input type="text" class="form-control" name="txtProductName" value="${product.productName}" pattern=".{1,500}" required title="Name contains 1 to 500 characters">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label>Product Type</label>
                                                        <select class="form-control" name="txtProductType">
                                                            <c:forEach items="${listType}" var="type">
                                                                <option value="${type.typeId}" ${type.typeId == product.typeId.typeId ? 'selected="selected"' : ''}>${type.typeName}</option>                                 
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label>Brand</label>
                                                        <select class="form-control" name="txtBrand">
                                                            <c:forEach items="${listBrand}" var="brand">
                                                                <option value="${brand.brandId}" ${brand.brandId == product.brandId.brandId ? 'selected="selected"' : ''}>${brand.brandName}</option>                                 
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>                    
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label>Product Summary</label>
                                                        <textarea rows="10" cols="80" class="form-control" name="txtSummary" maxlength="1000">${product.productSummary}</textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label>Product Description</label>
                                                        <textarea rows="10" cols="80" class="form-control" name="txtDescription" maxlength="3500">${product.productDesc}</textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Product Price</label>
                                                        <input type="number" class="form-control" name="txtPrice" value="${product.productPrice}" min="0.01" max="10000" step="0.01" required="">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Product Image</label>
                                                        <input type="url" class="form-control" name="txtImage" value="${mainImg}" maxlength="800" required="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Sub Image 1</label>
                                                        <input id="txtImage1" type="url" class="form-control" name="txtImage1" value="${subImg1}" maxlength="800" onblur="checkSubImage()">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Sub Image 2</label>
                                                        <input id="txtImage2" type="url" class="form-control" name="txtImage2" value="${subImg2}" maxlength="800" onblur="checkSubImage()">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Sub Image 3</label>
                                                        <input id="txtImage3" type="url" class="form-control" name="txtImage3" value="${subImg3}" maxlength="800" onblur="checkSubImage()">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Sub Image 4</label>
                                                        <input id="txtImage4" type="url" class="form-control" name="txtImage4" value="${subImg4}" maxlength="800" onblur="checkSubImage()">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Discount</label>
                                                        <input type="number" class="form-control" name="txtDiscount" value="${product.productDiscount}" min="0" max="100">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Unit</label>
                                                        <select class="form-control" name="txtUnit">
                                                            <option value="item" ${product.productUnit == 'item' ? 'selected' : ''}>Item</option>
                                                            <option value="set" ${product.productUnit == 'set' ? 'selected' : ''}>Set</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Quantity</label>
                                                        <input type="number" class="form-control" name="txtQuantity" value="${product.productQuantity}" min="0" max="100" required="">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Weight</label>
                                                        <input type="number" class="form-control" name="txtWeight" value="${product.productWeight}" min="0.01" max="500" step="0.01" required="">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Width</label>
                                                        <input type="number" class="form-control" name="txtWidth" value="${product.productWidth}" min="0.01" max="1000" step="0.01" required="">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Height</label>
                                                        <input type="number" class="form-control" name="txtHeight" value="${product.productHeigth}" min="0.01" max="1000" step="0.01" required="">
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Length</label>
                                                        <input type="number" class="form-control" name="txtLength" value="${product.productLength}" min="0.01" max="1000" step="0.01" required="">
                                                    </div>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary" name="action" value="editProduct">Save</button>
                                            <a href="viewServlet?action=showProductAdmin" class="btn btn-primary">Cancel</a>
                                            <div class="clearfix"></div>
                                        </form>
                                    </div>
                                </div>
                            </div>               
                        </div>
                    </div>    
                </div>

                <footer class="footer">
                    <div class="container-fluid">
                        <nav class="pull-left">
                            <ul>
                                <li>
                                    <a href="#">
                                        Home
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Company
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Portfolio
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Blog
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        <p class="copyright pull-right">
                            &copy; <script>document.write(new Date().getFullYear())</script> <a href="http://www.creative-tim.com">Creative Tim</a>, made with love for a better web
                        </p>
                    </div>
                </footer>
            </div>
        </div>

    </body>

    <!--   Core JS Files   -->
    <script src="resource/assets/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <script src="resource/assets/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="resource/assets/js/material.min.js" type="text/javascript"></script>

    <!--  Charts Plugin -->
    <script src="resource/assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="resource/assets/js/bootstrap-notify.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

    <!-- Material Dashboard javascript methods -->
    <script src="resource/assets/js/material-dashboard.js"></script>

    <!-- Material Dashboard DEMO methods, don't include it in your project! -->
    <script src="resource/assets/js/demo.js"></script>

    <script type="text/javascript">
                                $(document).ready(function() {

                                    // Javascript method's body can be found in assets/js/demos.js
                                    demo.initDashboardPageCharts();

                                });
    </script>

</html>

