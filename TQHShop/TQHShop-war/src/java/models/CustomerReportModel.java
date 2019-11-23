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
public class CustomerReportModel {
    
    private String id;
    private String name;
    private String phone;
    private int numberorders;
    private int numbercomments;

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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getNumberorders() {
        return numberorders;
    }

    public void setNumberorders(int numberorders) {
        this.numberorders = numberorders;
    }

    public int getNumbercomments() {
        return numbercomments;
    }

    public void setNumbercomments(int numbercomments) {
        this.numbercomments = numbercomments;
    }
    
}
