/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "OrderAddress", catalog = "TQHShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "OrderAddress.findAll", query = "SELECT o FROM OrderAddress o"),
    @NamedQuery(name = "OrderAddress.findByOrderMId", query = "SELECT o FROM OrderAddress o WHERE o.orderMId = :orderMId"),
    @NamedQuery(name = "OrderAddress.findByOrderAddressLat", query = "SELECT o FROM OrderAddress o WHERE o.orderAddressLat = :orderAddressLat"),
    @NamedQuery(name = "OrderAddress.findByOrderAddressLng", query = "SELECT o FROM OrderAddress o WHERE o.orderAddressLng = :orderAddressLng"),
    @NamedQuery(name = "OrderAddress.findByOrderAddressDetail", query = "SELECT o FROM OrderAddress o WHERE o.orderAddressDetail = :orderAddressDetail"),
    @NamedQuery(name = "OrderAddress.findByOrderPhone", query = "SELECT o FROM OrderAddress o WHERE o.orderPhone = :orderPhone")})
public class OrderAddress implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "orderMId", nullable = false, length = 10)
    private String orderMId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "orderAddressLat", precision = 53)
    private Double orderAddressLat;
    @Column(name = "orderAddressLng", precision = 53)
    private Double orderAddressLng;
    @Size(max = 1000)
    @Column(name = "orderAddressDetail", length = 1000)
    private String orderAddressDetail;
    @Size(max = 20)
    @Column(name = "orderPhone", length = 20)
    private String orderPhone;
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    @ManyToOne
    private Users userId;
    @JoinColumn(name = "orderMId", referencedColumnName = "orderMId", nullable = false, insertable = false, updatable = false)
    @OneToOne(optional = false)
    private OrderMaster orderMaster;

    public OrderAddress() {
    }

    public OrderAddress(String orderMId) {
        this.orderMId = orderMId;
    }

    public String getOrderMId() {
        return orderMId;
    }

    public void setOrderMId(String orderMId) {
        this.orderMId = orderMId;
    }

    public Double getOrderAddressLat() {
        return orderAddressLat;
    }

    public void setOrderAddressLat(Double orderAddressLat) {
        this.orderAddressLat = orderAddressLat;
    }

    public Double getOrderAddressLng() {
        return orderAddressLng;
    }

    public void setOrderAddressLng(Double orderAddressLng) {
        this.orderAddressLng = orderAddressLng;
    }

    public String getOrderAddressDetail() {
        return orderAddressDetail;
    }

    public void setOrderAddressDetail(String orderAddressDetail) {
        this.orderAddressDetail = orderAddressDetail;
    }

    public String getOrderPhone() {
        return orderPhone;
    }

    public void setOrderPhone(String orderPhone) {
        this.orderPhone = orderPhone;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    public OrderMaster getOrderMaster() {
        return orderMaster;
    }

    public void setOrderMaster(OrderMaster orderMaster) {
        this.orderMaster = orderMaster;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderMId != null ? orderMId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderAddress)) {
            return false;
        }
        OrderAddress other = (OrderAddress) object;
        if ((this.orderMId == null && other.orderMId != null) || (this.orderMId != null && !this.orderMId.equals(other.orderMId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.OrderAddress[ orderMId=" + orderMId + " ]";
    }
    
}
