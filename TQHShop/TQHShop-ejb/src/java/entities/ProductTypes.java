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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "ProductTypes", catalog = "TQHShop", schema = "dbo", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"typeName"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProductTypes.findAll", query = "SELECT p FROM ProductTypes p"),
    @NamedQuery(name = "ProductTypes.findByTypeId", query = "SELECT p FROM ProductTypes p WHERE p.typeId = :typeId"),
    @NamedQuery(name = "ProductTypes.findByTypeName", query = "SELECT p FROM ProductTypes p WHERE p.typeName = :typeName"),
    @NamedQuery(name = "ProductTypes.findByTypeDesc", query = "SELECT p FROM ProductTypes p WHERE p.typeDesc = :typeDesc"),
    @NamedQuery(name = "ProductTypes.findByTypeIcon", query = "SELECT p FROM ProductTypes p WHERE p.typeIcon = :typeIcon"),
    @NamedQuery(name = "ProductTypes.findByTypeStatus", query = "SELECT p FROM ProductTypes p WHERE p.typeStatus = :typeStatus")})
public class ProductTypes implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "typeId", nullable = false, length = 10)
    private String typeId;
    @Size(max = 50)
    @Column(name = "typeName", length = 50)
    private String typeName;
    @Size(max = 300)
    @Column(name = "typeDesc", length = 300)
    private String typeDesc;
    @Size(max = 200)
    @Column(name = "typeIcon", length = 200)
    private String typeIcon;
    @Column(name = "typeStatus")
    private Boolean typeStatus;
    @OneToMany(mappedBy = "typeId")
    private Collection<Products> productsCollection;
    @JoinColumn(name = "categoryId", referencedColumnName = "categoryId")
    @ManyToOne
    private Categories categoryId;

    public ProductTypes() {
    }

    public ProductTypes(String typeId) {
        this.typeId = typeId;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeDesc() {
        return typeDesc;
    }

    public void setTypeDesc(String typeDesc) {
        this.typeDesc = typeDesc;
    }

    public String getTypeIcon() {
        return typeIcon;
    }

    public void setTypeIcon(String typeIcon) {
        this.typeIcon = typeIcon;
    }

    public Boolean getTypeStatus() {
        return typeStatus;
    }

    public void setTypeStatus(Boolean typeStatus) {
        this.typeStatus = typeStatus;
    }

    @XmlTransient
    public Collection<Products> getProductsCollection() {
        return productsCollection;
    }

    public void setProductsCollection(Collection<Products> productsCollection) {
        this.productsCollection = productsCollection;
    }

    public Categories getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Categories categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (typeId != null ? typeId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductTypes)) {
            return false;
        }
        ProductTypes other = (ProductTypes) object;
        if ((this.typeId == null && other.typeId != null) || (this.typeId != null && !this.typeId.equals(other.typeId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProductTypes[ typeId=" + typeId + " ]";
    }
    
}
