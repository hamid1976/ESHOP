/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.mycart.servlets;

import com.mycompany.mycart.dao.CategoryDao;
import com.mycompany.mycart.dao.ProductDao;
import com.mycompany.mycart.entities.Category;
import com.mycompany.mycart.entities.Product;
import com.mycompany.mycart.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.imageio.stream.FileImageInputStream;




@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           String op=request.getParameter("operation");
           
           if(op.trim().equals("addcategory")){
                //add category
               //fetching category data
                String title=  request.getParameter("catTitle");
                String description= request.getParameter("catDescription");
                
                Category category=new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);
                
                // category database save:
                CategoryDao categorydao=new CategoryDao(FactoryProvider.getFactory());
                int catId=categorydao.saveCategory(category);
                //out.println("category saved");
               HttpSession httpsession=request.getSession();
               httpsession.setAttribute("message", "category added successfully:" +catId);
               response.sendRedirect("admin.jsp");
               return;
           }
           else if(op.trim().equals("addproduct")){
               //add product
               
             String pName=   request.getParameter("productName");
             String pDesc=   request.getParameter("productDescription");
             int pPrice=Integer.parseInt(request.getParameter("productPrice"));
             int pDiscount=Integer.parseInt(request.getParameter("productDiscount"));
             int pQuantity=Integer.parseInt(request.getParameter("productQuntity"));
             int catId=Integer.parseInt(request.getParameter("catId"));
             Part part=request.getPart("productpic");
             
             Product p=new Product();
             p.setpName(pName);
             p.setpDesc(pDesc);
             p.setpPrice(pPrice);
             p.setpDiscount(pDiscount);
             p.setpQuantity(pQuantity);
             p.setpPhoto(part.getSubmittedFileName());
             
             //get category by id
             CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
             Category category=cdao.getCategoryById(catId);
             
             p.setCategory(category);
             
             //save product in db 
             ProductDao pdao=new ProductDao(FactoryProvider.getFactory());
             pdao.saveProduct(p);
            
            // upload photo
            //find out the path upload photo
            
            //request.getRealPath("img");
            String path=getServletContext().getRealPath("img")+File.separator +"products"+File.separator+ part.getSubmittedFileName();
            System.out.println(path);
            
            //uploading code
            
               try {
                    FileOutputStream fos=new FileOutputStream(path);
               
               InputStream is=part.getInputStream();
               // reading data
               
               byte[] data=new byte[is.available()];
               is.read(data);
               
               // writting data
               fos.write(data);
               fos.close();
               } catch (Exception e) {
                   e.printStackTrace();
               }
              
            
            
             
             
             //out.println("product saved sucessfully");
             
             HttpSession httpsession=request.getSession();
               httpsession.setAttribute("message", "product is added successfully!");
               response.sendRedirect("admin.jsp");
               return;
             
               
             
           }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
