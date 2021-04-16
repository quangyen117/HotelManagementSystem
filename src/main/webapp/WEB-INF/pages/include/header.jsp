<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>


<header role="banner"> 
<nav class="navbar navbar-expand-md navbar-dark bg-light">
        <div class="container">
          <a class="navbar-brand" href="<c:url value="/home"/>">LuxuryHotel</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample05" aria-controls="navbarsExample05" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse navbar-light" id="navbarsExample05">
            <ul class="navbar-nav ml-auto pl-lg-5 pl-0">
              <li class="nav-item">
                <a class="nav-link" href="<c:url value="/home"/>">Home</a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="<c:url value="/rooms"/>" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Rooms</a>
                <div class="dropdown-menu" aria-labelledby="dropdown04">
<!--                  <a class="dropdown-item" href="<c:url value="/roomType1"/>">Presidential Room</a>
                  <a class="dropdown-item" href="<c:url value="/roomType2"/>">Luxury Room</a>
                  <a class="dropdown-item" href="<c:url value="/roomType3"/>">Deluxe Room</a>-->
                     <c:forEach items="${userService.userGetRoomTypes()}" var="rt"  >
                          <a class="dropdown-item" href="<c:url value="/roomType1/${rt.id}"/>">${rt.name}</a>
                    </c:forEach>
                </div>

              </li>
              <li class="nav-item">
                <a class="nav-link" href="<c:url value="/blog"/>">Blog</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<c:url value="/about"/>">About</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<c:url value="/contact"/>">Contact</a>
              </li>

               <li class="nav-item cta">
                <a class="nav-link" href="<c:url value="/booknow"/>"><span>Book Now</span></a>
              </li>
              <sec:authorize access="!isAuthenticated()">
                <li class="nav-item">
                  <a class="nav-link" href="<c:url value="/login"/>">Login</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="<c:url value="/register"/>">Register</a>
                </li>
              </sec:authorize>
              <sec:authorize access="isAuthenticated()">
                  <li class="nav-item dropdown">
                      <a class="nav-link dropdown-toggle" href="" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="text-transform: capitalize">${userService.userFullName}</a>
                <div class="dropdown-menu" aria-labelledby="dropdown04">
                  <a class="dropdown-item" href="<c:url value="/profile"/>">Update Profile</a>
                  <a class="dropdown-item" href="<c:url value="/changePass"/>">Change Password</a>
                  <a class="dropdown-item" href="<c:url value="/bookingHistory"/>">Booking History</a>
                </div>

              </li> 
                <li class="nav-item">
                  <a class="nav-link" href="<c:url value="/logout"/>">Logout</a>
                </li>
              </sec:authorize> 
            </ul>
            
          </div>
        </div>
      </nav>
    </header>