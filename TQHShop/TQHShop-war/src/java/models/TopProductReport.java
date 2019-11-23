/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package models;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author nth15
 */
public class TopProductReport {
    
    public List<Map<String,Object>> report(List<TopProductStaticModel> listProducts){
        try {
            List<Map<String,Object>> rows = new ArrayList<>();
            for (TopProductStaticModel t : listProducts) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", t.getId());
                row.put("name", t.getName());
                row.put("sold", t.getSold());
                row.put("orderIds", t.getOrderid());
                row.put("seller", t.getSeller());
                rows.add(row);
            }
            return rows;
        } catch (Exception e) {
            return null;
        }
    }
    
    public List<Map<String,Object>> reportSeller(List<SellerReportModel> listSeller){
        try {
            List<Map<String,Object>> rows = new ArrayList<>();
            for (SellerReportModel s : listSeller) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", s.getId());
                row.put("name", s.getName());
                row.put("storename", s.getStorename());
                row.put("numberproducts", s.getNumberproducts());
                row.put("numberorders", s.getNumberorders());
                rows.add(row);
            }
            return rows;
        } catch (Exception e) {
            return null;
        }
    }
    
    public List<Map<String,Object>> reportCustomer(List<CustomerReportModel> listCustomer){
        try {
            List<Map<String,Object>> rows = new ArrayList<>();
            for (CustomerReportModel c : listCustomer) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", c.getId());
                row.put("name", c.getName());
                row.put("phone", c.getPhone());
                row.put("orders", c.getNumberorders());
                row.put("comments", c.getNumbercomments());
                rows.add(row);
            }
            return rows;
        } catch (Exception e) {
            return null;
        }
    }
    
    public List<Map<String,Object>> reportOrder(List<OrderReportModel> listOrders){
        try {
            List<Map<String,Object>> rows = new ArrayList<>();
            for (OrderReportModel c : listOrders) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", c.getId());
                row.put("buyer", c.getBuyer());
                row.put("totalprice", c.getTotalprice());
                row.put("products", c.getProducts());
                row.put("status", c.getStatus());
                rows.add(row);
            }
            return rows;
        } catch (Exception e) {
            return null;
        }
    }
}
