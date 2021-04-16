<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="include/css-page.jsp" />
        <script src="<c:url value="/resources/js/jquery-3.2.1.min.js"/>"></script>
    </head>
    <body>
        <!--  header -->
        <jsp:include page="include/header.jsp" />  
        <section class="site-hero site-hero-innerpage overlay" data-stellar-background-ratio="0.5" style="background-image: url(<c:url value="/resources/images/big_image_1.jpg"/>);">
          <div class="container">
            <div class="row align-items-center site-hero-inner justify-content-center">
              <div class="col-md-12 text-center">

                <div class="mb-5 element-animate">
                  <h1>Service</h1>
                  <p>Discover our world's #1 Luxury Room For VIP.</p>
                </div>

              </div>
            </div>
          </div>
        </section>
        <!--  section -->
        
        <section class="site-section">
          <div class="container">
          <div class="row blog-entries">
          <div class="col-md-12 col-lg-9 main-content">
            <mvc:form action="${pageContext.request.contextPath}/addSer"
                      method="post" modelAttribute="bookingDetail">
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
                
                                  
                            <input type="text" value="${id}" name="id_rooms" hidden>
                        <input type="text" name="noDay"  value="${noDay}" hidden/>
                            <c:forEach items="${service}" var="s"  >
                                <div class="row" style="padding-left: 20px">
                                    <div class="col-sm-6 form-group" >
                                        <mvc:checkbox class="form-check-input" path="services"  value="${s.id}" />
                                        <label class="form-check-label" >
                                            ${s.name}:
                                         </label>    
                                            <fmt:setLocale value="vi_VN" scope="session"/>
                                            <fmt:formatNumber type="currency"
                                                          value="${s.price}"
                                                          currencySymbol="VND"/>.
                                         
                                    </div>
                                </div>
                            </c:forEach>
                <div class="row">
                                    <div class="col-sm-6 form-group" >            
                            <input type="submit" value="Submit" class="btn btn-primary">   
                        
                    </div>
                </div>
            </mvc:form>                
            </div>
        <div class="col-md-12 col-lg-3 sidebar">

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

        <!-- End section -->



        <jsp:include page="include/footer.jsp" /> 

        <jsp:include page="include/loader.jsp" />  

    </body>
</html>
