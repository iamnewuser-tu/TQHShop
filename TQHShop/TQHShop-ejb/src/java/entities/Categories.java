/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "Categories", catalog = "TQHShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Categories.findAll", query = "SELECT c FROM Categories c"),
    @NamedQuery(name = "Categories.findByCategoryId", query = "SELECT c FROM Categories c WHERE c.categoryId = :categoryId"),
    @NamedQuery(name = "Categories.findByCategoryName", query = "SELECT c FROM Categories c WHERE c.categoryName = :categoryName"),
    @NamedQuery(name = "Categories.findByCategoryDesc", query = "SELECT c FROM Categories c WHERE c.categoryDesc = :categoryDesc"),
    @NamedQuery(name = "Categories.findByCategoryStatus", query = "SELECT c FROM Categories c WHERE c.categoryStatus = :categoryStatus"),
    @NamedQuery(name = "Categories.findByCategoryIcon", query = "SELECT c FROM Categories c WHERE c.categoryIcon = :categoryIcon")})
public class Categories implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "categoryId", nullable = false, length = 10)
    private String categoryId;
    @Size(max = 100)
    @Column(name = "categoryName", length = 100)
    private String categoryName;
    @Size(max = 500)
    @Column(name = "categoryDesc", length = 500)
    private String categoryDesc;
    @Column(name = "categoryStatus")
    private Boolean categoryStatus;
    @Size(max = 200)
    @Column(name = "categoryIcon", length = 200)
    private String categoryIcon;
    @OneToMany(mappedBy = "categoryId")
    private Collection<ProductTypes> productTypesCollection;

    public Categories() {
    }

    public Categories(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryDesc() {
        return categoryDesc;
    }

    public void setCategoryDesc(String categoryDesc) {
        this.categoryDesc = categoryDesc;
    }

    public Boolean getCategoryStatus() {
        return categoryStatus;
    }

    public void setCategoryStatus(Boolean categoryStatus) {
        this.categoryStatus = categoryStatus;
    }

    public String getCategoryIcon() {
        return categoryIcon;
    }

    public void setCategoryIcon(String categoryIcon) {
        this.categoryIcon = categoryIcon;
    }

    @XmlTransient
    public Collection<ProductTypes> getProductTypesCollection() {
        return productTypesCollection;
    }

    public void setProductTypesCollection(Collection<ProductTypes> productTypesCollection) {
        this.productTypesCollection = productTypesCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (categoryId != null ? categoryId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Categories)) {
            return false;
        }
        Categories other = (Categories) object;
        if ((this.categoryId == null && other.categoryId != null) || (this.categoryId != null && !this.categoryId.equals(other.categoryId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Categories[ categoryId=" + categoryId + " ]";
    }
    
}
