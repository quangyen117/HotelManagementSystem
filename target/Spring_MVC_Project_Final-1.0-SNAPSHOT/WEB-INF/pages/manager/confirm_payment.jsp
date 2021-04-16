<%-- 
    Document   : confirm_payment
    Created on : Mar 28, 2021, 8:28:07 PM
    Author     : USER
--%>

<%@page import="com.mycompany.spring_mvc_project_final.entities.ServiceEntity"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
        <!--For DatePicker-->
        <link href="<c:url value="/resources-management/others/datepicker/css/datepicker.css"/>" rel="stylesheet" />
        <style>
            /*For PDF Printing*/
            .printMe {
                display: none;
            }
            @media print {
                .no-printme {
                    display: none;
                }
                .printable {
                    visibility: hidden;
                }
                .printme  {
                    display: block;
                }
            }
            
            .error-class {
                color: red;
            }
        </style>
    </head>
    <body class="page-header-fixed sidemenu-closed-hidelogo page-content-white page-md header-white dark-sidebar-color logo-dark">
        <div class="modal fade" id="cancel-booking" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #FFB64D; padding-bottom: 3px">
                        <p style="font-size: 25px; font-weight: bold">Cancel Booking</p>
                    </div>
                    <div class="modal-body">
                        <p style="font-size: 18px; font-weight:400; text-align: center">Are you sure you want to delete this service?</p>
                    </div>
                    <div class="modal-footer">
                        <a class="btn btn-danger btn-ok">Yes</a>
                        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
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
                                <li class="nav-item start active">
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
                                    <c:if test="${action == 'pay'}">
                                        <div class="page-title">Check-out</div>
                                    </c:if>
                                    <c:if test="${action == 'refund'}">
                                        <div class="page-title">Cancel Booking</div>
                                    </c:if>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/booking" class="parent-item">Booking</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <c:if test="${action == 'pay'}">
                                        <li class="active">Check-out</li>
                                        </c:if>
                                        <c:if test="${action == 'refund'}">
                                        <li class="active">Cancel Booking</li>
                                        </c:if>
                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-12 no-printme">
                                <div class="card card-box">
                                    <div class="card-head">
                                        <header>Booking Information</header>
                                    </div>
                                    <input name="id" type="hidden" value="${booking.id}"/>
                                    <div class="card-body row">
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.fullName}" readonly="">
                                                <label class = "mdl-textfield__label">Full Name</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.gender}" readonly="">
                                                <label class = "mdl-textfield__label">Gender</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "date" id = "txtRoomNo" value="${booking.birthDate}" readonly="">
                                                <label class = "mdl-textfield__label">Birth Date</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.phoneNumber}" readonly="">
                                                <label class = "mdl-textfield__label">Phone Number</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.address}" readonly="">
                                                <label class = "mdl-textfield__label">Address</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.email}" readonly="">
                                                <label class = "mdl-textfield__label">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.idCard}" readonly="">
                                                <label class = "mdl-textfield__label">ID</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.checkIn}" readonly="">
                                                <label class = "mdl-textfield__label">Check-in date</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 p-t-10"> 
                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                <input class = "mdl-textfield__input" type = "text" id = "txtRoomNo" value="${booking.checkOut}" readonly="">
                                                <label class = "mdl-textfield__label">Check-out date</label>
                                            </div>
                                        </div>        
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-12 col-md-12 col-sm-12 col-12 printme">
                                <div class="card card-box">
                                    <div class="card-head no-printme">
                                        <header>Invoice</header>
                                    </div>
                                    <div class="card-body row">
                                        <div class="col-md-12">
                                            <div class="white-box">
                                                <h3><b>INVOICE</b> <span class="pull-right">#${booking.code}</span></h3>
                                                <hr>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="pull-left">
                                                            <img style="float: left; padding-top: 0" src="<c:url value="/resources-management/img/luxury-icon.png"/>" width="12%" alt="logo" class="logo-default" /> <h3 style="padding-left: 60px; margin: 10px; font-weight: bold">Luxury Hotel</h3>
                                                            <address>
                                                                <p class="text-muted m-l-5">
                                                                    100 Vo Nguyen Giap Street, Son Tra District, Danang City, Vietnam <br>
                                                                    Tel: +84 (0)236 392 999, <br> Fax: +84 (0)236 392 998
                                                                </p>
                                                            </address>
                                                        </div>
                                                        <div class="pull-right text-right">
                                                            <address>
                                                                <p class="addr-font-h3">To,</p>
                                                                <p class="font-bold addr-font-h4" style="margin-bottom: 10px">${booking.fullName}</p>
                                                                <p class="text-muted m-l-30" style="margin-bottom: 0">
                                                                    ${booking.address}
                                                                </p>
                                                                <p class="text-muted m-l-30" >
                                                                    Tel: +84 (${fn:substring(booking.phoneNumber, 0, 1)})${fn:substring(booking.phoneNumber, 1, 4)} ${fn:substring(booking.phoneNumber, 4, 7)} ${fn:substring(booking.phoneNumber, 7, fn:length(booking.phoneNumber))}
                                                                </p>
                                                                <p class="m-t-30">
                                                                    <% SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                                                        String invoiceDate = sdf.format(new Date());
                                                                    %>
                                                                    <b>Invoice Date :</b> <i class="fa fa-calendar"></i> <%=invoiceDate%>
                                                                </p>
                                                            </address>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12" style="padding-top: 20px">
                                                        <div class="table-responsive m-t-40" style="padding-bottom: 0px">
                                                            <table class="table table-hover table-bordered">
                                                                <tr>
                                                                    <th class="text-center">Date</th>
                                                                    <th class="text-center">Services</th>
                                                                    <th class="text-center">No. Room</th>
                                                                    <th class="text-center">Charged Amount</th>
                                                                    <th class="text-center">Quantity</th>
                                                                    <th class="text-center" style="width: 20%">Discount</th>
                                                                    <th class="text-right" style="width: 20%">Total Amount</th>
                                                                </tr>
                                                                <c:set var="sbTotal1" value="0"/>
                                                                <c:forEach items="${serviceBookings}" var="sb">
                                                                    <c:if test="${sb.status == 'PAID'}"> 
                                                                        <c:set var="sbTotal1" value="${sbTotal1 + sb.price * sb.quantity * ((100 - 0) / 100)}"/>
                                                                        <tr>
                                                                            <td class="text-center">
                                                                                <fmt:formatDate pattern="dd/MM/yyyy" value="${sb.serviceBookingDate}"/>
                                                                            </td>
                                                                            <td class="text-center">${sb.service.name}</td>
                                                                            <td class="text-center">${sb.bookingDetail.room.roomNumber}</td>
                                                                            <td class="text-center">
                                                                                <fmt:setLocale value="vi_VN" scope="session"/>
                                                                                <fmt:formatNumber type="currency" value="${sb.price}" currencySymbol="VNĐ" />
                                                                            </td>
                                                                            <td class="text-center">${sb.quantity}</td>
                                                                            <td class="text-center">0 (%)</td>
                                                                            <td class="text-right">
                                                                                <fmt:setLocale value="vi_VN" scope="session"/>
                                                                                <fmt:formatNumber type="currency" value="${sb.price * sb.quantity * ((100 - 0) / 100)}" currencySymbol="VNĐ" />
                                                                            </td>
                                                                        </tr>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <tr>
                                                                    <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                    <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                    <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                    <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                    <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                    <td class="text-center" style="font-size: 15px;font-weight: 500">Total</td>
                                                                    <td class="text-right" style="font-size: 15px;font-weight: 500">
                                                                        <fmt:setLocale value="vi_VN" scope="session"/>
                                                                        <fmt:formatNumber type="currency" value="${sbTotal1}" currencySymbol="VNĐ" /></td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12" style="padding-bottom: 40px">
                                                        <div class="table-responsive m-t-40">
                                                            <table class="table table-hover table-bordered">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="text-center">Room Number</th>
                                                                        <th class="text-center">Price Per Night</th>
                                                                        <th class="text-center">Number of Night</th>
                                                                        <th class="text-center" style="width: 20%">Discount</th>
                                                                        <th class="text-right" style="width: 20%">Total Amount</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:set var="bdTotal" value="0"/>
                                                                    <c:forEach items="${bookingDetails}" var="bd">
                                                                        <c:set var="bdTotal" value="${bdTotal + bd.price * days * ((100 - bd.discount) / 100)}"/>
                                                                        <tr>
                                                                            <td class="text-center">${bd.room.roomNumber} (${bd.room.roomType.name})</td>
                                                                            <td class="text-center">
                                                                                <fmt:setLocale value="vi_VN" scope="session"/>
                                                                                <fmt:formatNumber type="currency" value="${bd.price}" currencySymbol="VNĐ" />
                                                                            </td>
                                                                            <td class="text-center">${days}</td>
                                                                            <td class="text-center">${bd.discount} (%)</td>
                                                                            <td class="text-right">
                                                                                <fmt:setLocale value="vi_VN" scope="session"/>
                                                                                <fmt:formatNumber type="currency" value="${bd.price * days * ((100 - bd.discount) / 100)}" currencySymbol="VNĐ" />
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                    <tr>
                                                                        <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                        <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                        <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                        <td class="text-center" style="font-size: 15px;font-weight: 500">Total</td>
                                                                        <td class="text-right " style="font-size: 15px;font-weight: 500">
                                                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                                                            <fmt:formatNumber type="currency" value="${bdTotal}" currencySymbol="VNĐ" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center" style="font-size: 16px;font-weight: 500">Paid Total</td>
                                                                        <td class="text-right " style="font-size: 16px;font-weight: 500">
                                                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                                                            <fmt:formatNumber type="currency" value="${bdTotal + sbTotal1}" currencySymbol="VNĐ" />
                                                                        </td>
                                                                    </tr>
                                                                    <c:if test="${action == 'refund'}">
                                                                        <tr>
                                                                            <td class="text-center border-0 printable"></td>
                                                                            <td class="text-center border-0 printable"></td>
                                                                            <td class="text-center border-0 printable"></td>
                                                                            <td class="text-center" style="font-size: 15px;font-weight: 500">Depreciation Fee (10%)</td>
                                                                            <td class="text-right " style="font-size: 15px;font-weight: 500">
                                                                                <fmt:setLocale value="vi_VN" scope="session"/>
                                                                                <fmt:formatNumber type="currency" value="${(bdTotal + sbTotal1) * 10/100}" currencySymbol="VNĐ" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="text-center border-0 printable"></td>
                                                                            <td class="text-center border-0 printable"></td>
                                                                            <td class="text-center border-0 printable"></td>
                                                                            <td class="text-center" style="font-size: 18px;font-weight: 700">Refunded Total</td>
                                                                            <td class="text-right " style="font-size: 18px;font-weight: 500">
                                                                                <fmt:setLocale value="vi_VN" scope="session"/>
                                                                                <fmt:formatNumber type="currency" value="${(bdTotal + sbTotal1) - (bdTotal + sbTotal1) * 10/100}" currencySymbol="VNĐ" />
                                                                            </td>
                                                                        </tr>
                                                                    </c:if>    
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <c:if test="${action == 'pay'}">                    
                                                        <div class="col-md-12">
                                                            <div class="table-responsive m-t-40">
                                                                <table class="table table-hover table-bordered">
                                                                    <tr>
                                                                        <th class="text-center">Date</th>
                                                                        <th class="text-center">Services</th>
                                                                        <th class="text-center">No. Room</th>
                                                                        <th class="text-center">Charged Amount</th>
                                                                        <th class="text-center">Quantity</th>
                                                                        <th class="text-center" style="width: 20%">Discount</th>
                                                                        <th class="text-right" style="width: 20%">Total Amount</th>
                                                                    </tr>
                                                                    <c:set var="sdTotal2" value="0"/>
                                                                    <c:forEach items="${serviceBookings}" var="sb"> 
                                                                        <c:if test="${sb.status == 'UNPAID'}">
                                                                            <c:set var="sbTotal2" value="${sbTotal2 + sb.price * sb.quantity * ((100 - 0) / 100)}"/>    
                                                                            <tr>
                                                                                <td class="text-center">
                                                                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${sb.serviceBookingDate}"/>
                                                                                </td>
                                                                                <td class="text-center">${sb.service.name}</td>
                                                                                <td class="text-center">${sb.bookingDetail.room.roomNumber}</td>
                                                                                <td class="text-center">
                                                                                    <fmt:setLocale value="vi_VN" scope="session"/>
                                                                                    <fmt:formatNumber type="currency" value="${sb.price}" currencySymbol="VNĐ" />
                                                                                </td>
                                                                                <td class="text-center">${sb.quantity}</td>
                                                                                <td class="text-center">0 (%)</td>
                                                                                <td class="text-right">
                                                                                    <fmt:setLocale value="vi_VN" scope="session"/>
                                                                                    <fmt:formatNumber type="currency" value="${sb.price * sb.quantity * ((100 - 0) / 100)}" currencySymbol="VNĐ" />
                                                                                </td>
                                                                            </tr>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    <tr>
                                                                        <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                        <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                        <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                        <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                        <td class="text-center border-left-0 border-right-0 border-bottom-0 printable"></td>
                                                                        <td class="text-center" style="font-size: 15px;font-weight: 500">Total</td>
                                                                        <td class="text-right " style="font-size: 15px;font-weight: 500">
                                                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                                                            <fmt:formatNumber type="currency" value="${sbTotal2}" currencySymbol="VNĐ" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center" style="font-size: 15px;font-weight: 500">Tax (10%)</td>
                                                                        <td class="text-right " style="font-size: 15px;font-weight: 500">
                                                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                                                            <fmt:formatNumber type="currency" value="${sbTotal2 * 0.1}" currencySymbol="VNĐ" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center" style="font-size: 15px;font-weight: 500">Service Charge (5%)</td>
                                                                        <td class="text-right printme" style="font-size: 15px;font-weight: 500">
                                                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                                                            <fmt:formatNumber type="currency" value="${sbTotal2 * 0.05}" currencySymbol="VNĐ" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center" style="font-size: 16px;font-weight: 500">Paid Total</td>
                                                                        <td class="text-right " style="font-size: 16px;font-weight: 500">
                                                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                                                            <fmt:formatNumber type="currency" value="${sbTotal1 + bdTotal}" currencySymbol="VNĐ" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center border-0 printable"></td>
                                                                        <td class="text-center" style="font-size: 20px;font-weight: 900">Total</td>
                                                                        <td class="text-right " style="font-size: 20px;font-weight: 500">
                                                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                                                            <fmt:formatNumber type="currency" value="${sbTotal2 + sbTotal2 * 0.1 + sbTotal2 * 0.05}" currencySymbol="VNĐ" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </c:if>                
                                                    <div class="col-md-12 no-printme">
                                                        <hr>
                                                        <div>
                                                            
                                                            <form action="${pageContext.request.contextPath}/booking/complete-booking/${action}" method="get">
                                                                <input name="action" value="${action}" type="text" hidden="">
                                                                <input name="bookingId" value="${booking.id}" type="text" hidden="">
                                                                <button class="btn btn-primary" style="position: absolute; right: 200px;" type="submit">
                                                                    <c:if test="${action == 'pay'}">
                                                                        Check-out Confirmation
                                                                    </c:if>    
                                                                    <c:if test="${action == 'refund'}">
                                                                        Cancel Confirmation
                                                                    </c:if> 
                                                                </button>
                                                            </form>
                                                            <button onclick="javascript:window.print();" class="btn btn-default btn-outline" style="position: absolute; right: 100px;" type="button"> <span><i class="fa fa-print"></i> Print</span> </button>
                                                            <a class="btn btn-primary" style="position: absolute; right: 0;" href="<c:url value="/booking" />">Return</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="no-printme col-lg-12 col-md-12 col-sm-12 col-12 " >
                                <div class="card-box">
                                    <div class="card-head">
                                        <c:if test="${action == 'pay'}">
                                            <header>Paying</header>
                                            </c:if>    
                                            <c:if test="${action == 'refund'}">
                                            <header>Refund</header>
                                            </c:if>
                                    </div>
                                    <c:if test="${mesType == 'y'}">
                                        <div class="row">
                                             <div class="col-md-12 col-lg-12 text-center">
                                                <div class="alert alert-success" role="alert">
                                                    <p style="font-size: 20px">${mes}</p>
                                                </div>
                                             </div>      
                                        </div>
                                    </c:if>            
                                    <mvc:form action="${pageContext.request.contextPath}/booking/payment/${action}" method="post" name="validateForm" modelAttribute="creditCard">
                                        <div class="card-body row">
                                            <div class="col-md-12">
                                                <div class="white-box"> 
                                                    <input name="action" value="${action}" type="text" hidden="">
                                                    <c:if test="${action == 'pay'}">
                                                        <input name="totalPrice" value="${sbTotal2 + sbTotal2 * 0.1 + sbTotal2 * 0.05}" type="text" hidden="">
                                                    </c:if>
                                                    <c:if test="${action == 'refund'}">
                                                        <input name="totalPrice"  value="${(sbTotal1 + bdTotal) * 90/100}" type="text" hidden="">
                                                    </c:if>
                                                    <input name="bookingId" value="${booking.id}" type="text" hidden="">
                                                    <div class="row">
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class="form-group">
                                                                <label>Card Number</label>
                                                                <input type="text" class="form-control" name="cardNumber" >
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class="form-group">
                                                                <label>Name</label>
                                                                <input type="text" class="form-control" name="name" >
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class="form-group">
                                                                <label style="display: block">Exp Date</label> 
                                                                <select class="form-control" name="monthExp" id="monthExp" style="width: 49%; display: inline">
                                                                    <option value="01">01</option>
                                                                    <option value="02">02</option>
                                                                    <option value="03">03</option>
                                                                    <option value="04">04</option>
                                                                    <option value="05">05</option>
                                                                    <option value="06">06</option>
                                                                    <option value="07">07</option>
                                                                    <option value="08">08</option>
                                                                    <option value="09">09</option>
                                                                    <option value="10">10</option>
                                                                    <option value="11">11</option>
                                                                    <option value="12">12</option>
                                                                </select>
                                                                <select class="form-control"  name="yearExp" id="yearExp" style="width: 50%; display: inline" >
                                                                    <option value="2021">2021</option>
                                                                    <option value="2022">2022</option>
                                                                    <option value="2023">2023</option>
                                                                    <option value="2024">2024</option>
                                                                    <option value="2025">2025</option>
                                                                    <option value="2026">2026</option>
                                                                    <option value="2027">2027</option>
                                                                    <option value="2027">2027</option>
                                                                    <option value="2027">2027</option>
                                                                    <option value="2027">2027</option>
                                                                    <option value="2028">2028</option>
                                                                    <option value="2029">2029</option>
                                                                    <option value="2030">2030</option>
                                                                    <option value="2031">2031</option>
                                                                    <option value="2032">2032</option>
                                                                    <option value="2033">2033</option>
                                                                    <option value="2034">2034</option>
                                                                    <option value="2035">2035</option>
                                                                    <option value="2036">2036</option>
                                                                    <option value="2037">2037</option>
                                                                    <option value="2038">2038</option>
                                                                    <option value="2039">2039</option>
                                                                    <option value="2040">2040</option>
                                                                    <option value="2041">2041</option>
                                                                    <option value="2042">2042</option>
                                                                    <option value="2043">2043</option>
                                                                    <option value="2044">2044</option>
                                                                    <option value="2045">2045</option>
                                                                    <option value="2046">2046</option>
                                                                    <option value="2047">2047</option>
                                                                    <option value="2048">2048</option>
                                                                    <option value="2049">2049</option>
                                                                    <option value="2050">2050</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class="form-group">
                                                                <label>Code</label> 
                                                                <input type="text" class="form-control" data-mask="999" name="cvcCode">
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 p-t-20 text-center">
                                                            <div class="form-group">
                                                                <c:if test="${mesType == 'n'}">
                                                                    <div class="alert alert-danger" role="alert">
                                                                        <p style="font-size: 15px">${mes}</p>
                                                                    </div>
                                                                </c:if>   
                                                                <button class="btn btn-success" type="submit">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>    
                                        </div>
                                    </mvc:form>                
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
        <script>
            //      For Delete Confirmation Message
            $('#delete-service').on('show.bs.modal', function (e) {
                $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));

                $('.debug-url').html('Delete URL: <strong>' + $(this).find('.btn-ok').attr('href') + '</strong>');
            });
            $('#cancel-booking').on('show.bs.modal', function (e) {
                $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));

                $('.debug-url').html('Delete URL: <strong>' + $(this).find('.btn-ok').attr('href') + '</strong>');
            });
        </script>
        <script>
            //       For Checkboxes Dropdown
            $(".checkbox-menu").on("change", "input[type='checkbox']", function () {
                $(this).closest("li").toggleClass("active", this.checked);
            });

            $(document).on('click', '.allow-focus', function (e) {
                e.stopPropagation();
            });
        </script>
        <script src="<c:url value="/resources-management/others/validationJq/jquery.validate.min.js"/>"></script>
        <script type="text/javascript">
//                For Password Validation By JQuery
            $(function () {
                $("form[name='validateForm']").validate({
                    errorClass: "error-class",
                    rules: {
                        cardNumber: {
                            required: true,
                            minlength: 6
                        },
                        name: {
                            required: true
                        },
                        cvcCode: {
                            required: true
                        }
                    }, 
                    messages: {
                        cardNumber: {
                            required: "Please enter your card number",
                            minlength: "Your password must be at least 6 characters long."
                        },
                        name: {
                            required: "Please enter your name"
                        },
                        cvcCode: {
                            required: "Please enter your cvc code"
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

