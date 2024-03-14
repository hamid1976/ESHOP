/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.mycart.servlets;

import com.mycompany.mycart.dao.UserDao;
import com.mycompany.mycart.entities.User;
import com.mycompany.mycart.helper.FactoryProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


public class LoginServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            //coding
           String email= request.getParameter("email");
           String password= request.getParameter("password");
           //validation
           
           
           //authenticate
              UserDao userdao=  new UserDao(FactoryProvider.getFactory());
            User user=  userdao.getUserByEmailAndPassword(email, password);
            
            //System.out.println(user);
            HttpSession httpsession=request.getSession();
            
            if(user==null){
                //out.println("<h1> Invalid Detail </h1>");
                httpsession.setAttribute("message", "Invalid detail try with another");
                response.sendRedirect("login.jsp");
                return;
            }else {
                out.println("<h1> Wellcome "+user.getUserName()+"</h1>");
                //login
                
                httpsession.setAttribute("current-user", user);
                
                if(user.getUserType().equals("admin")){
                    // admin :admin.jsp
                    response.sendRedirect("admin.jsp");
                }else if(user.getUserType().equals("normal")){
                    // normal: normal.jsp
                    response.sendRedirect("normal.jsp");
                }else{
                    out.println("we are not identified user type");
                }
                
                
                
                
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
