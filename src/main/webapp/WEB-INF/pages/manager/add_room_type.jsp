<%--
    Document   : add_room_type
    Created on : Mar 8, 2021, 10:47:17 PM
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
                                        <li class="nav-item active">
                                            <a href="javascript:;" class="nav-link nav-toggle">
                                                <i class="fa fa-plus"></i> Room Types
                                                <span class="arrow"></span>
                                            </a>
                                            <ul class="sub-menu">
                                                <c:if test="${action == 'add'}">
                                                    <li class="nav-item">
                                                        <a href="${pageContext.request.contextPath}/hotelManagement/room-type/view-room-type" class="nav-link">
                                                            <i class="fa fa-minus"></i> View Room Types</a>
                                                    </li>
                                                    <li class="nav-item active">
                                                        <a href="${pageContext.request.contextPath}/hotelManagement/room-type/add-room-type" class="nav-link">
                                                            <i class="fa fa-minus"></i> New Room Type</a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${action == 'edit'}">
                                                    <li class="nav-item active">
                                                        <a href="${pageContext.request.contextPath}/hotelManagement/room-type/view-room-type" class="nav-link">
                                                            <i class="fa fa-minus"></i> View Room Types</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a href="${pageContext.request.contextPath}/hotelManagement/room-type/add-room-type" class="nav-link">
                                                            <i class="fa fa-minus"></i> New Room Type</a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </li>
                                        <li class="nav-item">
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
                                                    <a href="${pageContext.request.contextPath}/service/add-service" class="nav-link">
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
                                        <div class="page-title">New Room Type</div>
                                    </c:if>
                                    <c:if test="${action == 'edit'}">
                                        <div class="page-title">Edit Room Type</div>
                                    </c:if>    
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li>
                                        <a class="parent-item">Hotel Management</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <li><a class="parent-item" >Room Types</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <c:if test="${action == 'add'}">
                                        <li class="active">New Room Type</li>
                                        </c:if>
                                        <c:if test="${action == 'edit'}">
                                        <li class="active">Edit Room Type</li>
                                        </c:if>
                                </ol>
                            </div>
                        </div>
                        <mvc:form action="${pageContext.request.contextPath}/hotelManagement/room-type/${action}" method="post" modelAttribute="roomType"  enctype="multipart/form-data" name="validateForm" >
                            <input name="action" type="text" value="${action}" hidden/>
                            <c:if test="${action == 'edit'}">
                                <input name="id" type="hidden" value="${roomType.id}"/>
                            </c:if>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-box">
                                        <div class="card-head">
                                            <c:if test="${action == 'add'}">
                                                <header>Add Room Type</header>
                                                </c:if>
                                                <c:if test="${action == 'edit'}">
                                                <header>Edit Room Type</header>
                                                </c:if>    
                                        </div>    
                                        <div class="card-body row">
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="nameId">Name</label>
                                                    <input type="text" id="nameId" class="form-control" name="name" value="${roomType.name}">
                                                </div>
                                            </div>

                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="sizeId">Size</label>
                                                    <input type="text" id="sizeId" class="form-control" name="size" value="${roomType.size}">
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label>Status</label>
                                                    <select name="status" class="form-control">
                                                        <c:forEach items="${statuses}" var="s">
                                                            <c:if test="${roomType.status == s}">
                                                                <option value="${s}" selected="">${s}</option>
                                                            </c:if>
                                                            <c:if test="${roomType.status != s}">
                                                                <option value="${s}">${s}</option>
                                                            </c:if>    
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label for="capId">Capacity</label>
                                                    <input type="text" id="capId" class="form-control" name="capacity" value="${roomType.capacity}">
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 p-t-20 ">
                                                <label>Upload Room Type Photos</label>
                                                <div class="border btn-sweetalert">
                                                    <input type="file" name="file" id="fileupload" multiple="multiple" accept="image/*" />
                                                    <br/>
                                                    <br/>
                                                    <div id="dvPreview">
                                                    </div>
                                                    <c:forEach items="${roomType.images}" var="rtis">
                                                        <img src="<c:url value="/resources-management/images/${rtis.name}"/>" width="20%"><a href="${pageContext.request.contextPath}/hotelManagement/room-type/delete-image/${rtis.id}" class="btn btn-tbl-delete btn-xs"><i class="fa fa-trash-o "></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        </c:forEach>  
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class="form-group">
                                                    <label>Conveniences</label><br/>
                                                    <div class="dropdown">
                                                        <button class="form-control dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="anchor">Select</span></button>
                                                        <ul class="dropdown-menu checkbox-menu allow-focus" aria-labelledby="dropdownMenu1">
                                                            <% boolean exist = false; %>
                                                            <c:forEach items="${conveniences}" var="cs">
                                                                <c:forEach items="${roomTypeService.getConvenienceIdsInRelationByRoomTypeId(id)}" var="cirti">
                                                                    <c:if test="${cirti == cs.id}">
                                                                        <% exist = true; %>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <% if (exist == true) {%>
                                                                <li>
                                                                    <label><input name="convenienceIds" type="checkbox" value="${cs.id}" id="checkboxbg1" checked />${cs.name}</label>
                                                                </li>
                                                                <% } %>
                                                                <% if (exist == false) {%>  
                                                                <li>
                                                                    <label><input name="convenienceIds" type="checkbox" id="checkboxbg1" value="${cs.id}"/>${cs.name}</label>
                                                                </li>
                                                                <% }%>
                                                                <% exist = false;%>    
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 p-t-20">
                                                <div class="form-group">
                                                    <label for="desId">Description</label>
                                                    <textarea id="desId" class="form-control" name="description">${roomType.description}</textarea>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 p-t-20 text-center">
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-success">Submit</button>

                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20 text-center">
                                                <div class="form-group">
                                                    <a class="btn btn-primary" href="<c:url value="/hotelManagement/room-type/view-room-type" />">Return</a>
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
            <script language="javascript" type="text/javascript">
//                For Display Image Before Upload
                window.onload = function () {
                    var fileUpload = document.getElementById("fileupload");
                    fileUpload.onchange = function () {
                        if (typeof (FileReader) !== "undefined") {
                            var dvPreview = document.getElementById("dvPreview");
                            dvPreview.innerHTML = "";
                            var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                            for (var i = 0; i < fileUpload.files.length; i++) {
                                var file = fileUpload.files[i];
                                if (regex.test(file.name.toLowerCase())) {
                                    var reader = new FileReader();
                                    reader.onload = function (e) {
                                        var img = document.createElement("IMG");
                                        img.height = "100";
                                        img.width = "100";
                                        img.src = e.target.result;
                                        dvPreview.appendChild(img);
                                    };
                                    reader.readAsDataURL(file);
                                } else {
                                    alert(file.name + " is not a valid image file.");
                                    dvPreview.innerHTML = "";
                                    return false;
                                }
                            }
                        } else {
                            alert("This browser does not support HTML5 FileReader.");
                        }
                    };
                };
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
            <script src="<c:url value="/resources-management/others/validationJq/jquery.validate.min.js"/>"></script>
            <script type="text/javascript">
//                For Password Validation By JQuery
                $(function () {
                    $("form[name='validateForm']").validate({
                        errorClass: "error-class",
                        rules: {
                            name: {
                                required: true,
                                minlength: 6
                            },
                            size: {
                                required: true
                            },
                            capacity: {
                                required: true
                            }
                        },
                        messages: {
                            name: {
                                required: "Please enter your name",
                                minlength: "Your name must be at least 6 characters long"
                            },
                            size: {
                                required: "Please enter your size"
                            },
                            capacity: {
                                required: "Please enter your capacity"
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
