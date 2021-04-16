
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
                    visibility: hidden

                        .printme  {
                        display: block;
                    }
                }
            }    
            /*For Dropdown checkboxes select*/
            .checkbox-menu li label {
                display: block;
                padding: 3px 10px;
                clear: both;
                font-weight: normal;
                line-height: 1.42857143;
                color: #333;
                white-space: nowrap;
                margin:0;
                transition: background-color .4s ease;
            }
            .checkbox-menu li input {
                margin: 0px 5px;
                top: 2px;
                position: relative;
            }

            .checkbox-menu li.active label {
                background-color: #cbcbff;
                font-weight:bold;
            }

            .checkbox-menu li label:hover,
            .checkbox-menu li label:focus {
                background-color: #f5f5f5;
            }

            .checkbox-menu li.active label:hover,
            .checkbox-menu li.active label:focus {
                background-color: #b8b8ff;
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
        <div class="modal fade" id="delete-service" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #FFB64D; padding-bottom: 3px">
                        <p style="font-size: 25px; font-weight: bold">Delete Service</p>
                    </div>
                    <div class="modal-body">                                                                                                           <p style="font-size: 18px; font-weight:400; text-align: center">Are you sure you want to delete this service?</p>
                    </div>
                    <div class="modal-footer">
                        <a class="btn btn-danger btn-ok">Delete</a>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="message-info" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #F44336; padding-bottom: 3px">
                        <p style="font-size: 25px; font-weight: bold">Cancel Booking</p>
                    </div>
                    <div class="modal-body">
                        <p style="font-size: 18px; font-weight:400; text-align: center">This booking can not cancel anymore</p><p style="font-size: 15px; font-weight:400; text-align: center">It must be canceled 3 days before the check-in date</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
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
                                    <div class="page-title">Booking Detail</div>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/booking" class="parent-item">Booking</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <li class="active">Booking Detail</li>
                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-12 no-printme">
                                <div class="card card-box">
                                    <div class="card-head">
                                        <header>Customer Info</header>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/booking/change-status" method="post" >
                                        <input name="id" type="hidden" value="${booking.id}"/>
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
                                                <div class="form-group">
                                                    <label style="font-size: 13px; color: #AAAAAA">Status</label>
                                                    <select name="status" class="form-control" style="width: 75%; position: absolute; top: 37px;">
                                                        <c:forEach items="${statuses}" var="s">
                                                            <c:if test="${booking.status == s}">
                                                                <option value="${s}" selected="">${s}</option>
                                                            </c:if>
                                                            <c:if test="${booking.status != s}">
                                                                <option value="${s}" >${s}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                    <button type="submit" style="position: absolute; right: 14px; top: 35px" class="btn btn-success">Change</button>
                                                </div>
                                            </div>        
                                        </div>
                                    </form>
                                </div>
                            </div> 
                            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="card card-box">
                                    <div class="card-head">
                                        <header>Booking Detail</header>
                                    </div>
                                    <div class="card-body row">
                                        <div class="col-md-12">
                                            <div class="white-box">
                                                <div class="row">
                                                    <div class="col-md-4"> 
                                                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                            <input class="mdl-textfield__input" type="date" id="txtRoomNo" value="${booking.checkIn}" readonly="">
                                                            <label class="mdl-textfield__label">Check-In Date</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4"> 
                                                        <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                            <input class ="mdl-textfield__input" type="date" id="txtRoomNo" value="${booking.checkOut}" readonly="">
                                                            <label class="mdl-textfield__label">Check-Out Date</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4"> 
                                                        <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                            <label class="mdl-textfield__label" style="position: absolute; top: 3px">Total Paid Amount</label>
                                                            <div class ="mdl-textfield" style="position: absolute; top: 4px; border-bottom: #AAAAAA 1px solid; padding-bottom: 5px">
                                                                <fmt:setLocale value="vi_VN" scope="session"/>
                                                                <fmt:formatNumber type="currency" value="${booking.totalPrice}" currencySymbol="VNĐ" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
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
                                                    <div class="col-md-6"> 
                                                        <p style="font-size: 17px; font-weight: bold">Service Includes</p>
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
                                                    <div class="col-md-12">
                                                        <hr>
                                                        <div>
                                                            <button class="btn btn-warning" style="position: absolute; left: 0;" onclick="myFunc()">Add Service</button>
                                                            <c:if test="${check >= 3 }">
                                                                <button class="btn btn-danger" style="position: absolute; right: 300px;" data-href="<c:url value="/booking/cancel-booking/${booking.id}"/>" data-toggle="modal" data-target="#cancel-booking">Cancel Booking</button>
                                                            </c:if>
                                                            <c:if test="${check < 3 || check == 1}">
                                                                <button class="btn btn-danger" style="position: absolute; right: 300px;" data-toggle="modal" data-target="#message-info">Cancel Booking</button>
                                                            </c:if>
                                                            <a class="btn btn-info" style="position: absolute; right: 100px;" href="<c:url value="/booking/confirm-payment/${booking.id}" />"> Proceed to Check-Out </a>
                                                            <a class="btn btn-primary" style="position: absolute; right: 0;" href="<c:url value="/booking" />">Return</a>
                                                        </div>
                                                    </div>                
                                                </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-12 no-printme" id="myDiv" style="display: none">
                                <div class="card-box">
                                    <div class="card-head">
                                        <header>Add Service</header>
                                    </div>
                                    <div class="card-body row">
                                        <div class="col-md-12">
                                            <div class="white-box">
                                                <div class="row">
                                                    <div class="col-lg-11">
                                                        <div class="table-responsive">
                                                            <p style="font-size: 17px; font-weight: bold">New Service</p>
                                                            <table class="table table-hover table-bordered">
                                                                <tr>
                                                                    <th class="text-center" style="font-size: 15px; font-weight: 600">Date</th>
                                                                    <th class="text-center" style="font-size: 15px; font-weight: 600">Services</th>
                                                                    <th class="text-center" style="font-size: 15px; font-weight: 600">No. Room</th>
                                                                    <th class="text-center" style="font-size: 15px; font-weight: 600">Quantity</th>
                                                                    <th class="text-center" style="font-size: 15px; font-weight: 600">Action</th>
                                                                </tr>
                                                                <c:set var="sbTotal" value="0"/>
                                                                <c:forEach items="${serviceBookings}" var="sb"> 
                                                                    <c:set var="sbTotal" value="${sbTotal + sb.price * sb.quantity * ((100 - 0) / 100)}"/>
                                                                    <c:if test="${sb.status == 'UNPAID'}">
                                                                        <tr>
                                                                            <td class="text-center">
                                                                                <fmt:formatDate pattern="dd/MM/yyyy" value="${sb.serviceBookingDate}"/>
                                                                            </td>
                                                                            <td class="text-center">${sb.service.name}</td>
                                                                            <td class="text-center">${sb.bookingDetail.room.roomNumber}</td>
                                                                            <td class="text-center">${sb.quantity}</td>
                                                                            <td class="text-center">
                                                                                <button class="btn btn-danger" data-href="<c:url value="/booking/delete-service/${sb.id}/${booking.id}"/>" data-toggle="modal" data-target="#delete-service">Delete
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </c:if> 
                                                                </c:forEach>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <hr/>
                                                <mvc:form action="${pageContext.request.contextPath}/booking/add-service" method="post" modelAttribute="bookingDetail">
                                                    <div class="row">
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class="form-group">
                                                                <label>Booking Date</label>
                                                                <input autocomplete="off" type="text" class="form-control" id="bookingDate" name="serviceBookingDate" >
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class="form-group">
                                                                <label>Services</label>
                                                                <div class="dropdown">
                                                                    <button class="form-control dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="anchor">Select</span></button>
                                                                    <ul class="dropdown-menu checkbox-menu allow-focus" aria-labelledby="dropdownMenu1">
                                                                        <c:forEach items="${services}" var="s" >
                                                                            <li>
                                                                                <label><input name="serviceIds" id="checkboxbg1" type="checkbox" value="${s.id}"/> ${s.name} (<fmt:setLocale value="vi_VN" scope="session"/><fmt:formatNumber type="currency" value="${s.price}" currencySymbol="VNĐ" />)</label>
                                                                            </li>
                                                                        </c:forEach>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class="form-group">
                                                                <label>Quantity</label>
                                                                <div class="input-group spinner">
                                                                    <span class="input-group-btn">
                                                                        <button class="btn btn-default" data-dir="dwn" type="button">
                                                                            <span class="fa fa-minus"></span>
                                                                        </button>
                                                                    </span>
                                                                    <input type="number" name="quantity" class="form-control text-center" value="1" min="1" max="5"> <span class="input-group-btn">
                                                                        <button class="btn btn-default" data-dir="up" type="button">
                                                                            <span class="fa fa-plus"></span>
                                                                        </button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class="form-group">
                                                                <label>Room Number</label>
                                                                <select name="bookingDetailId" class="form-control">
                                                                    <c:forEach items="${bookingDetails}" var="bd">
                                                                        <option value="${bd.id}"/>${bd.room.roomNumber}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>                
                                                        <div class="col-lg-6 p-t-20 text-center">
                                                            <div class="form-group">
                                                                <button type="submit" class="btn btn-success">Submit</button>
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
                </div>                                
            </div>
        </div>
        <!-- end page content -->                                
        <!-- start footer -->
        <jsp:include page="../include-management/footer.jsp" />
        <!-- end footer -->
        <jsp:include page="../include-management/js-page.jsp" />
        <!--For Date Picker and Range Picker-->
        <script src="<c:url value="/resources-management/others/datepicker/js/bootstrap-datepicker.js"/>"></script>
        <script>
//          For Add Service Div
            function myFunc() {
                var x = document.getElementById("myDiv");
                if (x.style.display === "none") {
                    x.style.display = "block";
                } else {
                    x.style.display = "none";
                }
            }
        </script>
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
    //                For Checkboxes Dropdown
            $(".checkbox-menu").on("change", "input[type='checkbox']", function () {
                $(this).closest("li").toggleClass("active", this.checked);
            });

            $(document).on('click', '.allow-focus', function (e) {
                e.stopPropagation();
            });
        </script>
        <script>
    //                For Date Picker and Range Picker
            $(function () {
                'use strict';
                var nowTemp = new Date();
                var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

                var checkin = $('#bookingDate').datepicker({
                    onRender: function (date) {
                        return date.valueOf() < now.valueOf() ? 'disabled' : '';
                    }
                }).on('changeDate', function (ev) {
                    checkin.hide();
                }).data('datepicker');
            });
        </script>
    </body>
</html>