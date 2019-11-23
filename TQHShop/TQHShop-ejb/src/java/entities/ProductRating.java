/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "ProductRating", catalog = "TQHShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProductRating.findAll", query = "SELECT p FROM ProductRating p"),
    @NamedQuery(name = "ProductRating.findByProductId", query = "SELECT p FROM ProductRating p WHERE p.productRatingPK.productId = :productId"),
    @NamedQuery(name = "ProductRating.findByRatingPoint", query = "SELECT p FROM ProductRating p WHERE p.productRatingPK.ratingPoint = :ratingPoint"),
    @NamedQuery(name = "ProductRating.findByCount", query = "SELECT p FROM ProductRating p WHERE p.count = :count")})
public class ProductRating implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProductRatingPK productRatingPK;
    @Column(name = "count")
    private Integer count;
    @JoinColumn(name = "productId", referencedColumnName = "productId", nullable = false, insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Products products;

    public ProductRating() {
    }

    public ProductRating(ProductRatingPK productRatingPK) {
        this.productRatingPK = productRatingPK;
    }

    public ProductRating(String productId, int ratingPoint) {
        this.productRatingPK = new ProductRatingPK(productId, ratingPoint);
    }

    public ProductRatingPK getProductRatingPK() {
        return productRatingPK;
    }

    public void setProductRatingPK(ProductRatingPK productRatingPK) {
        this.productRatingPK = productRatingPK;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Products getProducts() {
        return products;
    }

    public void setProducts(Products products) {
        this.products = products;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productRatingPK != null ? productRatingPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductRating)) {
            return false;
        }
        ProductRating other = (ProductRating) object;
        if ((this.productRatingPK == null && other.productRatingPK != null) || (this.productRatingPK != null && !this.productRatingPK.equals(other.productRatingPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProductRating[ productRatingPK=" + productRatingPK + " ]";
    }
    
}
