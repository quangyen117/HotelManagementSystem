<%-- 
    Document   : add-room
    Created on : Feb 24, 2021, 9:29:33 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        <jsp:include page="../include-management/css-page.jsp" />
        <style>
            .error-class {
                color: red;
            }
        </style>
    </head>
    <body class="page-header-fixed sidemenu-closed-hidelogo page-content-white page-md header-white dark-sidebar-color logo-dark">
        <div class="page-wrapper">
            <jsp:include page="../include-management/header.jsp" />
            <!-- start page container -->	
            <div class="page-container">	
                <!-- start sidebar menu -->	
                <div class="sidebar-container">	
                    <div class="sidemenu-container navbar-collapse collapse fixed-menu">	
                        <div id="remove-scroll">	
                            <ul class="sidemenu page-header-fixed p-t-20" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">	
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
                                            <a class="tooltips" href="${pageContext.request.contextPath}/userProfile" data-placement="top" data-original-title="Profile">	
                                                <i class="material-icons">person_outline</i>	
                                            </a>	
                                            <a class="tooltips" href="${pageContext.request.contextPath}/logout" data-placement="top" data-original-title="Logout">	
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
                                                <i class="fa fa-users"></i> View Accounts</a>
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
                                <li class="nav-item active">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <i class="material-icons">settings</i>
                                        <span class="title">Hotel Management</span>
                                        <span class="arrow "></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item">
                                            <a href="javascript:;" class="nav-link nav-toggle">
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
                                        <li class="nav-item active">
                                            <a href="javascript:;" class="nav-link nav-toggle">
                                                <i class="fa fa-plus"></i> Rooms
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <c:if test="${action == 'add'}">
                                                    <li class="nav-item">
                                                        <a href="${pageContext.request.contextPath}/hotelManagement/room/view-room" class="nav-link">
                                                            <i class="fa fa-minus"></i> View Rooms</a>
                                                    </li>
                                                    <li class="nav-item active">
                                                        <a href="${pageContext.request.contextPath}/hotelManagement/room/add-room" class="nav-link">
                                                            <i class="fa fa-minus"></i> New Room</a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${action == 'edit'}">
                                                    <li class="nav-item active">
                                                        <a href="${pageContext.request.contextPath}/hotelManagement/room/view-room" class="nav-link">
                                                            <i class="fa fa-minus"></i> View Rooms</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a href="${pageContext.request.contextPath}/hotelManagement/room/add-room" class="nav-link">
                                                            <i class="fa fa-minus"></i> New Room</a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </li>
                                        <li class="nav-item">
                                            <a href="javascript:;" class="nav-link nav-toggle">
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
                                            <a href="javascript:;" class="nav-link nav-toggle">
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
                                    <c:if test="${action == 'add'}">
                                        <div class="page-title">New Room</div>
                                    </c:if>
                                    <c:if test="${action == 'edit'}">    
                                        <div class="page-title">Edit Room</div>
                                    </c:if>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li>
                                        <a class="parent-item" >Hotel Management</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <li><a class="parent-item" >Rooms</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <c:if test="${action == 'add'}">
                                        <li class="active">New Room</li>
                                    </c:if>
                                    <c:if test="${action == 'edit'}">
                                        <li class="active">Edit Room</li>
                                    </c:if>
                                </ol>
                            </div>
                        </div>
                        <mvc:form action="${pageContext.request.contextPath}/hotelManagement/room/${action}" method="post" modelAttribute="room" name="validateForm" >
                            <input name="action" type="text" value="${action}" hidden/>
                            <c:if test="${action == 'edit'}">
                                <input name="id" type="hidden" value="${room.id}"/>
                            </c:if>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-box">
                                        <div class="card-head">
                                            <c:if test="${action == 'add'}">
                                                <header>New Room</header>
                                                </c:if>
                                                <c:if test="${action == 'edit'}">
                                                <header>Edit Room</header>
                                                </c:if>
                                        </div>    
                                        <div class="card-body row">
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="roomNId">Room Number</label>
                                                    <input type="text" id="roomNId" class="form-control" name="roomNumber" value="${room.roomNumber}">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="priceId">Price</label>
                                                    <input type="text" id="priceId" class="form-control" name="price" value="${room.price}">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label>Room Type</label>
                                                    <select name="roomType.id" class="form-control">
                                                        <c:forEach var="rts" items="${roomTypes}">
                                                            <c:if test="${room.roomType.id == rts.id}">
                                                                <option value="${rts.id}" selected="">${rts.name}</option>
                                                            </c:if>
                                                            <c:if test="${room.roomType.id != rts.id}">
                                                                <option value="${rts.id}">${rts.name}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>        
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label>Status</label>
                                                    <select name="status" class="form-control">
                                                        <c:forEach items="${statuses}" var="s">
                                                            <c:if test="${room.status == s}">
                                                                <option value="${s}" selected="">${s}</option>
                                                            </c:if>
                                                            <c:if test="${room.status != s}">
                                                                <option value="${s}">${s}</option>
                                                            </c:if>    
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="nobId">Number of Bed</label>
                                                    <input type="text" id="nobId" class="form-control" name="numberOfBed" value="${room.numberOfBed}">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    
                                                </div>
                                            </div>    
                                            <div class="col-lg-6 p-t-20 text-center">
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-success">Submit</button>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20 text-center">
                                                <div class="form-group">
                                                    <a class="btn btn-primary" href="<c:url value="/hotelManagement/room/view-room" />">Return</a>
                                                </div>
                                            </div>     
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </mvc:form>
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
                    </div>
                    <!-- end page content -->
                </div>
                <!-- end page container -->
                <!-- start footer -->
                <jsp:include page="../include-management/footer.jsp" />
                <!-- end footer -->
            </div>
            <jsp:include page="../include-management/js-page.jsp" />
            <script src="<c:url value="/resources-management/others/validationJq/jquery.validate.min.js"/>"></script>
            <script type="text/javascript">
//                For Password Validation By JQuery
                $(function () {
                    $("form[name='validateForm']").validate({
                        errorClass: "error-class",
                        rules: {
                            roomNumber: {
                                required: true
                            },
                            price: {
                                required: true,
                                number: true
                            },
                            numberOfBed: {
                                required: true,
                                number: true
                            }
                        },
                        messages: {
                            roomNumber: {
                                required: "Please enter your room number"
                            },
                            price: {
                                required: "Please enter your price",
                                number: "Please enter numbers"
                            },
                            numberOfBed: {
                                required: "Please enter your number of bed",
                                number: "Please enter numbers"
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
