<%-- 
    Document   : add_account
    Created on : Mar 25, 2021, 3:24:44 PM
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

            /*For Radio Button*/
            input[type=radio]:checked{
                background: gray;
                    border-radius: 15px;
                border: 4px solid #dfdfdf;
            }
            
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
                                <li class="nav-item active">
                                    <a class="nav-link nav-toggle">
                                        <i class="fa fa-user-circle"></i> 
                                        <span class="title">Account</span>
                                        <span class="arrow"></span>
                                    </a>
                                    <ul class="sub-menu">
                                        <c:if test="${action == 'add'}">
                                            <li class="nav-item">
                                                <a href="${pageContext.request.contextPath}/account/view-account" class="nav-link">
                                                    <i class="fa fa-users"></i> View Accounts</a>
                                            </li>
                                            <li class="nav-item active">

                                                <a href="${pageContext.request.contextPath}/account/add-account" class="nav-link">
                                                    <i class="fa fa-user-plus"></i> New Account</a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="${pageContext.request.contextPath}/account/change-password" class="nav-link">
                                                    <i class="fa fa-retweet"></i> Change Password</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${action == 'edit'}">
                                            <li class="nav-item active">
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
                                        </c:if>
                                    </ul>
                                </li>
                                </sec:authorize>
                                <sec:authorize access="hasAnyRole('ROLE_MANAGER')">
                                <li class="nav-item">
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
                                        <li class="nav-item ">
                                            <a href="javascript:;" class="nav-link nav-toggle">
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
                                        <div class="page-title">New Account</div>
                                    </c:if>
                                    <c:if test="${action == 'edit'}">    
                                        <div class="page-title">Edit Account</div>
                                    </c:if>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li>
                                        <a class="parent-item" >Account</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <c:if test="${action == 'add'}">
                                        <li class="active">New Account</li>
                                        </c:if>
                                        <c:if test="${action == 'edit'}">
                                        <li class="active">Edit Account</li>
                                        </c:if>
                                </ol>
                            </div>
                        </div>
                        <mvc:form action="${pageContext.request.contextPath}/account/${action}" method="post" modelAttribute="account" name="validateForm">
                            <input name="action" type="text" value="${action}" hidden/>
                            <c:if test="${action == 'edit'}">
                                <input name="id" type="hidden" value="${account.id}"/>
                            </c:if>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-box">
                                        <div class="card-head">
                                            <c:if test="${action == 'add'}">
                                                <header>New Account</header>
                                                </c:if>
                                                <c:if test="${action == 'edit'}">
                                                <header>Edit Account</header>
                                                </c:if>
                                        </div>    
                                        <div class="card-body row">
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="emailId">Email</label>
                                                    <input type="text" id="emailId" class="form-control" name="email" value="${account.email}">
                                                </div>
                                            </div>
                                            <c:if test="${action == 'add'}">
                                                <div class="col-lg-6 p-t-20">
                                                    <div class="form-group">
                                                        <label for="passId">Password</label>
                                                        <input type="password" id="passId" class="form-control" name="password" value="${account.password}">
                                                    </div>
                                                </div>
                                            </c:if>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label>Role</label>
                                                    <div class="dropdown">
                                                        <button class="form-control dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="anchor">Select</span></button>
                                                        <ul class="dropdown-menu checkbox-menu allow-focus" aria-labelledby="dropdownMenu1">
                                                            <% boolean exist = false; %>
                                                            <c:forEach var="ars" items="${accRoles}">
                                                                <c:forEach items="${userService.getAccRoleIdsByAccountId(account.id)}" var="aris" >
                                                                    <c:if test="${aris == ars.id}">
                                                                        <% exist = true; %>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <% if (exist == true) {%>
                                                                <li>
                                                                    <label><input type="checkbox" name="accRoleIds" value="${ars.id}" id="checkboxbg1" checked=""/>${ars.role}</label>
                                                                </li>
                                                                <% } %>
                                                                <% if (exist == false) {%>  
                                                                <li>
                                                                    <label><input type="checkbox" name="accRoleIds" value="${ars.id}" id="checkboxbg1"/>${ars.role}</label>
                                                                </li>
                                                                <% }%>
                                                                <% exist = false;%> 
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label>Status</label>
                                                    <select name="status" class="form-control">
                                                        <c:forEach items="${statuses}" var="s">
                                                            <c:if test="${account.status == s}">
                                                                <option value="${s}" selected="">${s}</option>
                                                            </c:if>
                                                            <c:if test="${account.status != s}">
                                                                <option value="${s}">${s}</option>
                                                            </c:if>    
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="nameId">Full Name</label>
                                                    <input type="text" id="nameId" class="form-control" name="fullName" value="${account.fullName}">
                                                </div>
                                            </div>    
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="addId">Address</label>
                                                    <input type="text" id="addId" class="form-control" name="address" value="${account.address}">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="bDateId">Birth Date</label>
                                                    <input class="form-control" type="date" name="birthDate" id="bDateId" value="${account.birthDate}">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label>Gender</label>
                                                    <div class="form-control">
                                                        <c:forEach items="${gender}" var="g">
                                                            <c:if test="${account.gender == g}">
                                                                <input type="radio" name="gender" value="${g}" checked=""/>
                                                                <label >${g}</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                            </c:if>
                                                            <c:if test="${account.gender != g}">
                                                                <input type="radio" name="gender" value="${g}" />
                                                                <label >${g}</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                            </c:if>
                                                        </c:forEach> 
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="phoneId">Phone Number</label>
                                                    <input class="form-control" placeholder="(0)" type="text" name="phoneNumber" id="phoneId" value="${account.phoneNumber}">
                                                </div>
                                            </div>
                                            <c:if test="${action == 'add'}">
                                                <div class="col-lg-6 p-t-20">
                                                    <div class="form-group">

                                                    </div>
                                                </div> 
                                            </c:if>
                                            <div class="col-lg-6 p-t-20 text-center">
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-success">Submit</button>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20 text-center">
                                                <div class="form-group">
                                                    <a class="btn btn-primary" href="<c:url value="/account/view-account" />">Return</a>
                                                </div>
                                            </div>     
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </mvc:form>
                    </div>
                    <!-- end page content -->
                </div>
                <!-- end page container -->
                <!-- start footer -->
                <jsp:include page="../include-management/footer.jsp" />
                <!-- end footer -->
            </div>
            <jsp:include page="../include-management/js-page.jsp" />
            <script>
                //   For Checkboxes Dropdown
                $(".checkbox-menu").on("change", "input[type='checkbox']", function () {
                    $(this).closest("li").toggleClass("active", this.checked);
                });

                $(document).on('click', '.allow-focus', function (e) {
                    e.stopPropagation();
                });
            </script>
            <script src="<c:url value="/resources-management/others/validationJq/jquery.validate.min.js"/>"></script>
            <script>
                
            </script>
            <script type="text/javascript">
            //     For Password Validation By JQuery
                $(function () {
                    $("form[name='validateForm']").validate({
                        errorClass: "error-class",
                        rules: {
                            email: {
                                required: true,
                                email: true
                            },
                            password: {
                                required: true,
                                minlength: 6
                            },
                            fullName: {
                                required: true,
                                minlength: 6
                            },
                            address: {
                                required: true,
                                minlength: 6
                            },
                            birthDate: {
                                required: true
                            },
                            phoneNumber: {
                                required: true,
                                minlength: 10,
                                maxlength: 10
                            },
                            accRoleIds: {
                                required: true
                            },
                            gender: {
                                required: true
                            }
                        },
                        messages: {
                            email: {
                                required: "Please enter your email",
                                email: "Your email is invalid"
                            },
                            password: {
                                required: "Please enter your password",
                                minlength: "Your password must be at least 6 characters long"
                            },
                            fullName: {
                                required: "Please enter your name",
                                minlength: "Your name must be at least 6 characters long"
                            },
                            address: {
                                required: "Please enter your address",
                                minlength: "Your address must be at least 6 characters long"
                            },
                            birthDate: {
                                required: "Please choose your birth date"
                            },
                            phoneNumber: {
                                required: "Please enter your phone number",
                                minlength: "Your phone number must be 10 characters long",
                                maxlength: "Your phone number must be 10 characters long"
                            },
                            gender: {
                                required: "Check one"
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

