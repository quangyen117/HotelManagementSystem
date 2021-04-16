<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <jsp:include page="include/css-page.jsp" />
    
<script src="<c:url value="/resources/js/jquery-3.2.1.min.js"/>"></script>     
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <script src="<c:url value="/resources/js/form.js"/>"></script>    
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
              <h1>Your Profile</h1>
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
     <section class="site-section">
     <div class="container">
      <div class="row">
        <div class="col-md-10 col-lg-10">
            <h2 class="mb-5">Your Profile</h2>   
     <mvc:form action="${pageContext.request.contextPath}/editUser"
                      method="post" modelAttribute="userEntity" id="demoForm" >
             
         <input type="text" name="id" value="${user.id}" hidden>
                <div class="row">
                    
                        <div class="col-md-6 col-lg-6" >
                             <div class="form-group">
                                <label for="name">FullName</label>
                                <input type="text" id="fullName"
                                       class="form-control" name="fullName" value="${user.fullName}"/>
                            </div>
                        </div>                    
                </div>
                <div class="row">
                    
                        <div class="col-md-6 col-lg-6" >
                             <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email"
                                       class="form-control" name="email" value="${user.email}" readonly/>
                            </div>
                        </div>
                </div>
                <div class="row">
                    
                        <div class="col-md-6 col-lg-6" >
                             <div class="form-group">
                                <label for="phoneNumber">PhoneNumber</label>
                                <input type="text" id="phoneNumber"
                                       class="form-control" name="phoneNumber" value="${user.phoneNumber}"/>
                            </div>
                        </div>
                </div>
                <div class="row">
                    
                        <div class="col-md-6 col-lg-6" >
                             <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" id="address"
                                       class="form-control" name="address" value="${user.address}"/>
                            </div>
                        </div>
                </div>
                <div class="row">
                    
                        <div class="col-md-3 col-lg-3" >
                             <div class="form-group">
                                <label for="birthDate">BirthDate</label>
                                <input type="date" id="birthDate"
                                       class="form-control" name="birthDate" value="${user.birthDate}"/>
                            </div>
                        </div>
                        <div class="col-md-3 col-lg-3" >
                             <div class="form-group">
                                <label for="gender">Gender</label>
                                <select class="form-control" name="gender" id="gender">
                                    <c:forEach items="${gender}" var="g"  >
                                    <option value="${g}">${g}</option>
                                </c:forEach>
                                </select>    
                            </div>
                        </div>
                </div>
         <input type="text" name="status" value="${user.status}" hidden>
                <div class="row">
                    <div class="col-md-12 col-lg-12" >
                        <button type="submit" class="btn btn-success">
                            Update Your Profile.
                        </button>
                    </div>
                </div>
            </mvc:form>
        </div>
      </div>
     </div>
     </section>
    <jsp:include page="include/footer.jsp" /> 
     <jsp:include page="include/loader.jsp" />  
     
  </body>
</html>
