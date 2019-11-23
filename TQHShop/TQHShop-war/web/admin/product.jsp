<%-- 
    Document   : customer
    Created on : Dec 17, 2017, 3:07:56 AM
    Author     : Tien
--%>

<%@page import="utils.PageProduct"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>

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
        <script>
            function openHistoryModal(productId) {
                
                //ajax to get history.
                $.ajax({
                    type: 'get',
                    data: {txtProductId : productId},
                    url:'viewServlet?action=adminGetProductHistory',
                    datatype:'text',
                    success: function(response){
                       
                       // alert(datas);
                        var htmlText = '';
                        data = JSON.parse(response);
                        
                        for(i=0; i<data.length; i++){
                            htmlText += '<tr>';
                            htmlText += '<td>'+data[i].version+'</td>';
                            htmlText += '<td>'+data[i].productId+'</td>';
                            htmlText += '<td>'+data[i].productName+'</td>';
                            htmlText += '<td>'+data[i].productPrice+'</td>';
                            htmlText += '<td>'+data[i].productDiscount+'</td>';
                            htmlText += '<td>'+data[i].editTime+'</td>';
                            htmlText += '</tr>';
                        }
                        $('#historyModal').empty();
                        $('#historyModal').append(htmlText);
                        
                    }
                });
                
                
                setTimeout(function() {
                    $('#EditHistory').modal('show');
                }, 230);
            }
            
            
            function openProductDetailModal(productId) {
                
                //ajax to get history.
                $.ajax({
                    type: 'get',
                    data: {txtProductId : productId},
                    url:'viewServlet?action=getProductDetail',
                    datatype:'text',
                    success: function(response){
                       
                       // alert(datas);
                        var htmlText = '';
                        data = JSON.parse(response);
                        
                        var image = data.productImage.toString().split(',');
                        
                        
                        htmlText += '<tr>';
                        htmlText += '<td  style="width: 100px" >Product Id</td>' + '<td>' +data.productId+ '</td>' ;
                        htmlText += '</tr>';
                        
                        htmlText += '<tr>';
                        htmlText += '<td  style="width: 100px" >Type</td>' +  '<td>' +data.productType+ '</td>' ;
                        htmlText += '</tr>';
                        
                        htmlText += '<tr>';
                        htmlText += '<td  style="width: 100px" >Brand</td>' + '<td>' +data.productBrand+ '</td>' ;
                        htmlText += '</tr>';
                        
                        htmlText += '<tr>';
                        htmlText += '<td  style="width: 100px" >Price</td>' + '<td>' +data.productPrice+ '$</td>' ;
                        htmlText += '</tr>';
                        
                       htmlText += '<tr>';
                        htmlText += '<td  style="width: 100px" >Quantity</td>' + '<td>' +data.productQuantity+ '</td>' ;
                        htmlText += '</tr>';
                        
                        htmlText += '<tr>';
                        htmlText += '<td  style="width: 100px" >Discount</td>' + '<td>' +data.productDiscount+ '</td>' ;
                        htmlText += '</tr>';
                        
                        htmlText += '<tr>';
                        htmlText += '<td style="width: 100px" >Summary </td>' + '<td>' +data.productSummary +'</td>' ;
                        htmlText += '</tr>';
                        
                        htmlText += '<tr>';
                        htmlText += '<td style="width: 100px" >Orders </td>' + '<td>' +data.productOrders +'</td>' ;
                        htmlText += '</tr>';
                        
//                        htmlText += '<tr>';
//                        htmlText += '<td  style="width: 100px" >Image Main</td>' + '<td>' +'<img src="'+image[0]+'" style="width: 80px; height: 80px;"/>'+ '</td>' ;
//                        htmlText += '</tr>';
//                       
//                        htmlText += '<tr>';
//                        htmlText += '<td  style="width: 100px" > Image Sub 1</td>' + '<td>' +'<img src="'+image[1]+'" style="width: 60px; height: 60px;"/>'+ '</td>' ;
//                        htmlText += '</tr>';
//                        
//                        htmlText += '<tr>';
//                        htmlText += '<td style="width: 100px" >Image Sub 2</td>' + '<td>' +'<img src="'+image[2]+'" style="width: 60px; height: 60px;"/>'+'</td>' ;
//                        htmlText += '</tr>';
//                        
//                        htmlText += '<tr>';
//                        htmlText += '<td style="width: 100px" >Image Sub 3</td>' + '<td>' +'<img src="'+image[3]+'" style="width: 60px; height: 60px;"/>' +'</td>' ;
//                        htmlText += '</tr>';
//                        
//                        htmlText += '<tr>';
//                        htmlText += '<td style="width: 100px" >Image Sub 4</td>' + '<td>' +'<img src="'+image[4]+'" style="width: 60px; height: 60px;">'+ '</td>' ;
//                        htmlText += '</tr>';
                        
                       
                        
                        
                        $('#productDetailModal').empty();
                        $('#productDetailModal').append(htmlText);
                        
                    }
                });
                
                
                setTimeout(function() {
                    $('#ProductDetail').modal('show');
                }, 230);
            }
        </script>
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
                            <a href="viewServlet?action=showCustomer&page=1">
                                <i class="material-icons">person</i>
                                <p>Customer List</p>
                            </a>
                        </li>
                        <li ${not empty param.sellerID ? 'class="active"' : ''}>
                            <a href="viewServlet?action=showSeller&page=1">
                                <i class="material-icons">person</i>
                                <p>Seller List</p>
                            </a>
                        </li>
                        <li ${empty param.sellerID ? 'class="active"' : ''}>
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
                            <a href="viewServlet?action=showReport&page=1">
                                <i class="material-icons">library_books</i>
                                <p>Report</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!--Phần dialog box Product History-->
            <div class="modal fade login" id="EditHistory">
                <div class="modal-dialog login animated">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Product History</h4>
                        </div>
                        <div class="modal-body">  
                            <div class="box">
                                <div class="content">
                                    <div class="error"></div>
                                    <div class="form loginBox">
                                        <table class="table table-hover">
                                            <thead class="text-primary">                     
                                            <th>Version</th>
                                            <th>Product ID</th>
                                            <th>Product Name</th>
                                            <th>Price</th>
                                            <th>Discount</th>
                                            <th>Edit Time</th>
                                            </thead>
                                            <tbody id="historyModal">
                                                    
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="forgot login-footer">
                                <span></span>
                            </div>

                        </div>        
                    </div>
                </div>
            </div>
            <!--Kết thúc dialog box Product History-->
            
            <!--Phần dialog box Product Details-->
            <div class="modal fade login" id="ProductDetail">
                <div class="modal-dialog login animated">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Product Detail</h4>
                        </div>
                        <div class="modal-body">  
                            <div class="box">
                                <div class="content">
                                    <div class="error"></div>
                                    <div class="form loginBox">
                                        <table class="table table-hover" id="productDetailModal">
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="forgot login-footer">
                                <span></span>
                            </div>

                        </div>        
                    </div>
                </div>
            </div>
            <!--Kết thúc dialog box Product Details-->

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
                        <div class="row" style="text-align: center;">
                            <c:if test="${empty param.sellerID}">
                                <a class="btn-instagram btn" value="permissions" href="RedirectServlet?action=addProduct">Add</a>
                            </c:if>
                            <c:if test="${not empty param.sellerID}">
                                <button class="btn-instagram btn" onclick="window.history.back();">Back</button>
                            </c:if>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header" data-background-color="purple">
                                        <h4 class="title">Product List</h4>
                                        <p class="category">Products in store</p>
                                    </div>
                                    <%
                                        PageProduct pageProduct = (PageProduct) request.getAttribute("pageProduct");
                                    %>
                                    <div class="card-content table-responsive">
                                        <table class="table table-hover" id="myTable">
                                            <thead class="text-primary">                     
                                            <th onclick="sortTable(0)"><a href="#">ID</a></th>
                                            <th onclick="sortTable(1)"><a href="#">Product Name</a></th>
                                            <th onclick="sortTable(2)"><a href="#">Brand</a></th>
                                            <th><a href="#">Image</a></th>
                                            <th onclick="sortTable(4)"><a href="#">Quantity</a></th>
                                            <th><a href="#">Action</a></th>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="<%=pageProduct.getModel()%>" var="product">
                                                    <tr>
                                                        <td>
                                                            <c:if test="${empty param.sellerID}">
                                                                <a href="RedirectServlet?action=editProduct&pid=${product.id}">${product.id}</a>
                                                            </c:if>
                                                            <c:if test="${not empty param.sellerID}">
                                                                ${product.id}
                                                            </c:if>
                                                        </td>
                                                        <td><a onclick="openProductDetailModal('${product.id}')">${product.name}</a></td>
                                                        <td>${product.brand}</td>
                                                        <td><img src="${product.image}" style="width: 80px; height: 80px;"/></td>
                                                        <td>${product.quantity}</td>
                                                        <td>
                                                            <a class="btn-instagram btn" onclick="openHistoryModal('${product.id}')">View History</a>
                                                            <a class="btn-instagram btn" href="editProductsServlet?action=blockProduct&pid=${product.id}&bl=${product.productStatus ? 'Block' : 'Unblock'}" style="width:136.45px;" onclick="return showDialog('${product.productStatus ? 'Block' : 'Unblock'}');">${product.productStatus ? 'Block' : 'Unblock'}</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>        
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="pagination pagination-small pagination-centered" style="margin-left:250px;">
                                        <ul>
                                            <li><a href="viewServlet?action=showProductAdmin&btn=prev">Prev</a></li>
                                                <%
                                                    int pages = pageProduct.getPages();
                                                    int currentPage = 1;
                                                    if (session.getAttribute("currentPage") != null) {
                                                        currentPage = (Integer)session.getAttribute("currentPage");
                                                    }
                                                    for (int i = 1; i <= pages; i++) {
                                                %>

                                            <li <% if (currentPage == i) { %> class="active" <% } %>><a href="viewServlet?action=showProductAdmin&page=<%=i%>"><%=i%></a></li>
                                                <%
                                                    }
                                                %>
                                            <li><a href="viewServlet?action=showProductAdmin&btn=next">Next</a></li>
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
                    return confirm('Are you sure you want to block this product?');
                } else {
                    return confirm('Are your sure you want to unblock this product?');
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

    <!-- Material Dashboard javascript methods -->
    <script src="resource/assets/js/material-dashboard.js"></script>

    <!-- Material Dashboard DEMO methods, don't include it in your project! -->
    <script src="resource/assets/js/demo.js"></script>

</html>
