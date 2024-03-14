<%@page import="com.mycompany.mycart.entities.User" %>
<%@page import="com.mycompany.mycart.entities.Category" %>
<%@page import="com.mycompany.mycart.dao.CategoryDao" %>
<%@page import="com.mycompany.mycart.helper.FactoryProvider" %>
<%@page import="com.mycompany.mycart.helper.Helper" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.*" %>
<%@page import="java.util.ArrayList"%>
<%
      User user =(User)session.getAttribute("current-user");
    if(user==null){
    
    
    session.setAttribute("message","you are not logged in!! loggin first");
    
     response.sendRedirect("login.jsp");
     return;
    
    }
    else{
         if(user.getUserType().equals("normal")){
                   session.setAttribute("message","you are not admin do not access this page");
    
                    response.sendRedirect("login.jsp");
                    return;
                }
                
    }
    //print
    //out.println(message);
%>
 <% 
                            CategoryDao  cdao=new CategoryDao(FactoryProvider.getFactory());
                            List<Category> list=cdao.getCategories();
                            
           //getting  count
          Map<String,Long> m= Helper.getCounts(FactoryProvider.getFactory());
           
                            
 %>





<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <link rel="stylesheet" href="css/style.css">

        <%@include file="components/common_css_js.jsp" %>
        <style>

            .custom-bg{
                background: #673ab7!important;

            }

            .admin .card{
                border: 1px solid #673ab7!important;
            }

            .admin .card:hover{

                background: #e2e2e2;
                cursor: pointer;
            }


        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container admin">
            <!-- first row -->

            <div class="container-fluid mt-3 ">
                <!-- message -->
                <%@include file="components/message.jsp" %>

            </div>
            <div class="row mt-3">

                <!-- first col -->
                <div class="col-md-4">

                    <!-- first box -->
                    <div class="card ">
                        <div class="card-body text-center">

                            <div class="container ">
                                <img style="max-width: 100px;" class="img-fluid rounded-circle" src="img/Users.png " alt="user_icon">

                            </div>
                            <h1><h1><%=m.get("userCount") %></h1></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>

                        </div>


                    </div>


                </div>
                <!-- second col -->
                <div class="col-md-4">

                    <!-- second box -->
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid rounded-circle" src="img/categories.png " alt="categories_icon">

                            </div>
                            <h1><%=list.size() %></h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>

                        </div>


                    </div>


                </div>
                <!-- third col -->
                <div class="col-md-4">
                    <!-- third box -->
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid rounded-circle" src="img/product.png " alt="product_icon">

                            </div>
                            <h1><%=m.get("productCount") %></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>

                        </div>


                    </div>

                </div>


            </div>
            <!-- second row -->
            <div class="row mt-3">


                <!-- second row first col -->
                <div class="col-md-6">

                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid rounded-circle" src="img/keys.png " alt="categories_icon">

                            </div>
                            <h1><%=list.size() %></h1>
                            <p>click here to add category</p>
                            <h1 class="text-uppercase text-muted"> Add Categories</h1>

                        </div>


                    </div>

                </div>
                <!-- second row second col -->
                <div class="col-md-6">

                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid rounded-circle" src="img/plus.png " alt="product_icon">

                            </div>
                            <h1><%=m.get("productCount") %></h1>
                            <p>click here to add product</p>
                            <h1 class="text-uppercase text-muted"> Add Products</h1>

                        </div>


                    </div>

                </div>

            </div>



        </div>

        <!-- add category modal -->


        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" name="catTitle" class="form-control" id="name"  placeholder="Enter category title here" required/>


                            </div>

                            <div class="form-group">
                                <textarea name="catDescription" style="height:200px;" class="form-control" placeholder="Enter category description"  required> </textarea>                    


                            </div>

                            <div class="container text-center "> 
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>
                        </form>
                    </div>


                </div>
            </div>
        </div>

        <!-- end category modal -->

        <!-- add product modal -->

        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill product details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addproduct">
                            <div class="form-group">
                                <input type="text" name="productName" class="form-control" id="name"  placeholder="Enter product Name" required/>


                            </div>

                            <div class="form-group">
                                <textarea name="productDescription" style="height:200px;" class="form-control" placeholder="Enter product description"  required></textarea>                    


                            </div>

                           

                            <div class="form-group">
                                <input type="number" name="productPrice" class="form-control" id="name"  placeholder="Enter product price" required/>


                            </div>

                            <div class="form-group">
                                <input type="number" name="productDiscount" class="form-control" id="name"  placeholder="Enter product discount" required/>


                            </div>

                            <div class="form-group">
                                <input type="number" name="productQuntity" class="form-control" id="name"  placeholder="Enter product quantity" required/>


                            </div>
                            
                           

                            <div class="form-group" >
                                <select name="catId" id="" class="form-conrol">
                                
                                    <%
                                      for(Category c:list){  
                                    %>
                                    
                                    <option value="<%=c.getCategoryId() %>"><%= c.getCategoryTitle() %></option>
                                    
                                <% } %>
                                </select>

                            </div>
                            
                             <div class="form-group">
                                 <label for="ppic"> select picture of product</label>
                                 <br>
                                 <input type="file" name="productpic" id="ppic" required />

                            </div>






                            <div class="container text-center "> 
                                <button class="btn btn-outline-success">Add Product</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>
                        </form>
                    </div>


                </div>
            </div>
        </div>

        <!-- add product modal -->
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
