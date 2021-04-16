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
              <h1>Stay &amp; Enjoy</h1>
              <p>Discover our world's #1 Luxury Room For VIP.</p>
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
      <section class="site-section py-lg">
      <div class="container">
        
        <div class="row blog-entries">
          <div class="col-md-12 col-lg-8 main-content">
            <h1 class="mb-4">Stay and Enjoy</h1>
            <div class="post-meta">
                        <span class="mr-2">March 15, 2020 </span> &bullet;
                      </div>
            <div class="post-content-body">
                <p>Located in Da Nang, the city of famous bridges and the romantic Han river, Luxury hotel, which lies next to Tran Thi Ly Bridge leaning on the romantic Han river, promises to bring you a journey to peace and romance. Designed in a European-Asian style, Luxury will be a highlight that adds charm to the beautiful Han River. With modern gold-plated copper fittings as well as professional and enthusiastic staff, we commit to provide you the best experience and the best service beyond expectation.</p>
            <div class="row mb-5">
              <div class="col-md-12 mb-4 element-animate">
                  <img src="<c:url value="/resources/images/img_1.jpg"/>" alt="Image placeholder" class="img-fluid">
              </div>
              <div class="col-md-6 mb-4 element-animate">
                  <img src="<c:url value="/resources/images/img_2.jpg"/>" alt="Image placeholder" class="img-fluid">
              </div>
              <div class="col-md-6 mb-4 element-animate">
                  <img src="<c:url value="/resources/images/img_3.jpg"/>" alt="Image placeholder" class="img-fluid">
              </div>
            </div>
              <p>Located in Da Nang, the city of famous bridges and the romantic Han river, Luxury hotel, which lies next to Tran Thi Ly Bridge leaning on the romantic Han river, promises to bring you a journey to peace and romance. Designed in a European-Asian style, Luxury will be a highlight that adds charm to the beautiful Han River. With modern gold-plated copper fittings as well as professional and enthusiastic staff, we commit to provide you the best experience and the best service beyond expectation.</p>
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
                        <h4>DA NANG’S IMPRESSION</h4>
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
                        <h4>DA NANG’S IMPRESSION</h4>
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
                        <h4>DA NANG’S IMPRESSION</h4>
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
     
    
    <jsp:include page="include/footer.jsp" /> 
     
    <jsp:include page="include/loader.jsp" />  
      
  </body>
</html>
