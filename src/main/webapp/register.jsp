<%-- 
    Document   : register
    Created on : Jan 8, 2024, 5:36:10 PM
    Author     : Govinda Kohli
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
          <%@include file="components/navbar.jsp" %>
          <div class="container-fluid">
              <div class="row mt-5">
              <div class="col-md-4 offset-md-4"  >
                  <div class="card">
                      <%@include file="components/message.jsp" %>
                      <div class="card-body">
                          <h3 class=" text-center my-3">Sign up here!!</h3>
                          <form action="RegisterServlet" method="post" >
                      <div class="form-group"  >
                          <label for="name">User Name</label>
                          <input type="text" name="user_name" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter here">
                    
                      </div>
                      <div class="form-group"  >
                          <label for="email"> User Email</label>
                          <input type="email" name="user_email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter here">
                    
                      </div>
                      <div class="form-group"  >
                          <label for="password"> User Password</label>
                          <input type="password" name="user_password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter here">
                    
                      </div>
                      <div class="form-group"  >
                          <label for="phone"> User Phone</label>
                          <input name="user_phone" type="number"  class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter here">
                    
                      </div>
                      <div class="form-group"  >
                          <label for="address"> User Address</label>
                          <textarea name="user_address" style="height:120px;" class="form-control" placeholder="Enter your address here" > </textarea>                    
                      </div>
                      
                      <div class="container text-center">
                          
                          <button class="btn btn-outline-success"> Register</button>
                          
                          <a href="login.jsp" class="text-center d-block mb-4"> Login here</a>
                          
                          
                      </div>
                    
                      
                  </form>
                   
                          
                          
                      </div>
                      
                      
                  </div>
                  
              </div>
          
          
          
          
          </div>
              
              
              
          </div>
    </body>
</html>
