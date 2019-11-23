<%-- 
    Document   : customer
    Created on : Dec 17, 2017, 3:07:56 AM
    Author     : Tien
--%>

<%@page import="utils.PageProduct"%>
<%@page import="java.util.List"%>
<%@page import="models.SellerOrder"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seller Order Page</title>

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
                        <li>
                            <a href="viewServlet?action=sellerProduct">
                                <i class="material-icons">content_paste</i>
                                <p>List Product of Seller </p>
                            </a>
                        </li>
                        <li class="active">
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
                <%
                    PageProduct pageOrder = (PageProduct) request.getAttribute("order");
                %>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card card-plain">
                                    <div class="card-header" data-background-color="purple">
                                        <h4 class="title">Order List</h4>
                                        <p class="category">Line Tech</p>
                                    </div>

                                   <div class="card-content">
                                        <table class="table table-hover" id="myTable">
                                            <thead class="text-primary">
                                            <th onclick="sortTable(0)"><a href="#">Order ID</a></th>
                                            <th onclick="sortTable(1)"><a href="#">Buyer</a></th>   
                                            <th onclick="sortTable(2)"><a href="#">Date</a></th>
                                            <th onclick="sortTable(3)"><a href="#">Note</a></th>
                                            <th onclick="sortTable(4)"><a href="#">Total Price</a></th>
                                            <th onclick="sortTable(5)"><a href="#">Status</a></th>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="<%=pageOrder.getModel()%>" var="order">
                                                    <c:if test="${order.orderStatus eq 'Done'}">
                                                        <tr style="background-color: #4edc14; color: #ffffff;"> 
                                                            <td>${order.orderId}</td>
                                                            <td>${order.buyer}</td>
                                                            <td><fmt:formatDate pattern="dd/MM/yyyy kk:mm:ss" value="${order.dateOrdered}"/></td>
                                                            <td>${order.orderNote}</td>
                                                            <td>${order.orderTotalPrice}</td>
                                                            <td>${order.orderStatus}</td>
                                                        </tr>
                                                    </c:if>     
                                                    <c:if test="${order.orderStatus eq 'Processing'}">
                                                        <tr style="background-color: #ffb100; color: #ffffff;"> 
                                                            <td>${order.orderId}</td>
                                                            <td>${order.buyer}</td>
                                                            <td><fmt:formatDate pattern="dd/MM/yyyy kk:mm:ss" value="${order.dateOrdered}"/></td>
                                                            <td>${order.orderNote}</td>
                                                            <td>${order.orderTotalPrice}</td>
                                                            <td>${order.orderStatus}</td>
                                                        </tr>
                                                    </c:if>     
                                                    <c:if test="${order.orderStatus eq 'Delivery'}">
                                                        <tr style="background-color: blue; color: #ffffff;"> 
                                                            <td>${order.orderId}</td>
                                                            <td>${order.buyer}</td>
                                                            <td><fmt:formatDate pattern="dd/MM/yyyy kk:mm:ss" value="${order.dateOrdered}"/></td>
                                                            <td>${order.orderNote}</td>
                                                            <td>${order.orderTotalPrice}</td>
                                                            <td>${order.orderStatus}</td>
                                                        </tr>
                                                    </c:if>     
                                                    <c:if test="${order.orderStatus eq 'Cancel'}">
                                                        <tr style="background-color: red; color: #ffffff;"> 
                                                            <td>${order.orderId}</td>
                                                            <td>${order.buyer}</td>
                                                            <td><fmt:formatDate pattern="dd/MM/yyyy kk:mm:ss" value="${order.dateOrdered}"/></td>
                                                            <td>${order.orderNote}</td>
                                                            <td>${order.orderTotalPrice}</td>
                                                            <td>${order.orderStatus}</td>
                                                        </tr>
                                                    </c:if>     
                                                </c:forEach>        
                                            </tbody>
                                        </table>
                                    </div>
                                    
                                    <div class="pagination pagination-small pagination-centered" style="margin-left:400px;">
                                        <ul>
                                            <li><a href="viewServlet?action=sellerOrder&btn=prev">Prev</a></li>
                                                <%

                                                    int pages = pageOrder.getPages();
                                                    for (int i = 1; i <= pages; i++) {
                                                %>

                                            <li><a href="viewServlet?action=sellerOrder&page=<%=i%>"><%=i%></a></li>

                                            <%
                                                }
                                            %>
                                            <li><a href="viewServlet?action=sellerOrder&btn=next">Next</a></li>
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
                                    <a href="#">
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
    <script src="resource/assets/js/sort.js" type="text/javascript"></script>

</html>
