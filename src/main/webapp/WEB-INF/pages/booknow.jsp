<%-- 
    Document   : bookNow
    Created on : Feb 19, 2021, 4:01:58 PM
    Author     : HMT
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                  <h1>Reservation</h1>
                  <p>Discover our world's #1 Luxury Room For VIP.</p>
                </div>

              </div>
            </div>
          </div>
        </section>
        <!-- END section -->

        <section class="site-section">
          <div class="container">
          <div class="row blog-entries">
          <div class="col-md-12 col-lg-8 main-content">  
            <div class="row">
              <div class="col-md-10">
                <h2 class="mb-5">Reservation Form</h2>
                    <form form action="${pageContext.request.contextPath}/search" method="post">
                      <div class="row">
                          
                          <div class="col-sm-6 form-group">

                              <label for="">Arrival Date</label>
                              <div style="position: relative;">
                                  <input type='date' name="searchCheckIn" class="form-control" id='arrival_date' value="${newdate}"  />
                              </div>
                          </div>

                          <div class="col-sm-6 form-group">

                              <label for="">Departure Date</label>
                              <div style="position: relative;">
                                  <input type='date' name="searchCheckOut" class="form-control" id='departure_date' value="${newdate}"/>
                              </div>
                          </div>
                          
                      </div>
<!--                      <div class="row">
                          
                          <div class="col-sm-6 form-group">
                              <label for="roomType">Room Type</label>
                                <select class="form-control" name="roomType" id="roomType">
                                    <c:forEach items="${roomType}" var="rt"  >
                                    <option value="${rt.id}">${rt.name}</option>
                                </c:forEach>
                                </select>
                          </div>
                      </div>        -->
                      <div class="row">
                          <div class="col-sm-6 form-group">
                           <c:if test="${mes != null}"> 
                              <p style="color: red">
                                  ${mes}
                              </p>
                          </c:if>
                          </div>
                      </div>   
                     
                      <div class="row">
                        <div class="col-md-6 form-group">
                          <input type="submit" value="Reserve Now" class="btn btn-primary">
                        </div>
                      </div>
                    </form>
                  </div>
            </div>
          </div>    
                              
            <div class="col-md-12 col-lg-4 sidebar">

            <div class="sidebar-box">
              <h3 class="heading">Popular Posts</h3>
              <div class="post-entry-sidebar">
                <ul>
                  <li>
                    <a href="">
                        <img src="<c:url value="/resources/images/img_1.jpg"/>" alt="Image placeholder" class="mr-4">
                      <div class="text">
                        <h4>Presidential Room</h4>
                        <div class="post-meta">
                          <span class="mr-2">March 15, 2018 </span> &bullet;
                        </div>
                      </div>
                    </a>
                  </li>
                  <li>
                    <a href="">
                        <img src="<c:url value="/resources/images/img_1.jpg"/>" alt="Image placeholder" class="mr-4">
                      <div class="text">
                        <h4>Deluxe Room</h4>
                        <div class="post-meta">
                          <span class="mr-2">March 15, 2018 </span> &bullet;
                        </div>
                      </div>
                    </a>
                  </li>
                  <li>
                    <a href="">
                        <img src="<c:url value="/resources/images/img_1.jpg"/>" alt="Image placeholder" class="mr-4">
                      <div class="text">
                        <h4>Luxury Room</h4>
                        <div class="post-meta">
                          <span class="mr-2">March 15, 2018 </span> &bullet;
                        </div>
                      </div>
                    </a>
                  </li>
                </ul>
              </div>
            </div>
      </div>  
                      
          </div>
          </div>              
        </section>
        <!-- END section -->





        <section class="section-cover" data-stellar-background-ratio="0.5" style="background-image: url(<c:url value="/resources/images/img_5.jpg"/>);">
          <div class="container">
            <div class="row justify-content-center align-items-center intro">
              <div class="col-md-9 text-center element-animate">
                <h2>Relax and Enjoy your Holiday</h2>
              </div>
            </div>
          </div>
        </section>
        <!-- END section -->

        
        <jsp:include page="include/footer.jsp"/>
        <jsp:include page="include/loader.jsp"/>
    </body>
</html>
