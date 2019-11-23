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
        <title>Edit Type Page</title>

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
    </head>
    <body>
        <c:if test="${not empty message}">
            <script>
                window.addEventListener("load", function() {
                    alert("${message}");
                })
            </script>
        </c:if>
        <div class="sidebar" data-color="purple" data-image="resource/assets/img/sidebar-1.jpg">

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
                        <li>
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
                        <li class="active">
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
            <div class="content"> 
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-10">
                            <div class="card">
                                <div class="card-header" data-background-color="purple">
                                    <h4 class="title">Product Type</h4>
                                    <p class="category">Update Product Type</p>
                                </div>
                                <div class="card-content">
                                    <form action="editProductsServlet" method="post">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Type ID</label>
                                                    <input type="text" class="form-control" name="txtTypeId" value="${type.typeId}" readonly="">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group label-floating">
                                                    <label>Category</label>
                                                    <select class="form-control" name="txtCategory">
                                                        <c:forEach items="${listCategory}" var="category">
                                                            <option value="${category.categoryId}" ${category.categoryId == type.categoryId.categoryId ? 'selected="selected"' : ''}>${category.categoryName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Type Name</label>
                                                    <input type="text" class="form-control" name="txtTypeName" value="${type.typeName}" pattern="[A-Za-z0-9 /-]{1,50}" required title="Name contains 1 to 50 characters">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group label-floating">
                                                    <label>Type Description</label>
                                                    <textarea rows="10" cols="80" class="form-control" name="txtTypeDesc" maxlength="300">${type.typeDesc}</textarea>
                                                </div>
                                            </div>
                                        </div>                
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Type Icon</label>
                                                    <input type="text" class="form-control" name="txtTypeIcon" value="${type.typeIcon}" maxlength="200">
                                                </div>
                                            </div>
                                        </div>

                                        <button type="submit" name="action" class="btn btn-primary" value="editProductType">Save</button>
                                        <a href="viewServlet?action=showProductType" class="btn btn-primary">Cancel</a>
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

