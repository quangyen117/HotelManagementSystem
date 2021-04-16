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
    <script src="<c:url value="/resources/js/credit.js"/>"></script>
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
              <h1>Confirm Your Payment</h1>
            </div>

          </div>
        </div>
      </div>
    </section>
      <!-- End section -->
    <c:if test="${mes != null && mes!=''}">           
                <div class="row">
                     <div class="col-md-12 col-lg-12">
                            <div class="alert alert-danger" role="alert">
                                <center><h4>${mes}</h4></center>
                            </div>
                     </div>      
                </div>
            </c:if>
      
    <section class="site-section">
          <div class="container">
            <div class="row">
                <h3>Credit Card</h3>
            </div>
            <div class="row">
                <div align="left" height="50%" width="40%">
                    <form action="${pageContext.request.contextPath}/pay" method="post" 
                                           id="demoForm">
                        <input type="text" name="code" value="${code}" hidden>
                                    <table class="table table-striped table-hover">
                                            <tr>
                                                <td><label for="name">User Name:</label></td>
                                                <td><input type="text" name="name" id="name"
                                                            placeholder="Enter username" required></td>  
                                            </tr>
                                            <tr>
                                                <td><label for="cardNumber">Card Number:</label></td>
                                                    <td><input type="text" name="cardNumber" id="cardNumber" 
                                                            placeholder="Enter Card number" required>
                                                            </td>
                                            </tr>
                                            <tr>
                                                <td><label for="expDate" >Date Of Expiry:</label></td>
                                                <td>
<!--                                                            <input type="date" name="expDate" id="expDate" placeholder="dd/MM/yyyy"
                                                                   hidden>-->
                                                            <!--<input  type="month" name="monthExp" id="monthExp" placeholder="MM/yyyy" required>-->
                                                            <select  name="monthExp" id="monthExp">
                                                                <option value="01">01</option>
                                                                <option value="02">02</option>
                                                                <option value="03">03</option>
                                                                <option value="04">04</option>
                                                                <option value="05">05</option>
                                                                <option value="06">06</option>
                                                                <option value="07">07</option>
                                                                <option value="08">08</option>
                                                                <option value="09">09</option>
                                                                <option value="10">10</option>
                                                                <option value="11">11</option>
                                                                <option value="12">12</option>
                                                            </select>
                                                            <select  name="yearExp" id="yearExp">
                                                                <option value="2021">2021</option>
                                                                <option value="2022">2022</option>
                                                                <option value="2023">2023</option>
                                                                <option value="2024">2024</option>
                                                                <option value="2025">2025</option>
                                                                <option value="2026">2026</option>
                                                                <option value="2027">2027</option>
                                                            </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><label for="cvcCode">CVC Code:</label></td>
                                                <td><input type="password" name="cvcCode" id="cvcCode" placeholder="Enter cvcCode" maxlength="3"
                                                            required></td>
                                            </tr>
                                            <tr>
                                                    <td><input type="submit" value="Payment"
                                                            style="height: 30px; width: 100px" class="glowing-border"></td>
                                            </tr>
                                    </table>
                    <form>
                    </div> 
            </div>
          </div>
    </section>
    
    <jsp:include page="include/footer.jsp" /> 
     
    <jsp:include page="include/loader.jsp" />  
      
<!--    <script type="text/javascript">   
    $(function expDate() {
    var monthExp =$("#monthExp").val();
    var yearExp =$("#yearExp").val();
    var expDate = "01/".concat(monthExp,"/",yearExp);
console.log(expDate);
  $('#expDate').val(expDate);
});
    </script>-->
  </body>
</html>
