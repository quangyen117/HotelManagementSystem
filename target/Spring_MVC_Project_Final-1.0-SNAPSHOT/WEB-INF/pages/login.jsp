<%-- 
    Document   : login
    Created on : Feb 25, 2021, 3:59:57 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta name="description" content="Responsive Admin Template" />
        <meta name="author" content="SmartUniversity" />
        <title>Luxury Hotel</title>
        <!-- google font -->
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" type="text/css" />
        <!-- icons -->
        <link href="<c:url value="/resources-management/plugins/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/iconic/css/material-design-iconic-font.min.css"/>">
        <!-- bootstrap -->
        <link href="<c:url value="/resources-management/plugins/bootstrap/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css" />
        <!-- style -->
        <link rel="stylesheet" href="<c:url value="/resources-management/css/pages/extra_pages.css"/>">
        <!-- favicon -->
        <link rel="shortcut icon" href="<c:url value="/resources-management/img/favicon.ico"/>" /> 
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100 page-background">
                <div class="wrap-login100">
                    <form class="login100-form validate-form" action="j_spring_security_check" method="post">
                        <span class="login100-form-logo">
                            <i class="zmdi zmdi-flower"></i>
                        </span>
                        <span class="login100-form-title p-b-34 p-t-27">
                            Log in
                        </span>
                        <c:if test="${message != null && message != ''}">
                            <tr>
                                <td colspan="2" style="color: red">
                                    ${message}
                                </td>
                            </tr>
                        </c:if>
                        <div class="wrap-input100 validate-input" data-validate = "Enter username">
                            <input class="input100" type="text" name="username" placeholder="Username">
                            <span class="focus-input100" data-placeholder="&#xf207;"></span>
                        </div>
                        <div class="wrap-input100 validate-input" data-validate="Enter password">
                            <input class="input100" type="password" name="password" placeholder="Password">
                            <span class="focus-input100" data-placeholder="&#xf191;"></span>
                        </div>
                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn" type="submit">
                                Login
                            </button>
                        </div>
                        <div class="text-center p-t-90">
                        </div>
                        <input name="${_csrf.parameterName}" value="${_csrf.token}" type="hidden"/>
                    </form>
                </div>
            </div>
        </div>
        <!-- start js include path -->
        <script src="<c:url value="/resources-management/plugins/jquery/jquery.min.js"/>" ></script>
        <!-- bootstrap -->
        <script src="<c:url value="/resources-management/plugins/bootstrap/js/bootstrap.min.js"/>" ></script>
        <script src="<c:url value="/resources-management/js/pages/extra_pages/login.js"/>" ></script>
        <!-- end js include path -->
    </body>
</html>
