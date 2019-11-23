/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import entities.Customers;
import entities.CustomersFacadeLocal;
import entities.Seller;
import entities.SellerFacadeLocal;
import entities.Users;
import entities.UsersFacadeLocal;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nth15
 */
public class addCustomerServlet extends HttpServlet {

    @EJB
    private SellerFacadeLocal sellerFacade;
    @EJB
    private CustomersFacadeLocal customersFacade;
    @EJB
    private UsersFacadeLocal usersFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            Users user = (Users) request.getSession().getAttribute("user");
            switch (action) {
                case "register":
                    String idRegist = request.getParameter("txtUsername");
                    Users userRegist = usersFacade.find(idRegist);
                    if (userRegist != null) {
                        request.setAttribute("message", "Username already exists!");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                        break;
                    }
                    userRegist = new Users();
                    userRegist.setUserId(idRegist);
                    userRegist.setPassword(request.getParameter("txtPassword"));
                    userRegist.setEmail(request.getParameter("txtEmail"));
                    userRegist.setFullname(request.getParameter("txtFullname"));
                    userRegist.setPhone(request.getParameter("txtPhone"));
                    String roleRegist = request.getParameter("role");
                    userRegist.setRole(roleRegist);
                    userRegist.setUserStatus(true);
                    usersFacade.create(userRegist);

                    request.setAttribute("user", userRegist);
                    request.setAttribute("registMess", "Registration successful!");
                    if (roleRegist.equals("customer")) {
                        Customers cusRegist = new Customers(idRegist);
                        cusRegist.setPoint(0);
                        cusRegist.setAddress("");
                        cusRegist.setDob("1/1/1950");
                        cusRegist.setGender("male");
                        customersFacade.create(cusRegist);
                        request.getRequestDispatcher("customer.jsp").forward(request, response);
                    } else if (roleRegist.equals("seller")) {
                        Seller sellRegist = new Seller(idRegist);
                        sellRegist.setStoreIcon("http://simpleicon.com/wp-content/uploads/shop-5-64x64.png");
                        sellRegist.setApprovedDate(" ");
                        sellerFacade.create(sellRegist);
                        request.getRequestDispatcher("home.jsp").forward(request, response);
                    }
                    break;
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
