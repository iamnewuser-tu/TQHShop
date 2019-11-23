/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import entities.Products;
import entities.ProductsFacadeLocal;
import entities.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.ProductInCart;
import org.apache.commons.lang3.StringUtils;

/**
 *
 * @author nth15
 */
public class deleteOrderServlet extends HttpServlet {
    @EJB
    private ProductsFacadeLocal productsFacade;

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
            Users user = (Users) session.getAttribute("user");
            String userId = user.getUserId();
            List<ProductInCart> cart = (List<ProductInCart>) session.getAttribute("cart");
            switch (action) {
                case "removeFromCart":
                    String id = request.getParameter("idProduct");
                    Products currentP = productsFacade.find(id);
                    boolean isExisted = false;
                    ProductInCart pInCart = new ProductInCart();
                    if (cart != null) {
                        for (ProductInCart p : cart ) {
                            if (p != null && StringUtils.equals(p.getProductId(), id)) {
                                cart.remove(p);
                                isExisted = true;
                                break;
                            }
                        }
                    }
                    else {
                        cart = new ArrayList<>();
                    }
                    if (!isExisted) {
                        request.setAttribute("mess", "Cart Empty");
                    }
                    
                    session.setAttribute("user", user);
                    session.setAttribute("cart", cart);
                    request.getRequestDispatcher("viewServlet?action=viewShoppingCart").forward(request, response);
                    break;
                default:
                    request.setAttribute("error", "Page not found");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
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
