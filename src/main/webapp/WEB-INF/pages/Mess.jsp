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
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
      <section class="site-section py-lg">
      <div class="container">
         <div class="row">
                <div class="col-sm-3 form-group"> 
                    <button onclick="location.href = '<c:url value="/home"/>'" class="btn btn-primary"> 
                                    Back to Home
                    </button>
                </div>
         </div>
        <div class="row">
                <div class="col-sm-10 form-group">                             
                    <c:if test="${mesType==0}">
                        <h1 style="color: red">${mes}</h1>
                    </c:if>
                    <c:if test="${mesType==1}">
                        <h1 style="color: green">${mes}</h1>
                    </c:if>    
                </div>
        </div>
      </div> 
      </section>
     
    
    <jsp:include page="include/footer.jsp" /> 
     
    <jsp:include page="include/loader.jsp" />  
      
  </body>
</html>
