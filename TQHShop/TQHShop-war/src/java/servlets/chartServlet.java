/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package servlets;

import com.google.gson.Gson;
import entities.OrderMasterFacadeLocal;
import entities.ProductsFacadeLocal;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.ChartModel;

/**
 *
 * @author nth15
 */
@WebServlet("/chart")
public class chartServlet extends HttpServlet {
    @EJB
    private ProductsFacadeLocal productsFacade;
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
            /* TODO output your page here. You may use following sample code. */
            response.setContentType("text/html;charset=UTF-8");
                    Calendar cal = Calendar.getInstance();
                    int year = cal.get(cal.YEAR) - 1;
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String beforemonth =(year+1) +  "-01-01" ;
                    String aftermonth;
                    Gson gson = new Gson();
                    int[] datasProduct = new int[12];
                    int[] datasOrder = new int[12];
                    try {
                        for (int i=12; i > 0 ; i--) {
                        StringBuilder sb = new StringBuilder();
                        sb.append(year);
                        sb.append("-");
                        sb.append(String.format("%02d", i));
                        sb.append("-01");
                        aftermonth = sb.toString();
                        datasProduct[i-1] = (int) productsFacade.countProductsByMonth(sdf.parse(aftermonth), sdf.parse(beforemonth));
                        datasOrder[i-1] = (int) orderMasterFacade.countOrderByMonth(sdf.parse(aftermonth), sdf.parse(beforemonth));
                        beforemonth = aftermonth;
                    }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    ChartModel modelProducts = new ChartModel();
                    modelProducts.setName("Products");
                    modelProducts.setData(datasProduct);
                    ChartModel modelOrders = new ChartModel();
                    modelOrders.setName("Orders");
                    modelOrders.setData(datasOrder);
                    List<ChartModel> chart = new ArrayList<>();
                    chart.add(modelProducts);
                    chart.add(modelOrders);
                    String jsonChart = gson.toJson(chart);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(jsonChart);
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
