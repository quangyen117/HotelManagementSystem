<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- start header -->	
<div class="page-header navbar navbar-fixed-top">	
    <div class="page-header-inner ">	
        <!-- logo start -->	
        <div class="page-logo">	
            <a href="${pageContext.request.contextPath}/">	
                <img alt="" src="<c:url value="/resources-management/img/luxury-icon.png"/>" width="20%">	
                <span class="logo-default" style="font-size: 20px">Luxury Hotel</span> </a>	
        </div>	
        <!-- logo end -->	
        <ul class="nav navbar-nav navbar-left in">	
            <li><a class="menu-toggler sidebar-toggler"><i class="icon-menu"></i></a></li>	
        </ul>	

        <!-- start mobile menu -->	
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">	
            <span></span>	
        </a>	
        <!-- end mobile menu -->	
        <!-- start header menu -->	
        <div class="top-menu">	
            <ul class="nav navbar-nav pull-right">
                <!-- start manage user dropdown -->	
                <li class="dropdown dropdown-user">	
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">	
                        <img alt="" class="img-circle " src="<c:url value="/resources-management/img/avatar.png"/>" />	
                        <span class="username username-hide-on-mobile"> ${user.fullName} </span>	
                        <i class="fa fa-angle-down"></i>	
                    </a>	
                    <ul class="dropdown-menu dropdown-menu-default animated jello">	
                        <li>	
                            <a href="${pageContext.request.contextPath}/profile">	
                                <i class="icon-user"></i> Profile </a>	
                        </li>	
                        <li>	
                            <a href="#tab3">	
                                <i class="icon-settings"></i> Change Password	
                            </a>	
                        </li>	
                        <li class="divider"> </li>
                        <li>	
                            <a href="${pageContext.request.contextPath}/logout">	
                                <i class="icon-logout"></i> Log Out </a>	
                        </li>	
                    </ul>	
                </li>	
                <!-- end manage user dropdown -->
            </ul>	
        </div>	
    </div>	
</div>	
<!-- end header -->