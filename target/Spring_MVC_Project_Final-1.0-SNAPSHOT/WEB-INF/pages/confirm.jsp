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
              <h1>Confirm Your Booking</h1>
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
      
    <section class="site-section">
          <div class="container">
             <div class="row">
                <div class="col-sm-3 form-group">

                    <label for="">Arrival Date</label>
                    <div style="position: relative;">
                        <input type="date" name="dateIn" class="form-control" id='arrival_date' value="${dateIn}" readonly/>
                    </div>
                </div>
            
                <div class="col-sm-3 form-group">

                    <label for="">Departure Date</label>
                    <div style="position: relative;">
                        <input type="date" name="dateOut" class="form-control" id='departure_date' value="${dateOut}" readonly/>
                    </div>
                </div>
                    
                 <div class="col-sm-3 form-group">

                    <label for="">Booking Date</label>
                    <div style="position: relative;">
                        <input type="date" class="form-control" id='departure_date' value="${newdate}" readonly/>
                    </div>
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
                                <th>Night(s)</th>
                                <th>Discount</th>
                                <th>Service</th>
                                <th>Total Price</th>
                            </tr>
                             <c:forEach items="${cart}" var="cart">
                                <tr>
                                    <td>${cart.value.room.roomType.name} ${cart.value.room.roomNumber}</td>
                                    <td>
                                        <fmt:setLocale value="vi_VN" scope="session"/>
                                        <fmt:formatNumber type="currency"
                                                          value="${cart.value.room.price}"
                                                          currencySymbol="VND"/>
                                    </td>
                                    
                                    <td>
                                        ${noDay}
                                    </td>
                                     <td>${cart.value.room.roomType.discount}% </td>  
                                   
                                    <td>
                                        <c:forEach items="${cart.value.serviceEntity}" var="service">
                                            <p>
                                            <span>${service.name}: </span>
                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                              <fmt:formatNumber type="currency" value="${service.price}" currencySymbol="VND"/>
                                            </p>
                                        </c:forEach>    
                                    </td>
                                     <td>
                                           <c:set var="total" value="${cart.value.room.price-(cart.value.room.price*cart.value.room.roomType.discount/100)}" />
                                         <c:forEach items="${cart.value.serviceEntity}" var="service">
                                             <c:set var="total" value="${total+service.price}" />
                                         </c:forEach>
                                        <fmt:setLocale value="vi_VN" scope="session"/>
                                        <fmt:formatNumber  type="currency"
                                                          value="${total*noDay}" currencySymbol="VND"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-10 col-lg-10">
                    <div>
                        <span>Total price:</span>
                        <c:set var="totals" value="${0}"/>
                        
                        <c:forEach items="${cart}" var="cart">
                            <c:set var="totals" value="${totals + (cart.value.room.price-(cart.value.room.price*cart.value.room.roomType.discount/100))}" />
                             <c:forEach items="${cart.value.serviceEntity}" var="service">
                                 <c:set var="totals" value="${totals + service.price}" />
                             </c:forEach>
                        </c:forEach>

                        <fmt:setLocale value="vi_VN" scope="session"/>
                        <fmt:formatNumber type="currency" value="${totals*noDay}" currencySymbol="VND"/>
                    </div>
                </div>
            </div>         
                    
                
            <mvc:form action="${pageContext.request.contextPath}/form" method="post" 
                              modelAttribute="booking" id="demoForm">
                <!--<input type="text" name="noDay" value="${noDay}" hidden>-->
                <input type="date" name="checkIn" value="${dateIn}" hidden />
                <input type="date" name="checkOut" value="${dateOut}" hidden />
                <input type="text" name="totalPrice" value="${totals*noDay}"  hidden/>
                <input type="text" name="status" value="${bookingStatus}" hidden />
                <input type="text" name="code" value="${code}" hidden  />
                <input type="date" name="bookingDate" value="${newdate}" hidden  />
                
                  <div class="row">
                    <div class="col-md-4 col-lg-4">  
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" >
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4">   
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                    </div>
                  </div>
                  
                  <div class="row">
                    <div class="col-md-4 col-lg-4">
                        <div class="mb-3">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber">
                        </div>
                     </div>
                     <div class="col-md-4 col-lg-4">  
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address">
                        </div>
                     </div>
                    </div>
                
                <div class="row">
                    <div class="col-md-4 col-lg-4">
                        <div class="mb-3">
                            <label for="gender">Gender</label>
                                <select class="form-control" name="gender" id="gender">
                                    <c:forEach items="${gender}" var="g"  >
                                    <option value="${g}">${g}</option>
                                </c:forEach>
                                </select>  
                        </div>
                     </div>
                     <div class="col-md-4 col-lg-4">  
                        <div class="mb-3">
                            <label for="idCard" class="form-label">ID/Passport Number</label>
                            <input type="text" class="form-control" id="idCard" name="idCard">
                        </div>
                     </div>
                    </div>
                <div class="row">
                    <div class="col-md-4 col-lg-4">
                        <div class="mb-3">
                            <label for="birthDate" class="form-label">birthDate</label>
                            <input type="date" class="form-control" id="birthDate" name="birthDate">
                        </div>
                    </div>
                </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
            </mvc:form>        
          </div>          
     </section> 
                    
    <jsp:include page="include/footer.jsp" /> 
     
    <jsp:include page="include/loader.jsp" />  
      
  </body>
</html>
