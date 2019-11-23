/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import com.google.gson.Gson;
import entities.OrderMaster;
import entities.OrderMasterFacadeLocal;
import entities.Users;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import utils.SendEmailUtils;

/**
 *
 * @author nth15
 */
public class editOrderServlet extends HttpServlet {

    @EJB
    private OrderMasterFacadeLocal orderMasterFacade;

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
            String orderId = request.getParameter("oid");
            OrderMaster order = orderMasterFacade.find(orderId);
            Users user = (Users) request.getSession().getAttribute("user");
            if (user == null ) {
                request.setAttribute("message", "Please login again if you are admin");
                request.getRequestDispatcher("viewServlet?action=showOrder&page=1").forward(request, response);
            }
            String adminEmail = "techline01012019@gmail.com";
            String password = "Lalabaylen";
            String userEmail = order.getUserId().getEmail();
            String resultString = "Done";
            switch(action) {
                case "changeOrder":
                    
                    String status = request.getParameter("status");
                    String newStatus = "";
                    
                    switch (status) {
                        case "Processing":
                            newStatus = "Delivery";
                            resultString = SendEmailUtils.sendMail(adminEmail, password, userEmail, "Your Order Are Being Delivered", buildContent(order.getUserId(),order,"Delivery"));
                            break;
                        case "Delivery":
                            resultString = SendEmailUtils.sendMail(adminEmail, password, userEmail, "Your Order Are Completed", buildContent(order.getUserId(),order,"Done"));
                            newStatus = "Done";
                            break;
                        default:
                            break;
                    }
                    if (!StringUtils.equals(resultString, "Done")) {
                        request.setAttribute("message", "Send Mail Failed. Please update your email in account");
                        request.getRequestDispatcher("viewServlet?action=showOrder&page=1").forward(request, response);
                        break;
                    }
                    order.setOrderStatus(newStatus);
                    orderMasterFacade.edit(order);
                    request.getRequestDispatcher("viewServlet?action=showOrder&page=1").forward(request, response);
                    break;
                case "cancelOrder":
                    order.setOrderStatus("Cancel");
                    orderMasterFacade.edit(order);
                    SendEmailUtils.sendMail(adminEmail, password, userEmail, "Your Order Are Canceled", buildContent(user,order,"Delivery"));
                    request.getRequestDispatcher("viewServlet?action=showOrder").forward(request, response);
                    break;
                default:
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

    private String buildContent(Users user,OrderMaster order, String status) {
        String content= "";
        StringBuilder sb = new StringBuilder();
        sb.append("Dear Mr/Mrs/Miss ");
        sb.append(user.getFullname());
        sb.append(",\n\n");
        sb.append("Your Order Number ");
        sb.append(order.getOrderMId());
        sb.append(" has ");
        switch (status) {
            case "Delivery":
                sb.append("completed verifying process. Our shippers will contact you around 24 hours");
                break;
            case "Done":
                sb.append("been completed. Hope you enjoyed your ordered");
                break;
            case "Cancel":
                sb.append("been cancled. We're sorry for this inconvience. We have to close your order. Please if you have any feedback, please contact us.");
                break;
        }
        sb.append("\nThank you for using our services.\nTechLine");
        content = sb.toString();
        return content;
    }

}
