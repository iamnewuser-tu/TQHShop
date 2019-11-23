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
public class ProductRatingPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "productId", nullable = false, length = 10)
    private String productId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ratingPoint", nullable = false)
    private int ratingPoint;

    public ProductRatingPK() {
    }

    public ProductRatingPK(String productId, int ratingPoint) {
        this.productId = productId;
        this.ratingPoint = ratingPoint;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public int getRatingPoint() {
        return ratingPoint;
    }

    public void setRatingPoint(int ratingPoint) {
        this.ratingPoint = ratingPoint;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productId != null ? productId.hashCode() : 0);
        hash += (int) ratingPoint;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductRatingPK)) {
            return false;
        }
        ProductRatingPK other = (ProductRatingPK) object;
        if ((this.productId == null && other.productId != null) || (this.productId != null && !this.productId.equals(other.productId))) {
            return false;
        }
        if (this.ratingPoint != other.ratingPoint) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProductRatingPK[ productId=" + productId + ", ratingPoint=" + ratingPoint + " ]";
    }
    
}
