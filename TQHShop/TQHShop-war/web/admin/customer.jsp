<%-- 
    Document   : customer
    Created on : Dec 17, 2017, 3:07:56 AM
    Author     : Tien
--%>
<%@page import="utils.PageProduct"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>

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
                        <li class="active">
                            <a href="viewServlet?action=showCustomer&page=1">
                                <i class="material-icons">person</i>
                                <p>Customer List</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showSeller&page=1">
                                <i class="material-icons">person</i>
                                <p>Seller List</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showProductAdmin&page=1">
                                <i class="material-icons">content_paste</i>
                                <p>Product List</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showCategories&page=1">
                                <i class="material-icons">library_books</i>
                                <p>Categories</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showProductType&page=1">
                                <i class="material-icons">bubble_chart</i>
                                <p>Type Product</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showBrand&page=1">
                                <i class="material-icons">bubble_chart</i>
                                <p>Brand</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showOrder&page=1">
                                <i class="material-icons">location_on</i>
                                <p>Orders</p>
                            </a>
                        </li>
                        <li>
                            <a href="viewServlet?action=showReport">
                                <i class="material-icons">library_books</i>
                                <p>Report</p>
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
                        </div>
                    </div>
                </nav>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                                <div class="col-md-12">
                                    <div class="card card-plain">
                                        <div class="card-header" data-background-color="purple">
                                            <h4 class="title">Customers</h4>
                                            <p class="category">Line Tech</p>
                                        </div>
                                        <div class="card-content table-responsive">
                                            <%
                                                PageProduct pageCus = (PageProduct) request.getAttribute("pageCus");
                                            %>
                                            <table class="table table-hover" id="myTable">
                                                <thead>
                                                <th onclick="sortTable(0)"><a href="#">ID</a></th>
                                                <th onclick="sortTable(1)"><a href="#">Name</a></th>
                                                <th onclick="sortTable(2)"><a href="#">dob</a></th>
                                                <th onclick="sortTable(3)"><a href="#">Gender</a></th>
                                                <th onclick="sortTable(4)"><a href="#">Address</a></th>
                                                <th onclick="sortTable(5)"><a href="#">Point</a></th>
                                                <th><a href="#">Action</a></th>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="<%=pageCus.getModel()%>" var="customer">
                                                        <tr>
                                                            <td>${customer.userId}</td>
                                                            <td>${customer.users.fullname}</td>
                                                            <td>${customer.dob}</td>
                                                            <td>${customer.gender}</td>
                                                            <td>${customer.address}</td>
                                                            <td>${customer.point}</td>
                                                            <td><a href="editCustomerServlet?action=blockCustomer&cusId=${customer.userId}&bl=${customer.users.userStatus ? 'Block' : 'Unblock'}" class="btn-instagram btn" name="action" onclick="return showDialog('${customer.users.userStatus ? 'Block' : 'Unblock'}');">${customer.users.userStatus ? 'Block' : 'Unblock'}</a></td>
                                                        </tr>
                                                    </c:forEach>    
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="pagination pagination-small pagination-centered" style="margin-left:650px;">
                                            <ul>
                                                <li><a href="viewServlet?action=showCustomer&btn=prev">Prev</a></li>
                                                <%
                                                    int pages = pageCus.getPages();
                                                    int currentPage = 1;
                                                    if (session.getAttribute("currentPage") != null) {
                                                        currentPage = (Integer)session.getAttribute("currentPage");
                                                    }
                                                    for (int i = 1; i <= pages; i++) {
                                                %>

                                                <li <% if (currentPage == i) { %> class="active" <% } %>><a href="viewServlet?action=showCustomer&page=<%=i%>"><%=i%></a></li>

                                                <%
                                                    }
                                                %>
                                                <li><a href="viewServlet?action=showCustomer&btn=next">Next</a></li>
                                            </ul>
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
                                    <a href="RedirectServlet?action=backToHome">
                                        Home
                                    </a>
                                </li> 
                            </ul>
                        </nav>
                        <p class="copyright pull-right">
                            &copy; <script>document.write(new Date().getFullYear())</script> <a href="#">Line Tech</a>, made with love for a Group THQShop
                        </p>
                    </div>
                </footer>
            </div>
        </div>
        <script>
            function showDialog(isBlock) {
                if (isBlock == 'Block') {
                    return confirm('This action will also block customer comments\nAre you sure?');
                } else {
                    return confirm('Are your sure you want to unblock this customer?');
                }
            }
        </script>
    </body>

    <!--   Core JS Files   -->
    <script src="resource/assets/js/jquery-3.1.0.min.js" type="text/javascript"></script>
    <script src="resource/assets/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="resource/assets/js/material.min.js" type="text/javascript"></script>
    <script src="resource/assets/js/sort.js" type="text/javascript"></script>
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

</html>
