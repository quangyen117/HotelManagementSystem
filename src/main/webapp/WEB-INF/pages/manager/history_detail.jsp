<%-- 
    Document   : history_detail
    Created on : Mar 29, 2021, 11:13:24 AM
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
        <jsp:include page="../include-management/css-page.jsp" />
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
                                <li class="nav-item active">
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
                                        <li class="nav-item active">	
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
                                    <div class="page-title">History Detail</div>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li class="active">History Detail</li>
                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-12 no-printme">
                                <div class="card card-box">
                                    <div class="card-head">
                                        <header>History Detail Information</header>
                                    </div>
                                    <div class="card-body row">
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.fullName}" readonly="">
                                                <label class = "mdl-textfield__label">Full Name</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.gender}" readonly="">
                                                <label class = "mdl-textfield__label">Gender</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "date" id = "txtRoomNo" value="${booking.birthDate}" readonly="">
                                                <label class = "mdl-textfield__label">Birth Date</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.phoneNumber}" readonly="">
                                                <label class = "mdl-textfield__label">Phone Number</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.address}" readonly="">
                                                <label class = "mdl-textfield__label">Address</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.email}" readonly="">
                                                <label class = "mdl-textfield__label">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.idCard}" readonly="">
                                                <label class = "mdl-textfield__label">ID</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.bookingDate}" readonly="">
                                                <label class = "mdl-textfield__label">Booking Date</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.checkIn}" readonly="">
                                                <label class = "mdl-textfield__label">Check-in date</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.checkOut}" readonly="">
                                                <label class = "mdl-textfield__label">Check-out date</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.status}" readonly="">
                                                <label class = "mdl-textfield__label">Status</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <c:if test="${booking.status == 'COMPLETED'}">
                                                    <label class = "mdl-textfield__label" style="position: absolute; top: 3px">Paid Total</label>
                                                    <div class ="mdl-textfield" style="position: absolute; top: 4px; border-bottom: #AAAAAA 1px solid; padding-bottom: 5px">
                                                        <fmt:setLocale value="vi_VN" scope="session"/>
                                                        <fmt:formatNumber type="currency" value="${booking.totalPrice}" currencySymbol="VNĐ" />
                                                    </div>
                                                </c:if>
                                                <c:if test="${booking.status == 'CANCEL'}">
                                                    <label class = "mdl-textfield__label" style="position: absolute; top: 3px">Refunded Total</label>
                                                    <div class ="mdl-textfield" style="position: absolute; top: 4px; border-bottom: #AAAAAA 1px solid; padding-bottom: 5px">
                                                        <fmt:setLocale value="vi_VN" scope="session"/>
                                                        <fmt:formatNumber type="currency" value="${booking.totalPrice * 0.9}" currencySymbol="VNĐ" />
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>      
                                        <div class="col-lg-6 p-t-10">
                                            <p style="font-size: 17px; font-weight: bold">Room Info</p>
                                            <div class="table-responsive m-t-40">
                                                <table class="table table-hover table-bordered">
                                                    <tr>
                                                        <th class="text-center" style="font-size: 15px; font-weight: 600">Room Number</th>
                                                        <th class="text-center" style="font-size: 15px; font-weight: 600">Room Type</th>
                                                        <th class="text-center" style="font-size: 15px; font-weight: 600">Number of Night</th>
                                                    </tr>
                                                    <c:set var="bdTotal" value="0"/>
                                                    <c:forEach items="${bookingDetails}" var="bd">
                                                        <c:set var="bdTotal" value="${bdTotal + bd.price * days * ((100 - bd.discount) / 100)}"/>
                                                        <tr>
                                                            <td class="text-center">${bd.room.roomNumber}</td>
                                                            <td class="text-center">${bd.room.roomType.name}</td>
                                                            <td class="text-center">${days}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </div>            
                                        <div class="col-lg-6 p-t-10">
                                            <p style="font-size: 17px; font-weight: bold">Services</p>
                                            <div class="table-responsive m-t-40">
                                                <table class="table table-hover table-bordered">
                                                    <tr>
                                                        <th class="text-center" style="font-size: 15px; font-weight: 600">Date</th>
                                                        <th class="text-center" style="font-size: 15px; font-weight: 600">Services</th>
                                                        <th class="text-center" style="font-size: 15px; font-weight: 600">No. Room</th>
                                                        <th class="text-center" style="font-size: 15px; font-weight: 600">Quantity</th>
                                                    </tr>
                                                    <c:forEach items="${serviceBookings}" var="sb">
                                                        <c:if test="${sb.status == 'PAID'}">
                                                            <tr>
                                                                <td class="text-center">
                                                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${sb.serviceBookingDate}"/>
                                                                </td>
                                                                <td class="text-center">${sb.service.name}</td>
                                                                <td class="text-center">${sb.bookingDetail.room.roomNumber}</td>
                                                                <td class="text-center">${sb.quantity}</td>
                                                            </tr>
                                                        </c:if> 
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p-t-10 text-right">
                                            
                                        </div>
                                        <div class="col-lg-6 p-t-10 text-right">
                                            <a class="btn btn-primary"  href="<c:url value="/information/booking-history" />">Return</a>         
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>                            
                    </div>
                </div>                                
            </div>
        </div>
        <!-- end page content -->                                
        <!-- start footer -->
        <jsp:include page="../include-management/footer.jsp" />
        <!-- end footer -->
        <jsp:include page="../include-management/js-page.jsp" />
    </body>
</html>
