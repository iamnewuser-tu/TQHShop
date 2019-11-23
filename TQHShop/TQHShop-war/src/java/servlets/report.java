/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class report extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = (String) request.getAttribute("action");
        String model = (String) request.getAttribute("model");
        switch (action) {
            case "report 2":
                //read Pdf
                readReportPdf(request, response, model);
                break;
        }
        
    }

    protected void readReportPdf(HttpServletRequest request, HttpServletResponse response, String model) throws FileNotFoundException, IOException {
        StringBuilder sb = new StringBuilder();
        sb.append("reportTemplate/");
        sb.append(model);
        
        //report-- Change this path.
        String reportpath = request.getServletContext().getRealPath(sb.toString());
        String imagePath = request.getServletContext().getRealPath("resource/themes/images/banner1.png");
        File filePDF = new File(reportpath);
        FileInputStream fis = new FileInputStream(filePDF);
        try {
            JasperReport jasperReport = JasperCompileManager.compileReport(fis);
            Map<String, Object> reportImage = new HashMap<>();
            reportImage.put("reportImage", imagePath);
            List<Map<String,Object>> rows = (List<Map<String,Object>>) request.getAttribute("products");
            JRDataSource jRDataSource = new JRBeanCollectionDataSource(rows);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, reportImage, jRDataSource);
            JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
        } catch (JRException ex) {
            Logger.getLogger(report.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            response.getOutputStream().flush();
            response.getOutputStream().close();
        }

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
