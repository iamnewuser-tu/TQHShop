/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Date;
import java.text.DateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import entities.OrderMasterFacadeLocal;
import entities.Users;
import javax.ejb.EJB;

/**
 *
 * @author tatyuki1209
 */
public class searchOrderList extends HttpServlet {
    @EJB
    private OrderMasterFacadeLocal orderMasterFacade;

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Gson gson = new com.google.gson.GsonBuilder().create();
            String strDate = request.getParameter("dateO");
            DateFormat format = new java.text.SimpleDateFormat("dd-mm-yyyy");
            Users user = (Users) request.getSession().getAttribute("user");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try {
                if (!strDate.equalsIgnoreCase("")) {
                    Date date = format.parse(strDate);
                    format = new java.text.SimpleDateFormat("yyyy-mm-dd");
                    strDate = format.format(date);
                }
                List<Object> oMList = orderMasterFacade.searchOrderMastersByDate(user.getUserId(), strDate);
                String json = gson.toJson(oMList);
                response.getWriter().write(json);

            } catch (Exception e) {
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
