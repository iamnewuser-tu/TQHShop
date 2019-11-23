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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "Seller", catalog = "TQHShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Seller.findAll", query = "SELECT s FROM Seller s"),
    @NamedQuery(name = "Seller.findByUserId", query = "SELECT s FROM Seller s WHERE s.userId = :userId"),
    @NamedQuery(name = "Seller.findByStoreName", query = "SELECT s FROM Seller s WHERE s.storeName = :storeName"),
    @NamedQuery(name = "Seller.findByIdentityCard", query = "SELECT s FROM Seller s WHERE s.identityCard = :identityCard"),
    @NamedQuery(name = "Seller.findByApprovedDate", query = "SELECT s FROM Seller s WHERE s.approvedDate = :approvedDate"),
    @NamedQuery(name = "Seller.findByApprovedPlace", query = "SELECT s FROM Seller s WHERE s.approvedPlace = :approvedPlace"),
    @NamedQuery(name = "Seller.findByStoreAddress", query = "SELECT s FROM Seller s WHERE s.storeAddress = :storeAddress"),
    @NamedQuery(name = "Seller.findByStoreIcon", query = "SELECT s FROM Seller s WHERE s.storeIcon = :storeIcon"),
    @NamedQuery(name = "Seller.findByStoreSummary", query = "SELECT s FROM Seller s WHERE s.storeSummary = :storeSummary")})
public class Seller implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "userId", nullable = false, length = 10)
    private String userId;
    @Size(max = 1000)
    @Column(name = "storeName", length = 1000)
    private String storeName;
    @Size(max = 20)
    @Column(name = "identityCard", length = 20)
    private String identityCard;
    @Size(max = 50)
    @Column(name = "approvedDate", length = 50)
    private String approvedDate;
    @Size(max = 100)
    @Column(name = "approvedPlace", length = 100)
    private String approvedPlace;
    @Size(max = 100)
    @Column(name = "storeAddress", length = 100)
    private String storeAddress;
    @Size(max = 200)
    @Column(name = "storeIcon", length = 200)
    private String storeIcon;
    @Size(max = 1000)
    @Column(name = "storeSummary", length = 1000)
    private String storeSummary;
    @JoinColumn(name = "userId", referencedColumnName = "userId", nullable = false, insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Users users;

    public Seller() {
    }

    public Seller(String userId) {
        this.userId = userId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getIdentityCard() {
        return identityCard;
    }

    public void setIdentityCard(String identityCard) {
        this.identityCard = identityCard;
    }

    public String getApprovedDate() {
        return approvedDate;
    }

    public void setApprovedDate(String approvedDate) {
        this.approvedDate = approvedDate;
    }

    public String getApprovedPlace() {
        return approvedPlace;
    }

    public void setApprovedPlace(String approvedPlace) {
        this.approvedPlace = approvedPlace;
    }

    public String getStoreAddress() {
        return storeAddress;
    }

    public void setStoreAddress(String storeAddress) {
        this.storeAddress = storeAddress;
    }

    public String getStoreIcon() {
        return storeIcon;
    }

    public void setStoreIcon(String storeIcon) {
        this.storeIcon = storeIcon;
    }

    public String getStoreSummary() {
        return storeSummary;
    }

    public void setStoreSummary(String storeSummary) {
        this.storeSummary = storeSummary;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userId != null ? userId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Seller)) {
            return false;
        }
        Seller other = (Seller) object;
        if ((this.userId == null && other.userId != null) || (this.userId != null && !this.userId.equals(other.userId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Seller[ userId=" + userId + " ]";
    }
    
}
