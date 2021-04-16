<%-- 
    Document   : profile
    Created on : Apr 2, 2021, 9:56:19 AM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta name="description" content="Luxury Hotel Web Management" />
        <meta name="author" content="Rick" />
        <title>Luxury Hotel</title>
        <jsp:include page="include-management/css-page.jsp" />
        <style>
            .error-class {
                color: red;
            }
            .mes {
                color: red;
            }
        </style>
    </head>
    <body class="page-header-fixed sidemenu-closed-hidelogo page-content-white page-md header-white dark-sidebar-color logo-dark">
        <div class="page-wrapper">
            <jsp:include page="include-management/header.jsp" />
            <!-- start page container -->	
            <div class="page-container">	
                <!-- start sidebar menu -->	
                <div class="sidebar-container">	
                    <div class="sidemenu-container navbar-collapse collapse fixed-menu">	
                        <div id="remove-scroll">	
                            <ul class="sidemenu page-header-fixed p-t-15" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="150">	
                                <li class="sidebar-toggler-wrapper hide">	
                                    <div class="sidebar-toggler">	
                                        <span></span>	
                                    </div>	
                                </li>	
                                <li class="sidebar-user-panel">	
                                    <div class="user-panel">	
                                        <div class="row">	
                                            <div class="sidebar-userpic">
                                                    <img src="<c:url value="/resources-management/img/avatar.png"/>" class="img-responsive" alt="">     
                                            </div>	
                                        </div>	
                                        <div class="profile-usertitle">	
                                            <div class="sidebar-userpic-name"> ${user.fullName} </div>	
                                            <div class="profile-usertitle-job">
                                                <c:if test="${roles == '[ROLE_USER]'}">USER</c:if>
                                                <c:if test="${roles == '[ROLE_ADMIN]'}">ADMIN</c:if>
                                                <c:if test="${roles == '[ROLE_RECEPTIONIST]'}">RECEPTIONIST</c:if>
                                                <c:if test="${roles == '[ROLE_MANAGER]'}">MANAGER</c:if>
                                            </div>	
                                        </div>	
                                        <div class="sidebar-userpic-btn">	
                                            <a class="tooltips" href="${pageContext.request.contextPath}/profile" data-placement="top" data-original-title="Profile">	
                                                <i class="material-icons">person_outline</i>	
                                            </a>	
                                            <a class="tooltips" href="${pageContext.request.contextPath}/login" data-placement="top" data-original-title="Logout">	
                                                <i class="material-icons">input</i>	
                                            </a>	
                                        </div>	
                                    </div>	
                                </li>
                                <sec:authorize access="isAuthenticated()">
                                <sec:authorize access="hasAnyRole('ROLE_RECEPTIONIST,ROLE_MANAGER')">    
                                <li class="nav-item start">
                                    <a href="${pageContext.request.contextPath}/booking" class="nav-link">
                                    
                                        <i class="material-icons">business_center</i>	
                                        <span class="title">Booking</span>
                                        <span class="selected"></span>
                                    </a>
                                </li>
                                </sec:authorize>
                                <sec:authorize access="hasAnyRole('ROLE_RECEPTIONIST,ROLE_MANAGER')">
                                <li class="nav-item">
                                    <a class="nav-link nav-toggle">
                                        <i class="fa fa-book"></i>	
                                        <span class="title">Information</span>	
                                        <span class="arrow"></span>	
                                    </a>	
                                    <ul class="sub-menu">	
                                        <li class="nav-item">	
                                            <a href="${pageContext.request.contextPath}/information/view-customer" class="nav-link ">	
                                                <i class="fa fa-address-book-o"></i> Customer Info	
                                            </a>	
                                        </li>
                                        <li class="nav-item">	
                                            <a href="${pageContext.request.contextPath}/information/booking-history" class="nav-link ">	
                                                <i class="fa fa-folder"></i> Booking History	
                                            </a>	
                                        </li>	
                                    </ul>	
                                </li>
                                </sec:authorize>
                                <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
                                <li class="nav-item">
                                    <a class="nav-link nav-toggle">
                                        <i class="fa fa-user-circle"></i> 
                                        <span class="title">Account</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/account/view-account" class="nav-link">
                                                <i class="fa fa-group"></i> View Accounts</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/account/add-account" class="nav-link">
                                                <i class="fa fa-user-plus"></i> New Account</a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/account/change-password" class="nav-link">
                                                <i class="fa fa-retweet"></i> Change Password</a>
                                        </li>
                                    </ul>
                                </li>
                                </sec:authorize>
                                <sec:authorize access="hasAnyRole('ROLE_MANAGER')">
                                <li class="nav-item">
                                    <a class="nav-link nav-toggle">
                                        <i class="material-icons">settings</i>
                                        <span class="title">Hotel Management</span>
                                        <span class="arrow "></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item">
                                            <a class="nav-link nav-toggle">
                                                <i class="fa fa-plus"></i> Room Types
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/room-type/view-room-type" class="nav-link">
                                                        <i class="fa fa-minus"></i> View Room Types</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/room-type/add-room-type" class="nav-link">
                                                        <i class="fa fa-minus"></i> New Room Type</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link nav-toggle">
                                                <i class="fa fa-plus"></i> Rooms
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/room/view-room" class="nav-link">
                                                        <i class="fa fa-minus"></i> View Rooms</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/room/add-room" class="nav-link">
                                                        <i class="fa fa-minus"></i> New Room</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link nav-toggle">
                                                <i class="fa fa-plus"></i> Services
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/service/view-service" class="nav-link">
                                                        <i class="fa fa-minus"></i> View Services</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/service/add-service" class="nav-link">
                                                        <i class="fa fa-minus"></i> New Service</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link nav-toggle">
                                                <i class="fa fa-plus"></i> Promotions
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/promotion/view-promotion" class="nav-link">
                                                        <i class="fa fa-minus"></i> View Promotions</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/promotion/add-promotion" class="nav-link">
                                                        <i class="fa fa-minus"></i> New Promotion</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                </sec:authorize>
                                </sec:authorize>
                            </ul>		
                        </div>	
                    </div>	
                </div>
                <!-- end sidebar menu -->
                <!-- start page content -->
                <div class="page-content-wrapper">
                    <div class="page-content">
                        <div class="page-bar">
                            <div class="page-title-breadcrumb">
                                <div class=" pull-left">
                                    <div class="page-title">User Profile</div>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li><a class="parent-item">User Profile</a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN PROFILE SIDEBAR -->
                                <div class="profile-sidebar">
                                    <div class="card card-topline-aqua">
                                        <div class="card-body no-padding height-9">
                                            <div class="row">
                                                <div class="profile-userpic">
                                                    <img src="<c:url value="/resources-management/img/avatar.png"/>" class="img-responsive" alt=""> </div>
                                            </div>
                                            <div class="profile-usertitle">
                                                <div class="profile-usertitle-name"> ${user.fullName} </div>
                                                <div class="profile-usertitle-job">
                                                    <c:if test="${roles == '[ROLE_USER]'}">USER</c:if>
                                                    <c:if test="${roles == '[ROLE_ADMIN]'}">ADMIN</c:if>
                                                    <c:if test="${roles == '[ROLE_RECEPTIONIST]'}">RECEPTIONIST</c:if>
                                                    <c:if test="${roles == '[ROLE_MANAGER]'}">MANAGER</c:if>
                                                    </div>
                                                </div>
                                                <!-- END SIDEBAR USER TITLE -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- END BEGIN PROFILE SIDEBAR -->
                                    <!-- BEGIN PROFILE CONTENT -->
                                    <div class="profile-content">
                                        <div class="row">
                                            <div class="profile-tab-box">
                                                <div class="p-l-20">
                                                    <ul class="nav ">
                                                        <li class="nav-item tab-all"><a
                                                                class="nav-link ${active1} show" href="#tab1" data-toggle="tab">Account Info</a></li>
                                                        <li class="nav-item tab-all p-l-20"><a class="nav-link ${active2}"
                                                                                               href="#tab3" data-toggle="tab">Change Password</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="white-box">
                                                <!-- Tab panes -->
                                                <div class="tab-content">
                                                    <div class="tab-pane ${active1} fontawesome-demo" id="tab1">
                                                        <div id="biography" >
                                                            <div class="row">
                                                                <div class="col-md-6"> 
                                                                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                                        <input class="mdl-textfield__input" type="text" id="txtRoomNo" value="${user.email}" readonly="">
                                                                    <label class="mdl-textfield__label">Email</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6"> 
                                                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                                    <c:if test="${roles == '[ROLE_USER]'}"><input class="mdl-textfield__input" type="text"  value="USER" readonly=""></c:if>
                                                                    <c:if test="${roles == '[ROLE_ADMIN]'}"><input class="mdl-textfield__input" type="text" value="ADMIN" readonly=""></c:if>
                                                                    <c:if test="${roles == '[ROLE_RECEPTIONIST]'}"><input class="mdl-textfield__input" type="text"  value="RECEPTIONIST" readonly=""></c:if>
                                                                    <c:if test="${roles == '[ROLE_MANAGER]'}"><input class="mdl-textfield__input" type="text"  value="MANAGER" readonly=""></c:if>
                                                                    <label class="mdl-textfield__label">Role</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6"> 
                                                                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                                        <input class="mdl-textfield__input" type="text"  value="${user.fullName}" readonly="">
                                                                    <label class="mdl-textfield__label">Full Name</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6"> 
                                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                                    <input class ="mdl-textfield__input" type="text"  value="${user.gender}" readonly="">
                                                                    <label class="mdl-textfield__label">Gender</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6"> 
                                                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                                    <input class="mdl-textfield__input" type="date"  value="${user.birthDate}" readonly="">
                                                                    <label class="mdl-textfield__label">Birth Date</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6"> 
                                                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                                    <input class="mdl-textfield__input" type="text"  value="${user.address}" readonly="">
                                                                    <label class="mdl-textfield__label">Address</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6"> 
                                                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                                    <input class="mdl-textfield__input" type="text"  value="${user.phoneNumber}" readonly="">
                                                                    <label class="mdl-textfield__label">Phone Number</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane ${active2}" id="tab3">
                                                    <div class="row">
                                                        <div class="col-md-12 col-sm-12">
                                                            <div class="card-head">
                                                                <header>Password Change</header>
                                                                <button id = "panel-button2" 
                                                                        class = "mdl-button mdl-js-button mdl-button--icon pull-right" 
                                                                        data-upgraded = ",MaterialButton">
                                                                    <i class = "material-icons">more_vert</i>
                                                                </button>
                                                                <ul class = "mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
                                                                    data-mdl-for = "panel-button2">
                                                                    <li class = "mdl-menu__item"><i class="material-icons">assistant_photo</i>Action</li>
                                                                    <li class = "mdl-menu__item"><i class="material-icons">print</i>Another action</li>
                                                                    <li class = "mdl-menu__item"><i class="material-icons">favorite</i>Something else here</li>
                                                                </ul>
                                                            </div>
                                                            <div class="card-body " id="bar-parent1">
                                                                <form action="${pageContext.request.contextPath}/profile/change-password" method="post" name="validateForm">
                                                                    <div class="form-group">
                                                                        <label for="oldPass">Current Password</label>
                                                                        <input type="password" class="form-control" id="oldPass" name="oldPass" placeholder="Current Password">
                                                                        <c:if test="${mes != null && mes != ''}">
                                                                            <p class="mes">${mes}</p>
                                                                        </c:if>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="newPass">New Password</label>
                                                                        <input type="password" class="form-control" id="newPass" name="newPass" placeholder="New Password">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="rePass">New Password</label>
                                                                        <input type="password" class="form-control" id="rePass" name="rePass" placeholder="Confirm New Password">
                                                                    </div>
                                                                    <button type="submit" class="btn btn-primary">Submit</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="visibility: hidden">
                                    <div class="col-md-12"> 
                                        <div class="card card-box">
                                            <div class="card-head">
                                                <header></header>
                                            </div>
                                            <div class="card-body ">


                                            </div>
                                        </div>
                                    </div>
                                </div>                                     
                                <!-- END PROFILE CONTENT -->
                            </div>
                        </div>
                    </div>
                    <!-- end page content -->
                </div>
            </div>
        </div>
        <!-- end page content -->                                
        <!-- start footer -->
        <jsp:include page="include-management/footer.jsp" />
        <!-- end footer -->
        <jsp:include page="include-management/js-page.jsp" />
        <!--For Password Validation By JQuery-->
        <script src="<c:url value="/resources-management/others/validationJq/jquery.validate.min.js"/>"></script>
        <script type="text/javascript">
//                For Password Validation By JQuery
            $(function () {
                $.validator.addMethod("notEqualTo", function (value, element) {

                    var NewPassword = $("#newPass").val() || null;

                    if (value === NewPassword)
                    {
                        return true; //Error fire!
                    } else
                    {
                        return false; //Error Not fire!
                    }
                }, "Two Properties are matching");

                $("form[name='validateForm']").validate({
                    errorClass: "error-class",
                    rules: {
                        oldPass: {
                            required: true,
                            minlength: 6
                        },
                        newPass: {
                            required: true,
                            minlength: 6
                        },
                        rePass: {
                            required: true,
                            notEqualTo: true
                        }
                    },
                    messages: {
                        oldPass: {
                            required: "Please enter your Current Password.",
                            minlength: "Your password must be at least 6 characters long."
                        },
                        newPass: {
                            required: "Please enter your New Password.",
                            minlength: "Your password must be at least 6 characters long."
                        },
                        rePass: {
                            required: "Please confirm your New Password.",
                            notEqualTo: "Your Re-Password did not match."
                        }
                    },
                    submitHandler: function (form) {
                        form.submit();
                    }
                });
            });
        </script>
    </body>
</html>    
