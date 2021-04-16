<%-- 
    Document   : all_accounts
    Created on : Mar 25, 2021, 3:24:33 PM
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
                                <li class="nav-item active">
                                    <a class="nav-link nav-toggle">
                                        <i class="fa fa-user-circle"></i> 
                                        <span class="title">Account</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <c:if test="${action == 'view'}">
                                            <li class="nav-item active">
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
                                        </c:if>
                                        <c:if test="${action == 'changePass'}">
                                            <li class="nav-item">
                                                <a href="${pageContext.request.contextPath}/account/view-account" class="nav-link">
                                                    <i class="fa fa-group"></i> View Accounts</a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="${pageContext.request.contextPath}/account/add-account" class="nav-link">
                                                    <i class="fa fa-user-plus"></i> New Account</a>
                                            </li>
                                            <li class="nav-item active">
                                                <a href="${pageContext.request.contextPath}/account/change-password" class="nav-link">
                                                    <i class="fa fa-retweet"></i> Change Password</a>
                                            </li>
                                        </c:if>    
                                    </ul>
                                </li>
                                </sec:authorize>
                                <sec:authorize access="hasAnyRole('ROLE_MANAGER')">
                                <li class="nav-item ">
                                    <a href="javascript:;" class="nav-link nav-toggle">
                                        <i class="material-icons">settings</i>
                                        <span class="title">Hotel Management</span>
                                        <span class="arrow "></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="nav-item ">
                                            <a href="javascript:;" class="nav-link nav-toggle">
                                                <i class="fa fa-plus"></i> Room Types
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li class="nav-item ">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/room-type/view-room-type" class="nav-link">
                                                        <i class="fa fa-minus"></i> View Room Types</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/hotelManagement/room-type/add-room-type" class="nav-link">
                                                        <i class="fa fa-minus"></i> New Room Type</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="nav-item ">
                                            <a href="javascript:;" class="nav-link nav-toggle">
                                                <i class="fa fa fa-plus"></i> Rooms
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li class="nav-item ">
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
                                            <a href="javascript:;" class="nav-link nav-toggle">
                                                <i class="fa fa fa-plus"></i> Services
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
                                        <li class="nav-item ">
                                            <a href="javascript:;" class="nav-link nav-toggle">
                                                <i class="fa fa fa-plus"></i> Promotions
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <li class="nav-item ">
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
                                    <c:if test="${action == 'view'}">
                                        <div class="page-title">View Accounts</div>
                                    </c:if>
                                    <c:if test="${action == 'changePass'}">
                                        <div class="page-title">Change Password</div>
                                    </c:if>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li>
                                        <a class="parent-item">Account</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <c:if test="${action == 'view'}">
                                        <li class="active">View Accounts</li>
                                    </c:if>
                                    <c:if test="${action == 'changePass'}">
                                        <li class="active">Change Password</li>
                                    </c:if>
                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card card-box">
                                    <div class="card-head">
                                        <c:if test="${action == 'view'}">
                                            <header>View Accounts</header>
                                        </c:if>
                                        <c:if test="${action == 'changePass'}">
                                            <header>Change Password</header>
                                        </c:if>
                                    </div>
                                    <div class="card-body ">
                                        <c:if test="${action == 'view'}">
                                            <div class="row p-b-20">
                                                <div class="col-md-6 col-sm-6 col-6">
                                                    <div class="btn-group">
                                                        <a href="${pageContext.request.contextPath}/account/add-account" id="addRow" class="btn btn-info">
                                                            Add New <i class="fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-sm-6 col-6">

                                                </div>
                                            </div>
                                        </c:if>
                                        <div class="table-scrollable">
                                            <table class="table table-hover table-checkable order-column full-width" id="example">
                                                <thead>
                                                    <tr>
                                                        <th class="center"> Full Name </th>
                                                        <th class="center"> Email </th>
                                                        <th class=""> Role </th>
                                                        <c:if test="${action == 'view'}">
                                                            <th class="center"> Gender </th>
                                                            <th class="center"> Phone Number </th>
                                                        </c:if>
                                                        <th class="center"> Status </th>
                                                        <th class="center"> Action </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${accounts}" var="as">
                                                        <tr class="odd gradeX">
                                                            <td class="center" style="width: 15%">${as.fullName}</td>
                                                            <td class="center">${as.email}</td>
                                                            <td class="">
                                                                <c:if test="${userService.getAccRoleNamesByAccountId(as.id) == '[ROLE_USER]'}">
                                                                    USER
                                                                </c:if>
                                                                <c:if test="${userService.getAccRoleNamesByAccountId(as.id) == '[ROLE_ADMIN]'}">
                                                                    ADMIN
                                                                </c:if>
                                                                <c:if test="${userService.getAccRoleNamesByAccountId(as.id) == '[ROLE_RECEPTIONIST]'}">
                                                                    RECEPTIONIST
                                                                </c:if>
                                                                <c:if test="${userService.getAccRoleNamesByAccountId(as.id) == '[ROLE_MANAGER]'}">
                                                                    MANAGER
                                                                </c:if>    
                                                            </td>
                                                            <c:if test="${action == 'view'}">
                                                                <td class="center">${as.gender}</td>
                                                                <td class="center">${as.phoneNumber}</td>
                                                            </c:if>
                                                            <td class="center">
                                                                <c:if test="${as.status == 'ACTIVE'}">
                                                                    <span class="label label-sm label-success">${as.status}</span>
                                                                </c:if>
                                                                <c:if test="${as.status == 'BLOCKED'}">
                                                                    <span class="label label-sm label-danger">${as.status}</span>
                                                                </c:if>
                                                                <c:if test="${as.status == 'UNACTIVE'}">
                                                                    <span class="label label-sm label-secondary">${as.status}</span>
                                                                </c:if>    
                                                            </td>
                                                            <td class="center">
                                                                <c:if test="${action == 'view'}">
                                                                    <a href="${pageContext.request.contextPath}/account/edit-account/${as.id}" class="btn btn-primary">Edit</a>
                                                                    <a href="${pageContext.request.contextPath}/account/change-status/${as.id}" class="btn btn-success"><i class="fa fa-repeat"></i> Status</a>
                                                                </c:if>
                                                                <c:if test="${action == 'changePass'}">
                                                                    <a href="${pageContext.request.contextPath}/account/change-password/${as.id}" class="btn btn-dark">Change</a>
                                                                </c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
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
            </div>
            <jsp:include page="../include-management/js-page.jsp" />
            <script>
                $(document).ready(function () {
                    var groupColumn = 2;
                    var table = $('#example').DataTable({
                        "columnDefs": [
                            {"visible": false, "targets": groupColumn}
                        ],
                        "order": [[groupColumn, 'asc']],
                        "displayLength": 25,
                        "drawCallback": function (settings) {
                            var api = this.api();
                            var rows = api.rows({page: 'current'}).nodes();
                            var last = null;

                            api.column(groupColumn, {page: 'current'}).data().each(function (group, i) {
                                if (last !== group) {
                                    $(rows).eq(i).before(
                                            '<tr class="group"><td style="text-align: left; text-indent: 30px" colspan="6">' + group + '</td></tr>'
                                            );

                                    last = group;
                                }
                            });
                        }
                    });

                    // Order by the grouping
                    $('#example tbody').on('click', 'tr.group', function () {
                        var currentOrder = table.order()[0];
                        if (currentOrder[0] === groupColumn && currentOrder[1] === 'asc') {
                            table.order([groupColumn, 'desc']).draw();
                        } else {
                            table.order([groupColumn, 'asc']).draw();
                        }
                    });
                });
            </script>
        </div>
    </body>
</html>