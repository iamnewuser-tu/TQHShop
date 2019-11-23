/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import entities.OrderDetails;
import entities.Products;
import java.io.File;
import java.math.RoundingMode;
import java.sql.Connection;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.ProductIndexModel;
import models.ProductListAdminModel;
import models.TopProductModel;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

/**
 *
 * @author nth15
 */
public class TQHShopUtils {

    public static List<ProductIndexModel> buidProductIndexModel(List<Products> listProduct) {
        List<ProductIndexModel> listResult = new ArrayList<>();
        List<String> listImages = new ArrayList<>();
        for (Products item : listProduct) {
            ProductIndexModel model = buildProduct(item);
            listResult.add(model);
        }
        if (!listResult.isEmpty()) {
            return listResult;
        }
        return null;
    }

    public static ProductIndexModel buildProduct(Products item) {
        List<String> listImages = new ArrayList<>();
        ProductIndexModel model = new ProductIndexModel();
        model.setProductId(item.getProductId());
        model.setProductName(item.getProductName());
        model.setProductPrice(item.getProductPrice());
        for (String image : item.getProductImage().split(",")) {
            listImages.add(image);
        }
        model.setProductImage(listImages);
        model.setBrandName(item.getBrandId().getBrandName());
        model.setProductHeigth(item.getProductHeigth());
        model.setProductLength(item.getProductLength());
        model.setProductWidth(item.getProductWidth());
        model.setProductWeight(item.getProductWeight());
        model.setProductQuantity(item.getProductQuantity());
        model.setProductDesc(item.getProductDesc());
        model.setProductSummary(item.getProductSummary());
        model.setProductsCommentCollection(item.getProductsCommentCollection());
        DecimalFormat df = new DecimalFormat("#.##");
        df.setRoundingMode(RoundingMode.UP);
        model.setProductRating(df.format(item.getProductRating()));
        double discountPrice = (item.getProductPrice() * item.getProductDiscount()) / 100;
        model.setProductDiscount(discountPrice);
        return model;
    }
    
    public static List<ProductListAdminModel> buildProductAdmin(List<Products> listProduct) {
        List<ProductListAdminModel> list = new ArrayList<>();
        for (Products p : listProduct) {
            ProductListAdminModel pro = buildProductAdmin(p);
            if (pro != null) {
                list.add(pro);
            }
        }
        return list;
    }
    
    public static ProductListAdminModel buildProductAdmin(Products item) {
        ProductListAdminModel p = new ProductListAdminModel();
        List<String> listImages = new ArrayList<>();
        p.setId(item.getProductId());
        p.setBrand(item.getBrandId().getBrandId());
        for (String image : item.getProductImage().split(",")) {
            listImages.add(image);
        }
        if (!listImages.isEmpty()) {
            p.setImage(listImages.get(0));
        }
        p.setName(item.getProductName());
        p.setQuantity(item.getProductQuantity());
        p.setProductStatus(item.getProductStatus().toString());
        String userId = item.getUserId().getUserId();
        if ("admin".equals(userId) || "raejas".equals(userId) || "venky".equals(userId) || "uypoko".equals(userId)) {
            p.setRole("admin");
        }
        else {
            p.setRole(userId);
        }
        return p;
    }
    
    public static List<TopProductModel> buildProductTop(List<Products> listProduct) {
        List<TopProductModel> list = new ArrayList<>();
        for (Products p : listProduct) {
            TopProductModel top = buildTopProduct(p);
            if (top != null) {
                list.add(top);
            }
        }
        Collections.sort(list,new Comparator<TopProductModel>(){
            @Override
            public int compare(TopProductModel o1, TopProductModel o2) {
                return o2.getQuantity() - o1.getQuantity();
            }
        });
        return list;
    }
    
    public static TopProductModel buildTopProduct(Products item) {
        TopProductModel top = new TopProductModel();
        List<String> listImages = new ArrayList<>();
        top.setId(item.getProductId());
        top.setName(item.getProductName());
        top.setPrice(item.getProductPrice());
        int sold = 0;
        List<OrderDetails> listOrder = (List<OrderDetails>) item.getOrderDetailsCollection();
        for (OrderDetails o : listOrder) {
            sold += o.getQuantity();
        }
        top.setQuantity(sold);
        top.setSeller(item.getUserId().getUserId());
        for (String image : item.getProductImage().split(",")) {
            listImages.add(image);
        }
        if (!listImages.isEmpty()) {
            top.setImage(listImages.get(0));
        }
        top.setPrice(item.getProductPrice());
        return top;
    }
    
    public void generatePdfReport(String inputTemplatePath, String inputTemplateName, String outputPdfPath, String outputPdfName) {
        ReportConnection myConnection = new ReportConnection();
        Connection connection = null;
        try {
            //String reportPath = "E:\\Projects\\TQHShop-war\\web\\adminReportUser2.jrxml";
            String reportTemplatePath = inputTemplatePath + inputTemplateName + ".jrxml";
            JasperReport jasperReport = JasperCompileManager.compileReport(reportTemplatePath);

            Map<String, Object> parameters = new HashMap<String, Object>();

            //Data Source
            connection = myConnection.connect();

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);
            //outPut
            String outputPath = outputPdfPath;
            File outDir = new File(outputPath);
            outDir.mkdirs();

            //export to PDF
            JasperExportManager.exportReportToPdfFile(jasperPrint, outputPath + outputPdfName + ".pdf");

            System.out.println("Done!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getPathByProject(HttpServletRequest request, HttpServletResponse response) {
        String reportSrcFile = request.getSession().getServletContext().getRealPath("/");
        String[] listPath = reportSrcFile.split("\\\\");

        List<String> lsData = Arrays.asList(listPath);
        StringBuilder returnString = new StringBuilder();
        for (int i = 0; i < lsData.size() - 4; i++) {
            returnString.append(lsData.get(i)).append("\\");
        }
        return returnString.toString();
    }
    
    public String getIgnoreProducts(List<Products> listIgnore) {
        StringBuilder sb = new StringBuilder();
        String ignoreIds="";
        for (Products p : listIgnore) {
            sb.append("'");
            sb.append(p.getProductId());
            sb.append("',");
        }
        ignoreIds = sb.toString();
        if (!ignoreIds.isEmpty()) {
            return ignoreIds.substring(0, ignoreIds.length() -1 );
        }
        return ignoreIds;
    }
    
}
