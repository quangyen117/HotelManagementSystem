<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <jsp:include page="include/css-page.jsp" />
    <script src="<c:url value="/resources/js/jquery-3.2.1.min.js"/>"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <script src="<c:url value="/resources/js/form2.js"/>"></script>
    <style>
        label.error{
                color: red;
        }
    </style>
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
              <h1> Your Booking History</h1>
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
      
    <section class="site-section">
          <div class="container">
              <div class="row">
                  <div class="col-md-12 col-lg-12" >
                      <h3>Your Booking History</h3>
                  </div>
              </div>
            <div class="row">
                <div class="col-md-12 col-lg-12" >
                    <!-- table-->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <tr>
                                <th>Code Booking</th>
                                <th>Booking Date</th>
                                <th>Total Price</th>
                                <th>Status</th>
                            </tr>
                             <c:forEach items="${booking}" var="booking">
                                 <tr>
                                     <td><a href="<c:url value="/Bill/${booking.code}"/>">${booking.code}</a></td>
                                     <td>${booking.bookingDate}</td>
                                     <td><fmt:setLocale value="vi_VN" scope="session"/>
                                        <fmt:formatNumber type="currency"
                                                          value="${booking.totalPrice}"
                                                          currencySymbol="VND"/> </td>
                                     <td>${booking.status}</td>
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
