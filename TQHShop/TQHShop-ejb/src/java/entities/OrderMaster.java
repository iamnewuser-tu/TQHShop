/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "OrderMaster", catalog = "TQHShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "OrderMaster.findAll", query = "SELECT o FROM OrderMaster o"),
    @NamedQuery(name = "OrderMaster.findByOrderMId", query = "SELECT o FROM OrderMaster o WHERE o.orderMId = :orderMId"),
    @NamedQuery(name = "OrderMaster.findByOrderTotalPrice", query = "SELECT o FROM OrderMaster o WHERE o.orderTotalPrice = :orderTotalPrice"),
    @NamedQuery(name = "OrderMaster.findByDeliveryPrice", query = "SELECT o FROM OrderMaster o WHERE o.deliveryPrice = :deliveryPrice"),
    @NamedQuery(name = "OrderMaster.findByOrderNote", query = "SELECT o FROM OrderMaster o WHERE o.orderNote = :orderNote"),
    @NamedQuery(name = "OrderMaster.findByOrderStatus", query = "SELECT o FROM OrderMaster o WHERE o.orderStatus = :orderStatus"),
    @NamedQuery(name = "OrderMaster.findByDateOrdered", query = "SELECT o FROM OrderMaster o WHERE o.dateOrdered = :dateOrdered")})
public class OrderMaster implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "orderMId", nullable = false, length = 10)
    private String orderMId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "orderTotalPrice", precision = 53)
    private Double orderTotalPrice;
    @Column(name = "DeliveryPrice", precision = 53)
    private Double deliveryPrice;
    @Size(max = 1000)
    @Column(name = "orderNote", length = 1000)
    private String orderNote;
    @Size(max = 10)
    @Column(name = "orderStatus", length = 10)
    private String orderStatus;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dateOrdered", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateOrdered;
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    @ManyToOne
    private Users userId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "orderMaster")
    private Collection<OrderDetails> orderDetailsCollection;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "orderMaster")
    private OrderAddress orderAddress;

    public OrderMaster() {
    }

    public OrderMaster(String orderMId) {
        this.orderMId = orderMId;
    }

    public OrderMaster(String orderMId, Date dateOrdered) {
        this.orderMId = orderMId;
        this.dateOrdered = dateOrdered;
    }

    public String getOrderMId() {
        return orderMId;
    }

    public void setOrderMId(String orderMId) {
        this.orderMId = orderMId;
    }

    public Double getOrderTotalPrice() {
        return orderTotalPrice;
    }

    public void setOrderTotalPrice(Double orderTotalPrice) {
        this.orderTotalPrice = orderTotalPrice;
    }

    public Double getDeliveryPrice() {
        return deliveryPrice;
    }

    public void setDeliveryPrice(Double deliveryPrice) {
        this.deliveryPrice = deliveryPrice;
    }

    public String getOrderNote() {
        return orderNote;
    }

    public void setOrderNote(String orderNote) {
        this.orderNote = orderNote;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Date getDateOrdered() {
        return dateOrdered;
    }

    public void setDateOrdered(Date dateOrdered) {
        this.dateOrdered = dateOrdered;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    @XmlTransient
    public Collection<OrderDetails> getOrderDetailsCollection() {
        return orderDetailsCollection;
    }

    public void setOrderDetailsCollection(Collection<OrderDetails> orderDetailsCollection) {
        this.orderDetailsCollection = orderDetailsCollection;
    }

    public OrderAddress getOrderAddress() {
        return orderAddress;
    }

    public void setOrderAddress(OrderAddress orderAddress) {
        this.orderAddress = orderAddress;
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
        if (!(object instanceof OrderMaster)) {
            return false;
        }
        OrderMaster other = (OrderMaster) object;
        if ((this.orderMId == null && other.orderMId != null) || (this.orderMId != null && !this.orderMId.equals(other.orderMId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.OrderMaster[ orderMId=" + orderMId + " ]";
    }
    
}
