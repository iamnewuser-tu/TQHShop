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
        <title>Seller Home Page</title>

        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />

        <!-- Bootstrap core CSS     -->
        <link href="resource/assets/css/bootstrap.min.css" rel="stylesheet" />
        <!--        <script src="resource/bootstrap/js/bootstrap.min.js"></script>	
                <script src="resource/themes/css/bootstrappage.css"></script>
                <script src="resource/bootstrap/css/bootstrap-responsive.min.css"></script>
                <script src="resource/bootstrap/css/bootstrap.css"></script>
                <script src="resource/bootstrap/css/bootstrap-responsive.css"></script>
                <script src="resource/theme/css/my-style.css"></script>-->


        <!--  Material Dashboard CSS    -->
        <link href="resource/assets/css/material-dashboard.css" rel="stylesheet"/>

        <!--  CSS for Demo Purpose, don't include it in your project     -->
        <link href="resource/assets/css/demo.css" rel="stylesheet" />

        <!--     Fonts and icons     -->
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
        <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css'>
        <script src="resource/themes/js/login-register.js" type="text/javascript"></script>

        <!--Richtext-->
        <script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
        <script type="text/javascript">bkLib.onDomLoaded(nicEditors.allTextAreas);</script>

        <script>
            function showPasswordForm() {
                $('#PasswordModal .registerBox').fadeOut('fast', function() {
                    $('.loginBox').fadeIn('fast');

                    $('.modal-title').html('Login with');
                });
                $('.error').removeClass('alert alert-danger').html('');
            }

            function openPasswordModal() {

                setTimeout(function() {
                    $('#PasswordModal').modal('show');
                }, 230);

            }
            function validatePass() {
                var newPass = document.getElementById('newPass').value;
                var confirmPass = document.getElementById('confirmPass').value;

                if (${user.password} != $('#oldPass').val()) {
                    alert('Password is invalid');
                    return false;
                } else if (${user.password} == newPass) {
                    alert('Old Password must be difference new password');
                    return false;
                }
                else if (newPass != confirmPass) {
                    alert('Confirm Password does not match New Password');
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <c:if test="${not empty registMess}">
            <script>
                window.addEventListener("load", function() {
                    alert("${registMess}");
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
                        <li class="active">
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

            <!--Phần dialog box Change Password-->
            <div class="modal fade login" id="PasswordModal">
                <div class="modal-dialog login animated">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #3366ff; color: #FFF">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Change Password</h4>
                        </div>
                        <div class="modal-body">  
                            <div class="box">
                                <div class="content">
                                    <div class="error"></div>
                                    <div class="form loginBox">
                                        <form method="post" action="editSellerServlet">
                                            Old Password:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp<input id="oldPass" class="input-xlarge" pattern=".{5,20}" type="password" name="txtOldPassword" required="true" required title="This is your current password" style="margin-bottom: 10px; width: 270px; border-radius: 4px;"><br/>
                                            New Password:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <input id="newPass" class="input-xlarge" pattern=".{5,20}" type="password"  name="txtNewPass" required="true" required title="This is your new password" style="margin-bottom: 10px; width: 270px; border-radius: 4px;"><br/>
                                            Confirm Password: <input id="confirmPass" class="input-xlarge" pattern=".{5,20}" type="password"  name="txtConfirmPass" required="true" required title="Please re-type your new password" style="margin-bottom: 10px; width: 270px; border-radius: 4px;"><br/>
                                            <button class="btn btn-instagram" type="submit" name="action" value="sellerChangePassword" onclick="return validatePass()">Change Password</button>
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

            <div class="main-panel">
                <div class="content"> 
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="card">
                                    <div class="card-header" data-background-color="purple">
                                        <h4 class="title">Profile Seller</h4>
                                        <p class="category">Tech Line</p>
                                    </div>
                                    <div class="card-content">
                                        <form action="editSellerServlet" method="post" accept-charset="utf-8">
                                            <input type="hidden" name="txtUserID" value="${user.userId}"/>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Email</label>
                                                        <input type="email" class="form-control" value="${user.email}" name="txtEmail" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$">
                                                        <i class="fa fa-unlock-alt"></i><a href="javascript:void(0)" data-toggle="modal" onclick="openPasswordModal();" >   Change Password</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Full Name</label>
                                                        <input type="text" class="form-control" value="${user.fullname}" name="txtName" pattern=".{5,30}" required="required">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Phone</label>
                                                        <input type="text" class="form-control" value="${user.phone}" name="txtPhone" pattern='\d{9,15}' required="required">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Store Name</label>
                                                        <input type="text" class="form-control" value="${txtStoreName}" name="txtStoreName" name="txtName" pattern=".{5,50}" required="required">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Identity Card</label>
                                                        <input type="text" class="form-control" value="${txtIdentityCard}" name="txtIdentityCard" pattern='\d{9,20}' required="required">
                                                    </div>
                                                </div>    
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label>Approved Date</label>
                                                        <input type="date" class="form-control" value="${approvalDate}" min="1900-01-01" max="2100-01-01"  name="txtApprovedDate" required="required">
                                                        </textarea>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group label-floating">
                                                        <label>Approved Place</label>
                                                        <input type="text" class="form-control" value="${txtApprovedPlace}" name="txtApprovedPlace" pattern=".{5,50}" required="required">
                                                        </textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Store Address</label>
                                                        <input type="text" class="form-control" value="${txtStoreAddress}" name="txtStoreAddress" pattern=".{20,100}" required="required">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Store Icon</label>
                                                        <input type="url" class="form-control" value="${txtStoreIcon}" name="txtStoreIcon" required="required">
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Store Icon</label>
                                                        <img src="${txtStoreIcon}" alt="store Icon" style="width: 80px; height: 80px;" required="required"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group label-floating">
                                                        <label class="control-label">Store Summary</label>
                                                        <textarea name="txtStoreSummary" rows="9" cols="200" style="margin: 0px 0px 10px; width: 605px; height: 181px;">${txtStoreSummary}</textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <button type="submit" name="action" class="btn btn-primary" value="updateSellerProfile">Save</button>
                                            <button type="submit" class="btn btn-primary" value="Cancel">Cancel</button>
                                            <div class="clearfix"></div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card card-profile">                                  
                                    <div class="card-avatar">
                                        <a href="#pablo">
                                            <img class="img" src="${txtStoreIcon}" alt="Avatar"/>
                                        </a>
                                    </div>

                                    <div class="content">
                                        <h4 class="card-title">
                                            ${txtStoreName}<br/>
                                            <small>${txtStoreAddress}</small>
                                        </h4>
                                        <p class="card-content">
                                            ${txtStoreSummary}
                                        </p>
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

    <!--  Notifications Plugin    -->
    <script src="resource/assets/js/bootstrap-notify.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

    <!-- Material Dashboard javascript methods -->
    <script src="resource/assets/js/material-dashboard.js"></script>

    <!-- Material Dashboard DEMO methods, don't include it in your project! -->
    <script src="resource/assets/js/demo.js"></script>


</html>

