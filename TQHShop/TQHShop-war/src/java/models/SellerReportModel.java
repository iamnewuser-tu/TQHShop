/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package models;

/**
 *
 * @author nth15
 */
public class SellerReportModel {
    private String id;
    private String name;
    private String storename;
    private int numberorders;
    private int numberproducts;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStorename() {
        return storename;
    }

    public void setStorename(String storename) {
        this.storename = storename;
    }

    public int getNumberorders() {
        return numberorders;
    }

    public void setNumberorders(int numberorders) {
        this.numberorders = numberorders;
    }

    public int getNumberproducts() {
        return numberproducts;
    }

    public void setNumberproducts(int numberproducts) {
        this.numberproducts = numberproducts;
    }
}
