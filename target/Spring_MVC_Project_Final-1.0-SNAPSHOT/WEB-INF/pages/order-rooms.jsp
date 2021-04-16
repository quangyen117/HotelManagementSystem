<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
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
              <h1>Your Booking</h1>
              <p>Discover our world's #1 Luxury Room For VIP.</p>
            </div>

          </div>
        </div>
      </div>
    </section>
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
                        <input type="date" class="form-control" id='departure_date' value="${newDate}" readonly/>
                    </div>
                </div> 
            </div>  
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <button onclick="location.href = '<c:url value="/rooms?searchCheckIn=${dateIn}&searchCheckOut=${dateOut}&noDay=${noDay}"/>'" class="btn btn-primary"> 
                        Back to Booking
                    </button>
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
                                <th>Unit Price</th>
                                <th>Action</th>
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
                                            <button onclick="location.href = '<c:url value="/deleteService/${cart.value.room.id}/${service.id}?dateIn=${dateIn}&dateOut=${dateOut}&noDay=${noDay}" />'"
                                                    >
                                                X
                                            </button>
                                                
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
                                    <td>
                                        <button onclick="location.href = '<c:url value="/delete/${cart.value.room.id}?dateIn=${dateIn}&dateOut=${dateOut}&noDay=${noDay}" />'" 
                                                class="btn btn-primary"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                        </svg></button> 
                                        <button onclick="location.href = '<c:url value="/addService/${cart.value.room.id}?dateIn=${dateIn}&dateOut=${dateOut}&noDay=${noDay}" />'" 
                                                class="btn btn-primary">Service</button>        
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
        <sec:authorize access="!isAuthenticated()">       
            <div class="row">        
                <div class="col-md-12 col-lg-12">
                        <button onclick="location.href = '<c:url value="/confirm?dateIn=${dateIn}&dateOut=${dateOut}&noDay=${noDay}"/>'" class="btn btn-primary float-right"> 
                             Confirm Booking
                        </button>
                 </div>
            </div>
       </sec:authorize>
       <sec:authorize access="isAuthenticated()">       
            <div class="row">        
                <div class="col-md-12 col-lg-12">
                        <button onclick="location.href = '<c:url value="/confirm1?dateIn=${dateIn}&dateOut=${dateOut}&noDay=${noDay}"/>'" class="btn btn-primary float-right"> 
                             Confirm Booking
                        </button>
                 </div>
            </div>
       </sec:authorize> 
          </div>
    </section>                     
      
     
<!--    <script src="<c:url value="/resources/js/days.js"/>"></script>-->
                 

    <jsp:include page="include/footer.jsp" /> 
     
    <jsp:include page="include/loader.jsp" />  
    
<!--            <script type="text/javascript">
            var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = window.location.search.substring(1),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return typeof sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
                }
            }
            return false;
        };
        
            var day_in = getUrlParameter('day_in');
            var day_out = getUrlParameter('day_out');
        
             function treatAsUTC(date) {
                var result = new Date(date);
                result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
                return result;
            }

            function daysBetween(dayIn, dayOut) {
                var millisecondsPerDay = 24 * 60 * 60 * 1000;
                return (treatAsUTC(dayOut) - treatAsUTC(dayIn)) / millisecondsPerDay;
            }
            
//            $('noDay').val(daysBetween(day_in,day_out))
$(function () {
    var aaa = ${cart};
console.log(aaa);
  $('#noDay').val(daysBetween(day_in,day_out));
  $()
});

        </script>  -->
      
  </body>
</html>
