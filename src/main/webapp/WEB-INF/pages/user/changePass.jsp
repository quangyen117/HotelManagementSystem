<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <jsp:include page="include/css-page.jsp" />
    
<script src="<c:url value="/resources/js/jquery-3.2.1.min.js"/>"></script>     
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <script src="<c:url value="/resources/js/changepass.js"/>"></script>    
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
              <h1>Change Your Password</h1>
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
     <section class="site-section">
     <div class="container">
          <c:if test="${mes != null && mes!=''}">           
                <div class="row">
                     <div class="col-md-12 col-lg-12">
                            <div class="alert alert-danger" role="alert">
                                <center><h4>${mes}</h4></center>
                            </div>
                     </div>      
                </div>
            </c:if>
      <div class="row">
        <div class="col-md-10 col-lg-10">
            
            <h2 class="mb-5">Your Profile</h2>   
     <form action="${pageContext.request.contextPath}/updatePassword"
                      method="post"  id="demoForm" >
             
                <div class="row">
                    
                        <div class="col-md-6 col-lg-6" >
                             <div class="form-group">
                                <label for="nowpassword">Current Password</label>
                                <input type="password" id="nowpassword"
                                       class="form-control" name="nowpassword" />
                            </div>
                        </div>                    
                </div>
                <div class="row">
                    
                        <div class="col-md-6 col-lg-6" >
                             <div class="form-group">
                                <label for="newpassword">New Password</label>
                                <input type="password" id="newpassword"
                                       class="form-control" name="newpassword" />
                            </div>
                        </div>
                </div>
                <div class="row">
                    
                        <div class="col-md-6 col-lg-6" >
                             <div class="form-group">
                                <label for="re-newpassword">Confirm New Password</label>
                                <input type="password" id="re-newpassword"
                                       class="form-control" name="re-newpassword" />
                            </div>
                        </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-lg-12" >
                        <button type="submit" class="btn btn-success">
                            Update Your Password.
                        </button>
                    </div>
                </div>
            </form>
        </div>
      </div>
     </div>
     </section>
    <jsp:include page="include/footer.jsp" /> 
     <jsp:include page="include/loader.jsp" />  
     
  </body>
</html>
