<%-- 
    Document   : addProduct
    Created on : Dec 27, 2017, 1:42:24 AM
    Author     : tatyuki1209
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seller Add Product Page</title>

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
    </head>
    <body>

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
                            <a href="viewServlet?action=homeSeller">
                                <i class="material-icons">dashboard</i>
                                <p>Profile</p>
                            </a>
                        </li>   
                        <li class="active">
                            <a href="viewServlet?action=sellerProduct">
                                <i class="material-icons">content_paste</i>
                                <p>List Product of Seller </p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=sellerOrder">
                                <i class="material-icons">location_on</i>
                                <p>List Order </p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=sellerShowReport">
                                <i class="material-icons">library_books</i>
                                <p>Report</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="main-panel">

                <div class="content"> 
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="card">
                                    <div class="card-header" data-background-color="purple">
                                        <h4 class="title">Product</h4>
                                        <p class="category">Tech Line</p>
                                    </div>
                                    <div class="card-content">
                                        <form action="addProductsServlet" method="post">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Product Name</label>
                                                        <input type="text" class="form-control" name="txtProductName" name="txtName" pattern=".{1,500}" required="required" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label>Product Type</label>
                                                        <select class="form-control" name="txtProductType">
                                                            <c:forEach items="${listType}" var="type">
                                                                <option value="${type.typeId}">${type.typeName}</option>                                 
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label>Brand</label>
                                                        <select class="form-control" name="txtBrand">
                                                            <c:forEach items="${listBrand}" var="brand">
                                                                <option value="${brand.brandId}">${brand.brandName}</option>                                 
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>                    
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label>Product Summary</label>
                                                        <textarea rows="10" cols="80" class="form-control" name="txtSummary" maxlength="1000" /></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label>Product Description</label>
                                                        <textarea rows="10" cols="80" class="form-control" name="txtDescription" maxlength="3500"  /></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Product Price</label>
                                                        <input type="number" class="form-control" name="txtPrice"  min="0.01" max="10000" step="0.01"  required="required" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Product Image</label>
                                                        <input type="url" class="form-control" name="txtImageMain" required="required" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Sub Image 1</label>
                                                        <input type="url" class="form-control" name="txtSubImage1" required="" />
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Sub Image 2</label>
                                                        <input type="url" class="form-control" name="txtSubImage2" required="" />
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Sub Image 3</label>
                                                        <input type="url" class="form-control" name="txtSubImage3"  required="" />
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Sub Image 4</label>
                                                        <input type="url" class="form-control" name="txtSubImage4" required="" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Discount</label>
                                                        <input type="number" class="form-control" name="txtDiscount" min="0" max="100" required="required" />
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Unit</label>
                                                        <select class="form-control" name="txtUnit">
                                                            <option value="item">Item</option>
                                                            <option value="set">Set</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Quantity</label>
                                                        <input type="number" class="form-control" name="txtQuantity" min="0" max="100" required="required" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Weight</label>
                                                        <input type="text" class="form-control" name="txtWeight" min="0.01" max="500" step="0.01" required="required" />
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Width</label>
                                                        <input type="text" class="form-control" name="txtWidth" min="0.01" max="1000" step="0.01" required="required" />
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Height</label>
                                                        <input type="text" class="form-control" name="txtHeight" min="0.01" max="1000" step="0.01" required="required" />
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Length</label>
                                                        <input type="text" class="form-control" name="txtLength" min="0.01" max="1000" step="0.01" required="required" />
                                                    </div>
                                                </div>
                                            </div>
                                                    <button type="submit" class="btn btn-primary" name="action" value="sellerAddProduct">Save</button>
                                                    <button type="button" class="btn btn-primary" name="action" value="sellerCancelProduct">Cancel</button>
                                            <div class="clearfix"></div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
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
    <script src="../resource/assets/js/chartist.min.js"></script>

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

