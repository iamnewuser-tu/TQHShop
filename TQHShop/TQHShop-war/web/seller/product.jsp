<%-- 
    Document   : customer
    Created on : Dec 17, 2017, 3:07:56 AM
    Author     : Tien
--%>

<%@page import="utils.PageProduct"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seller Product Page</title>

        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />


        <!-- Bootstrap core CSS     -->
        <link href="resource/assets/css/bootstrap.min.css" rel="stylesheet" />

        <!--  Material Dashboard CSS    -->
        <link href="resource/assets/css/material-dashboard.css" rel="stylesheet"/>

        <!--  CSS for Demo Purpose, don't include it in your project     -->
        <link href="resource/assets/css/demo.css" rel="stylesheet" />
        <script src="resource/assets/js/sort.js" type="text/javascript"></script>

        <!--     Fonts and icons     -->
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
        <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css'>
        
         <script>
            function openHistoryModal(productId) {
                
                //ajax to get history.
                $.ajax({
                    type: 'get',
                    data: {txtProductId : productId},
                    url:'viewServlet?action=sellerGetProductHistory',
                    datatype:'text',
                    success: function(response){
                       
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
//            function closeModal(){
//                $('#historyModal').empty();
//            }
            
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
                        
                        //var image = data.productImage.toString().split(',');
                        
                        
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
//                        htmlText += '<td style="width: 100px" >Rating </td>' + '<td>' +data.productRating +'</td>' ;
//                        htmlText += '</tr>';
                        
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
//                        
                       
                        
                        
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
            
            <!--Phần dialog box Product History-->
            <div class="modal fade login" id="EditHistory">
                <div class="modal-dialog login animated">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #3366ff; color: #FFF">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Product History</h4>
                        </div>
                        <div class="modal-body">  
                            <div class="box">
                                <div class="content">
                                    <div class="error"></div>
                                    <div class="form loginBox">
                                        <table class="table table-hover" id="myTable">
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
                                <span>Tech Line In The Best</span>
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
                        <div class="modal-header" style="background-color: #3366ff; color: #FFF">
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
                                <span>Tech Line In The Best</span>
                            </div>

                        </div>        
                    </div>
                </div>
            </div>
            <!--Kết thúc dialog box Product Details-->

            <div class="main-panel">

                <div class="content">
                    <div class="container-fluid">
                        <div class="row" style="text-align: center;"> 
                            <a class="btn-instagram btn" value="permissions" href="RedirectServlet?action=sellerAddProduct">Add</a>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header" data-background-color="purple">
                                        <h4 class="title">Product List</h4>
                                        <p class="category">Tech Line</p>
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
                                                        <td><a href="viewServlet?action=sellerProductDetail&productId=${product.id}">${product.id}</a></td>
                                                        <td><a onclick="openProductDetailModal('${product.id}')">${product.name}</a></td>
                                                        <td>${product.brand}</td>
                                                        <td><img src="${product.image}" style="width: 80px; height: 80px;"/></td>
                                                        <td>${product.quantity}</td>
                                                        <td>
                                                            <a class="btn-instagram btn" href="#" onclick="openHistoryModal('${product.id}')">View History</a>
                                                            <a class="btn-instagram btn" href="editProductsServlet?action=sellerEditProductStatus&productId=${product.id}">${product.productStatus=='true'?'Block':'Enable'}</a>
                                                        </td>



                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                    </div>

                                    <div class="pagination pagination-small pagination-centered" style="margin-left:250px;">
                                        <ul>
                                            <li><a href="viewServlet?action=sellerProduct&btn=prev">Prev</a></li>
                                                <%

                                                    int pages = pageProduct.getPages();
                                                    for (int i = 1; i <= pages; i++) {
                                                %>

                                            <li><a href="viewServlet?action=sellerProduct&page=<%=i%>"><%=i%></a></li>

                                            <%
                                                }
                                            %>
                                            <li><a href="viewServlet?action=sellerProduct&btn=next">Next</a></li>
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

</html>
