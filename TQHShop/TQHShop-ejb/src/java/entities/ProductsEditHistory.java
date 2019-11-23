/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author nth15
 */
@Entity
@Table(name = "ProductsEditHistory", catalog = "TQHShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProductsEditHistory.findAll", query = "SELECT p FROM ProductsEditHistory p"),
    @NamedQuery(name = "ProductsEditHistory.findByProductId", query = "SELECT p FROM ProductsEditHistory p WHERE p.productsEditHistoryPK.productId = :productId"),
    @NamedQuery(name = "ProductsEditHistory.findByVersion", query = "SELECT p FROM ProductsEditHistory p WHERE p.productsEditHistoryPK.version = :version"),
    @NamedQuery(name = "ProductsEditHistory.findByProductName", query = "SELECT p FROM ProductsEditHistory p WHERE p.productName = :productName"),
    @NamedQuery(name = "ProductsEditHistory.findByProductPrice", query = "SELECT p FROM ProductsEditHistory p WHERE p.productPrice = :productPrice"),
    @NamedQuery(name = "ProductsEditHistory.findByProductDiscount", query = "SELECT p FROM ProductsEditHistory p WHERE p.productDiscount = :productDiscount"),
    @NamedQuery(name = "ProductsEditHistory.findByEditTime", query = "SELECT p FROM ProductsEditHistory p WHERE p.editTime = :editTime")})
public class ProductsEditHistory implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProductsEditHistoryPK productsEditHistoryPK;
    @Size(max = 500)
    @Column(name = "productName", length = 500)
    private String productName;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "productPrice", precision = 53)
    private Double productPrice;
    @Column(name = "productDiscount")
    private Integer productDiscount;
    @Basic(optional = false)
    @NotNull
    @Column(name = "editTime", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date editTime;
    @JoinColumn(name = "productId", referencedColumnName = "productId", nullable = false, insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Products products;

    public ProductsEditHistory() {
    }

    public ProductsEditHistory(ProductsEditHistoryPK productsEditHistoryPK) {
        this.productsEditHistoryPK = productsEditHistoryPK;
    }

    public ProductsEditHistory(ProductsEditHistoryPK productsEditHistoryPK, Date editTime) {
        this.productsEditHistoryPK = productsEditHistoryPK;
        this.editTime = editTime;
    }

    public ProductsEditHistory(String productId, int version) {
        this.productsEditHistoryPK = new ProductsEditHistoryPK(productId, version);
    }

    public ProductsEditHistoryPK getProductsEditHistoryPK() {
        return productsEditHistoryPK;
    }

    public void setProductsEditHistoryPK(ProductsEditHistoryPK productsEditHistoryPK) {
        this.productsEditHistoryPK = productsEditHistoryPK;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Double productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getProductDiscount() {
        return productDiscount;
    }

    public void setProductDiscount(Integer productDiscount) {
        this.productDiscount = productDiscount;
    }

    public Date getEditTime() {
        return editTime;
    }

    public void setEditTime(Date editTime) {
        this.editTime = editTime;
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
        hash += (productsEditHistoryPK != null ? productsEditHistoryPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductsEditHistory)) {
            return false;
        }
        ProductsEditHistory other = (ProductsEditHistory) object;
        if ((this.productsEditHistoryPK == null && other.productsEditHistoryPK != null) || (this.productsEditHistoryPK != null && !this.productsEditHistoryPK.equals(other.productsEditHistoryPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProductsEditHistory[ productsEditHistoryPK=" + productsEditHistoryPK + " ]";
    }
    
}
