<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <jsp:include page="include/css-page.jsp" />
    <script src="<c:url value="/resources/js/jquery-3.2.1.min.js"/>"></script>
  </head>
  <body>
      <!--  header -->
    <jsp:include page="include/header.jsp" />  
   
    <!--  section -->
    <section class="site-hero overlay" data-stellar-background-ratio="0.5" style="background-image:url(<c:url value="/resources/images/big_image_1.jpg"/>);">
      <div class="container">
        <div class="row align-items-center site-hero-inner justify-content-center">
          <div class="col-md-12 text-center">

            <div class="mb-5 element-animate">
              <h1>Your Booking Information</h1>
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
      
    <section class="site-section">
          <div class="container">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <button onclick="location.href = '<c:url value="/home"/>'" class="btn btn-primary"> 
                        Back to Home
                    </button>
                </div>
            </div>
            <div class="row">
                     <div class="col-md-12 col-lg-12">
                            <div class="alert alert-success" role="alert">
                                <center><h4>Success! Your Booking has been Booked</h4></center>
                            </div>
                     </div>      
                </div>
            <div class="row">
                  <div class="col-md-12 col-lg-12" >
                      <h4>CODE: ${booking.code}</h4>  
                  </div>
              </div>              
            <div class="row">
                <div class="col-md-12 col-lg-12" >
                    <table>
                        <tr>
                            <td>Full Name: &nbsp;&nbsp;${booking.fullName}</td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>Phone Number: &nbsp;&nbsp;${booking.phoneNumber}</td>
                        </tr>
                        <tr>
                            <td>Id Card: &nbsp;&nbsp;${booking.idCard} </td>
                            <td>&nbsp;&nbsp;</td>
                            <td>Address: &nbsp;&nbsp;${booking.address}</td>
                        </tr>
                        <tr>
                            <td>Email: &nbsp;&nbsp;${booking.email} </td>
                            <td>&nbsp;&nbsp;</td>
                            <td>Birth Date: &nbsp;&nbsp;${booking.birthDate}</td>
                        </tr>
                        <tr>
                            <td>Gender: &nbsp;&nbsp;${booking.gender}</td>
                            <td>&nbsp;&nbsp;</td>
                            <td>Booking Date:&nbsp;&nbsp; ${booking.bookingDate}</td>
                        </tr>
                        <tr>
                            <td>Check-in Date:&nbsp;&nbsp; ${booking.checkIn}</td>
                            <td>&nbsp;&nbsp;</td>
                            <td>Check-out Date: &nbsp;&nbsp;${booking.checkOut}</td>
                        </tr>
                    </table>
                        
                </div>
            </div>
             <div class="row">
                <div class="col-md-12 col-lg-12" >
                    <span style="font-size: 150%; float: right;">Total Price:  &nbsp;&nbsp;
                           <fmt:setLocale value="vi_VN" scope="session"/>
                                        <fmt:formatNumber type="currency"
                                                          value="${booking.totalPrice}"
                                                          currencySymbol="VND"/></span> 
                </div>
            </div>  
            <div class="row">
                <div class="col-md-12 col-lg-12" >
                    <!-- table-->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <tr>
                                <th>Room's Name</th>
                                <th>Price/Night</th>
                                <th>Discount</th>
                                <th>Service</th>
                            </tr>
                             <c:forEach items="${bookingDetail}" var="bd">
                                <tr>
                                    <td>${bd.room.roomType.name} ${bd.room.roomNumber}</td>
                                    <td>
                                        <fmt:setLocale value="vi_VN" scope="session"/>
                                        <fmt:formatNumber type="currency"
                                                          value="${bd.price}"
                                                          currencySymbol="VND"/>
                                    </td>
                                     <td>${bd.discount}% </td>
                                    <td> 
                                      <c:forEach items="${serviceBookingService.getServiceBookingByBookingDetail(bd.id)}" var="sb">
                                          <p> ${sb.service.name} <br></p>
                                     </c:forEach>
                                     </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
                 
                   
                
               
          </div>          
     </section> 
                    
    <jsp:include page="include/footer.jsp" /> 
     
    <jsp:include page="include/loader.jsp" />  
      
  </body>
</html>
