<%@page import="com.mycompany.mycart.entities.Product" %>
<%@page import="com.mycompany.mycart.dao.ProductDao" %>
<%@page import="com.mycompany.mycart.helper.FactoryProvider"%>
<%@page import="com.mycompany.mycart.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="jakarta.servlet.http.Part" %>
<%@page import="jakarta.servlet.http.HttpServlet" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="java.io.File" %>
<%@page import="java.io.FileOutputStream" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.IOException" %>
<%@page import="javax.imageio.stream.FileImageInputStream" %>
<%@page import="jakarta.servlet.annotation.MultipartConfig" %>
<%@page import="com.mycompany.mycart.entities.Category" %>
<%@page import="com.mycompany.mycart.dao.CategoryDao" %>
<%@page import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>my cart</title>
        <%@include file="components/common_css_js.jsp" %>
        <style>
            
         .product-card:hover{
          background: #e2e2e2;
          cursor: pointer;
         }
         
         
            
              </style>

    </head>
    <body>

        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">




            <div class="row mt-3 mx-2">

                <% 
                    String cat = request.getParameter("category");
                     //out.println(cat);
                 
                    ProductDao dao=new ProductDao(FactoryProvider.getFactory());
               
               
                     List<Product> list=null;
                 
                 
                      if(cat==null ||cat.trim().equals("all")){
                     list=dao.getAllProducts();
                    }
                     else {
                    int cid= Integer.parseInt(cat.trim());
                    list= dao.getAllProductsById(cid);
                    }
                 //List<Product> list=dao.getAllProducts();
                
          
                  
             
                   
                   
                   
                CategoryDao  cdao=new CategoryDao(FactoryProvider.getFactory());
                 List<Category> clist=cdao.getCategories();
            
            
            
                %>
                <!-- show categories -->
                <div class="col-md-2">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                            All products

                        </a>





                        <% 
                 
                    for(Category category:clist){
                 
                 
                        %>
                        <a href="index.jsp?category=<%=category.getCategoryId()  %>" class="list-group-item list-group-item-action"><%=category.getCategoryTitle() %></a>

                        <%
                            }
                 
                 
                        %>

                    </div>
                </div>
                <!-- show products -->
                <div class="col-md-10">
                    <!-- row -->
                    <div class="row mt-4">
                        <!-- col:12 grid -->
                        <div class="col-md-12">
                            <div class="card-columns">
                                <!-- traversing product -->
                                <% 
                             
                                for(Product p:list){
                          
                                %>
                                <!-- product -->
                                <div class="card product-card">
                                    <div class="container text-center">
                                        <img  src="img/products/<%=p.getpPhoto() %>" style="max-height: 200px; max-width: 100%; width: auto;" class="card-img-top " alt="...">


                                    </div>
                                    <div class="card-body">
                                        <h5 class="card_title"><%=p.getpName() %></h5>

                                        <p class="card-text">

                                            <%= Helper.get10Words(p.getpDesc()) %>


                                        </p>

                                    </div>

                                    <div class="card-footer text-center">

                                        <button class="btn custom-bg text-white " onclick="add_to_cart(<%=p.getpId() %>,'<%=p.getpName() %>',<%= p.getPricetAfterApplyingDiscount()%>)"> Add to cart</button>
                                        <button class="btn btn-outline-success ">&#8360;<%=p.getPricetAfterApplyingDiscount()%>/- <span class="text-secondary discount-label">&#8360;<%=p.getpPrice() %> <%=p.getpDiscount() %>% off</span></button>




                                    </div>     



                                </div>

                                <% }
                                if(list.size()==0){
                                 out.println("<h3> No item available</h3>");
   }
                             
                                %>

                            </div>



                        </div>



                    </div>


                </div>


            </div>
        </div>
              
    <%@include file="components/common_modals.jsp" %>
    </body>
</html>
