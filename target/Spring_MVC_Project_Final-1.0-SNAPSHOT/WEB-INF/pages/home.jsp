<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
   
    <!--  section -->
    <section class="site-hero overlay" data-stellar-background-ratio="0.5" style="background-image:url(<c:url value="/resources/images/big_image_1.jpg"/>);">
      <div class="container">
        <div class="row align-items-center site-hero-inner justify-content-center">
          <div class="col-md-12 text-center">

            <div class="mb-5 element-animate">
              <h1>Welcome To Our Luxury Rooms</h1>
              <p>Discover our world's #1 Luxury Room For VIP.</p>
              <p><a href="<c:url value="/booknow"/>" class="btn btn-primary">Book Now</a></p>
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
      
      <section class="site-section">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-4">
            <div class="heading-wrap text-center element-animate">
              <h4 class="sub-heading">Stay with our luxury rooms</h4>
              <h2 class="heading">Stay and Enjoy</h2>
              <p class="mb-5">Located in Da Nang, the city of famous bridges and the romantic Han river, Luxury hotel, which lies next to Tran Thi Ly Bridge leaning on the romantic Han river, promises to bring you a journey to peace and romance. Designed in a European-Asian style, Luxury will be a highlight that adds charm to the beautiful Han River. With modern gold-plated copper fittings as well as professional and enthusiastic staff, we commit to provide you the best experience and the best service beyond expectation.</p>
              <p><a href="<c:url value="/stayandenjoy"/>" class="btn btn-primary btn-sm">More About Us</a></p>
            </div>
          </div>
          <div class="col-md-1"></div>
          <div class="col-md-7">
              <img src="<c:url value="/resources/images/f_img_1.png"/>" alt="Image placeholder" class="img-md-fluid">
          </div>
        </div>
      </div>
    </section>
    <!-- END section -->

    <section class="site-section bg-light">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-12 heading-wrap text-center">
            <h4 class="sub-heading">Our Luxury Rooms</h4>
              <h2 class="heading">Featured Rooms</h2>
          </div>
        </div>
        <div class="row ">
          <div class="col-md-7">
            <div class="media d-block room mb-0">
              <figure>
                  <img src="<c:url value="/resources/images/img_1.jpg"/>" alt="Generic placeholder image" class="img-fluid">
                <div class="overlap-text">
                  <span>
                    Featured Room 
                    <span class="ion-ios-star"></span>
                    <span class="ion-ios-star"></span>
                    <span class="ion-ios-star"></span>
                  </span>
                </div>
              </figure>
              <div class="media-body">
                <h3 class="mt-0"><a href="<c:url value="/roomType1"/>">Presidential Room</a></h3>
                <ul class="room-specs">
                  <li><span class="ion-ios-people-outline"></span> 4 Guests</li>
                  <li><span class="ion-ios-crop"></span> 60 m <sup>2</sup></li>
                </ul>
                <p>Classy President room is 90 square meters in area, and divided into separate areas including bedroom, conference room, guest room and kitchen. This room has modern and deluxe facilities, all rooms carpeted, view of city, Han river and Son Tra peninsula. President room is absolutely an excellent choice for those who are looking for a lavish and unique experience. </p>
                <p><a href="#" class="btn btn-primary btn-sm">Book Now</a></p>
              </div>
            </div>
          </div>
          <div class="col-md-5 room-thumbnail-absolute">
              <a href="<c:url value="/roomType2"/>" class="media d-block room bg first-room" style="background-image: url(<c:url value="/resources/images/img_2.jpg"/>); ">
              <!-- <figure> -->
                <div class="overlap-text">
                  <span>
                    Featured Room 
                    <span class="ion-ios-star"></span>
                    <span class="ion-ios-star"></span>
                    <span class="ion-ios-star"></span>
                  </span>
                  <span class="pricing-from">
                    Book Now
                  </span>
                </div>
              <!-- </figure> -->
            </a>

              <a href="<c:url value="/roomType3"/>" class="media d-block room bg second-room" style="background-image: url(<c:url value="/resources/images/img_4.jpg"/>); ">
              <!-- <figure> -->
                <div class="overlap-text">
                  <span>
                    Featured Room
                    <span class="ion-ios-star"></span>
                    <span class="ion-ios-star"></span>
                    <span class="ion-ios-star"></span>
                  </span>
                  <span class="pricing-from">
                    Book Now
                  </span>
                </div>
              <!-- </figure> -->
            </a>
            
          </div>
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
    <!-- END section -->
    
    <section class="site-section bg-light">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-12 heading-wrap text-center">
            <h4 class="sub-heading">Our Blog</h4>
              <h2 class="heading">Our Recent Blog</h2>
          </div>
        </div>
        <div class="row ">
          <div class="col-md-4">
            <div class="post-entry">
                <img src="<c:url value="/resources/images/img_3.jpg"/>" alt="Image placeholder" class="img-fluid">
              <div class="body-text">
                <div class="category">Rooms</div>
                <h3 class="mb-3"><a href="<c:url value="/blog-single"/>">New Rooms</a></h3>
                <p class="mb-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum deserunt illo quis similique dolore voluptatem culpa voluptas rerum, dolor totam.</p>
                <p><a href="<c:url value="/blog-single"/>" class="btn btn-primary btn-outline-primary btn-sm">Read More</a></p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="post-entry">
                <img src="<c:url value="/resources/images/img_6.jpg"/>" alt="Image placeholder" class="img-fluid">
              <div class="body-text">
                <div class="category">News</div>
                <h3 class="mb-3"><a href="<c:url value="/blog-single"/>">New Staff Added</a></h3>
                <p class="mb-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum deserunt illo quis similique dolore voluptatem culpa voluptas rerum, dolor totam.</p>
                <p><a href="<c:url value="/blog-single"/>" class="btn btn-primary btn-outline-primary btn-sm">Read More</a></p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="post-entry">
                <img src="<c:url value="/resources/images/img_5.jpg"/>" alt="Image placeholder" class="img-fluid">
              <div class="body-text">
                <div class="category">New Rooms</div>
                <h3 class="mb-3"><a href="<c:url value="/blog-single"/>">Big Rooms for All</a></h3>
                <p class="mb-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum deserunt illo quis similique dolore voluptatem culpa voluptas rerum, dolor totam.</p>
                <p><a href="<c:url value="/blog-single"/>" class="btn btn-primary btn-outline-primary btn-sm">Read More</a></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- END section -->

    
    <jsp:include page="include/footer.jsp" /> 
     
    <jsp:include page="include/loader.jsp" />  
      
  </body>
</html>
