/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Embeddable
public class OrderDetailsPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "orderMId", nullable = false, length = 10)
    private String orderMId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "productId", nullable = false, length = 10)
    private String productId;

    public OrderDetailsPK() {
    }

    public OrderDetailsPK(String orderMId, String productId) {
        this.orderMId = orderMId;
        this.productId = productId;
    }

    public String getOrderMId() {
        return orderMId;
    }

    public void setOrderMId(String orderMId) {
        this.orderMId = orderMId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderMId != null ? orderMId.hashCode() : 0);
        hash += (productId != null ? productId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderDetailsPK)) {
            return false;
        }
        OrderDetailsPK other = (OrderDetailsPK) object;
        if ((this.orderMId == null && other.orderMId != null) || (this.orderMId != null && !this.orderMId.equals(other.orderMId))) {
            return false;
        }
        if ((this.productId == null && other.productId != null) || (this.productId != null && !this.productId.equals(other.productId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.OrderDetailsPK[ orderMId=" + orderMId + ", productId=" + productId + " ]";
    }
    
}
