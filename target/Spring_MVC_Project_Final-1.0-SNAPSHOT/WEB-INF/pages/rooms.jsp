<%-- 
    Document   : rooms
    Created on : Feb 19, 2021, 4:21:27 PM
    Author     : HMT
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="include/css-page.jsp"/>
        <script src="<c:url value="/resources/js/jquery-3.2.1.min.js"/>"></script>
    </head>
    <body>
        <jsp:include page="include/header.jsp"/>
        
        <section class="site-hero site-hero-innerpage overlay" data-stellar-background-ratio="0.5" style="background-image: url(<c:url value="/resources/images/big_image_1.jpg"/>);">
          <div class="container">
            <div class="row align-items-center site-hero-inner justify-content-center">
              <div class="col-md-12 text-center">

                <div class="mb-5 element-animate">
                  <h1>Our Rooms</h1>
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
                        <input type="date" name="searchCheckIn" class="form-control" id='arrival_date' value="${dateIn}" readonly/>
                    </div>
                </div>
            
                <div class="col-sm-3 form-group">

                    <label for="">Departure Date</label>
                    <div style="position: relative;">
                        <input type="date" name="searchCheckOut" class="form-control" id='departure_date' value="${dateOut}" readonly/>
                    </div>
                </div>
                    
                 <div class="col-sm-3 form-group">

                    <label for="">Booking Date</label>
                    <div style="position: relative;">
                        <input type="date" class="form-control" id='departure_date' value="${newDate}" readonly/>
                    </div>
                </div>   
<!--                 <div class="col-sm-3 form-group">        
                    
                            
                            <label for="roomType">Room Type</label>
                            <div style="position: relative;">
                                <select class="form-control" name="roomTypeId" id="roomType">
                                    <c:forEach items="${roomType}" var="rt"  >
                                        <option value="${rt.id}">${rt.name}</option>
                                    </c:forEach>
                                </select>
                            </div>    
                            <div>
                            <input type="submit" value="Search" class="btn btn-default"/>
                            </div>
                    
                 </div>-->
            </div>
            <div class="row">
                 <div class="col-sm-2 form-group">
                       <button onclick="location.href = '<c:url value="order-rooms?dateIn=${dateIn}&dateOut=${dateOut}&noDay=${noDay}"/>'" class="btn btn-primary"> 
                        Your Booking
                    </button> 
                 </div>  
                    
            </div>
                
             
             <div class="row">
            <c:forEach var="rs" items="${rooms}">  
            
              <div class="col-md-4 mb-4">
                <div class="media d-block room mb-0">
                  <figure>
                      <img src="<c:url value="/resources-management/images/${imageService.getNameImageByRoomType(rs.roomType.id)}"/>" alt="Generic placeholder image" class="img-fluid">
                    <div class="overlap-text">
                      <span>
                        Featured Room 
                        <span class="ion-ios-star"></span>
                        <span class="ion-ios-star"></span>
                        <span class="ion-ios-star"></span>
                        <span class="ion-ios-star"></span>
                        <span class="ion-ios-star"></span>
                      </span>
                    </div>
                  </figure>
                  <div class="media-body">
                    <h3 class="mt-0">${rs.roomType.name} ${rs.roomNumber}</h3>
                    <c:if test="${rs.roomType.discount!=0}">
                     <h5 style="color: red">discount: ${rs.roomType.discount}%</h5>
                    </c:if>
                    <ul class="room-specs">
                      <li><span class="ion-ios-people-outline"></span> ${rs.roomType.capacity} Guests</li>
                      <li><span class="ion-ios-crop"></span> ${rs.roomType.size} m <sup>2</sup></li>
                    </ul>
                    <c:if test="${rs.roomType.discount!=0}">
                        <strike><p style="font-size: 80%; color: red">  
                        <fmt:setLocale value="vi_VN" scope="session"/>
                         <fmt:formatNumber type="currency" value="${rs.price}" currencySymbol="VND"/>
                        </p></strike>
                        <p>  
                        <fmt:setLocale value="vi_VN" scope="session"/>
                         <fmt:formatNumber type="currency" value="${rs.price-(rs.price*rs.roomType.discount/100)}" currencySymbol="VND"/>
                        </p>
                    </c:if>
                    <c:if test="${rs.roomType.discount==0}">    
                        <p>  
                        <fmt:setLocale value="vi_VN" scope="session"/>
                         <fmt:formatNumber type="currency" value="${rs.price}" currencySymbol="VND"/>
                        </p>
                    </c:if>    
                        <button onclick="location.href= '<c:url value="/choose/${rs.id}?dateIn=${dateIn}&dateOut=${dateOut}&noDay=${noDay}"/>' "
                             class="btn btn-success">
                                              Book Now !
                        </button>
                  </div>
                </div>
              </div>
              
            </c:forEach>
             </div>  
            </div>
        </section>

        <section class="section-cover" data-stellar-background-ratio="0.5" style="background-image: url(<c:url value="/resources/images/img_5.jpg"/>);">
          <div class="container">
            <div class="row justify-content-center align-items-center intro">
              <div class="col-md-9 text-center element-animate">
                <h2>Relax and Enjoy your Holiday</h2>
              </div>
            </div>
          </div>
        </section>


        
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/loader.jsp"/>
    </body>
</html>
