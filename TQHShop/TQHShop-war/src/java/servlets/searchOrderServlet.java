/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import entities.Categories;
import entities.CategoriesFacadeLocal;
import entities.OrderDetails;
import entities.OrderMaster;
import entities.OrderMasterFacadeLocal;
import entities.Products;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.TQHShopUtils;

/**
 *
 * @author nth15
 */
public class searchOrderServlet extends HttpServlet {
    @EJB
    private CategoriesFacadeLocal categoriesFacade;
    @EJB
    private OrderMasterFacadeLocal orderMasterFacade;

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            switch(action){
                case "orderDetailCustomer":
                    List<Categories> listCategories = categoriesFacade.showActiveCategories();
                    List<Products> listProducts = new ArrayList<>();
                    String orderID = request.getParameter("orderID");
                    OrderMaster ODM =  orderMasterFacade.find(orderID);       
                    List<OrderDetails> listOrderDetail = (List<OrderDetails>) ODM.getOrderDetailsCollection();
                    for (OrderDetails orderDetails : listOrderDetail) {
                        listProducts.add(orderDetails.getProducts());
                    }
                    request.setAttribute("OrderMaster", ODM);
                    request.setAttribute("ListProduct", TQHShopUtils.buidProductIndexModel(listProducts));
                    request.setAttribute("listCategories", listCategories);
                    request.getRequestDispatcher("customerOrderDetail.jsp").forward(request, response);
                    break;
                default:
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
