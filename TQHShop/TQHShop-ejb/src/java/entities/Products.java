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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "Products", catalog = "TQHShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Products.findAll", query = "SELECT p FROM Products p"),
    @NamedQuery(name = "Products.findByProductId", query = "SELECT p FROM Products p WHERE p.productId = :productId"),
    @NamedQuery(name = "Products.findByProductName", query = "SELECT p FROM Products p WHERE p.productName = :productName"),
    @NamedQuery(name = "Products.findByProductDesc", query = "SELECT p FROM Products p WHERE p.productDesc = :productDesc"),
    @NamedQuery(name = "Products.findByProductSummary", query = "SELECT p FROM Products p WHERE p.productSummary = :productSummary"),
    @NamedQuery(name = "Products.findByProductPrice", query = "SELECT p FROM Products p WHERE p.productPrice = :productPrice"),
    @NamedQuery(name = "Products.findByProductUnit", query = "SELECT p FROM Products p WHERE p.productUnit = :productUnit"),
    @NamedQuery(name = "Products.findByProductWeight", query = "SELECT p FROM Products p WHERE p.productWeight = :productWeight"),
    @NamedQuery(name = "Products.findByProductWidth", query = "SELECT p FROM Products p WHERE p.productWidth = :productWidth"),
    @NamedQuery(name = "Products.findByProductHeigth", query = "SELECT p FROM Products p WHERE p.productHeigth = :productHeigth"),
    @NamedQuery(name = "Products.findByProductLength", query = "SELECT p FROM Products p WHERE p.productLength = :productLength"),
    @NamedQuery(name = "Products.findByProductQuantity", query = "SELECT p FROM Products p WHERE p.productQuantity = :productQuantity"),
    @NamedQuery(name = "Products.findByProductImage", query = "SELECT p FROM Products p WHERE p.productImage = :productImage"),
    @NamedQuery(name = "Products.findByProductDiscount", query = "SELECT p FROM Products p WHERE p.productDiscount = :productDiscount"),
    @NamedQuery(name = "Products.findByProductRating", query = "SELECT p FROM Products p WHERE p.productRating = :productRating"),
    @NamedQuery(name = "Products.findByIsApproved", query = "SELECT p FROM Products p WHERE p.isApproved = :isApproved"),
    @NamedQuery(name = "Products.findByDatePosted", query = "SELECT p FROM Products p WHERE p.datePosted = :datePosted"),
    @NamedQuery(name = "Products.findByVotedUsers", query = "SELECT p FROM Products p WHERE p.votedUsers = :votedUsers"),
    @NamedQuery(name = "Products.findByProductStatus", query = "SELECT p FROM Products p WHERE p.productStatus = :productStatus")})
public class Products implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "productId", nullable = false, length = 10)
    private String productId;
    @Size(max = 500)
    @Column(name = "productName", length = 500)
    private String productName;
    @Size(max = 3500)
    @Column(name = "productDesc", length = 3500)
    private String productDesc;
    @Size(max = 1000)
    @Column(name = "productSummary", length = 1000)
    private String productSummary;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "productPrice", precision = 53)
    private Double productPrice;
    @Size(max = 50)
    @Column(name = "productUnit", length = 50)
    private String productUnit;
    @Column(name = "productWeight", precision = 53)
    private Double productWeight;
    @Column(name = "productWidth", precision = 53)
    private Double productWidth;
    @Column(name = "productHeigth", precision = 53)
    private Double productHeigth;
    @Column(name = "productLength", precision = 53)
    private Double productLength;
    @Column(name = "productQuantity")
    private Integer productQuantity;
    @Size(max = 4000)
    @Column(name = "productImage", length = 4000)
    private String productImage;
    @Column(name = "productDiscount")
    private Integer productDiscount;
    @Column(name = "productRating", precision = 53)
    private Double productRating;
    @Column(name = "isApproved")
    private Boolean isApproved;
    @Basic(optional = false)
    @NotNull
    @Column(name = "datePosted", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date datePosted;
    @Size(max = 4000)
    @Column(name = "votedUsers", length = 4000)
    private String votedUsers;
    @Column(name = "productStatus")
    private Boolean productStatus;
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    @ManyToOne
    private Users userId;
    @JoinColumn(name = "typeId", referencedColumnName = "typeId")
    @ManyToOne
    private ProductTypes typeId;
    @JoinColumn(name = "brandId", referencedColumnName = "brandId")
    @ManyToOne
    private Brands brandId;
    @OneToMany(mappedBy = "productId")
    private Collection<ProductsComment> productsCommentCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "products")
    private Collection<OrderDetails> orderDetailsCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "products")
    private Collection<ProductRating> productRatingCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "products")
    private Collection<ProductsEditHistory> productsEditHistoryCollection;
    public Products() {
    }
    
    public Products(String productId) {
        this.productId = productId;
    }

    public Products(String productId, Date datePosted) {
        this.productId = productId;
        this.datePosted = datePosted;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductDesc() {
        return productDesc;
    }

    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    public String getProductSummary() {
        return productSummary;
    }

    public void setProductSummary(String productSummary) {
        this.productSummary = productSummary;
    }

    public Double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductUnit() {
        return productUnit;
    }

    public void setProductUnit(String productUnit) {
        this.productUnit = productUnit;
    }

    public Double getProductWeight() {
        return productWeight;
    }

    public void setProductWeight(Double productWeight) {
        this.productWeight = productWeight;
    }

    public Double getProductWidth() {
        return productWidth;
    }

    public void setProductWidth(Double productWidth) {
        this.productWidth = productWidth;
    }

    public Double getProductHeigth() {
        return productHeigth;
    }

    public void setProductHeigth(Double productHeigth) {
        this.productHeigth = productHeigth;
    }

    public Double getProductLength() {
        return productLength;
    }

    public void setProductLength(Double productLength) {
        this.productLength = productLength;
    }

    public Integer getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(Integer productQuantity) {
        this.productQuantity = productQuantity;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public Integer getProductDiscount() {
        return productDiscount;
    }

    public void setProductDiscount(Integer productDiscount) {
        this.productDiscount = productDiscount;
    }

    public Double getProductRating() {
        return productRating;
    }

    public void setProductRating(Double productRating) {
        this.productRating = productRating;
    }

    public Boolean getIsApproved() {
        return isApproved;
    }

    public void setIsApproved(Boolean isApproved) {
        this.isApproved = isApproved;
    }

    public Date getDatePosted() {
        return datePosted;
    }

    public void setDatePosted(Date datePosted) {
        this.datePosted = datePosted;
    }

    public String getVotedUsers() {
        return votedUsers;
    }

    public void setVotedUsers(String votedUsers) {
        this.votedUsers = votedUsers;
    }

    public Boolean getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(Boolean productStatus) {
        this.productStatus = productStatus;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    public ProductTypes getTypeId() {
        return typeId;
    }

    public void setTypeId(ProductTypes typeId) {
        this.typeId = typeId;
    }

    public Brands getBrandId() {
        return brandId;
    }

    public void setBrandId(Brands brandId) {
        this.brandId = brandId;
    }

    public Collection<ProductsComment> getProductsCommentCollection() {
        return productsCommentCollection;
    }

    public void setProductsCommentCollection(Collection<ProductsComment> productsCommentCollection) {
        this.productsCommentCollection = productsCommentCollection;
    }

    public Collection<OrderDetails> getOrderDetailsCollection() {
        return orderDetailsCollection;
    }

    public void setOrderDetailsCollection(Collection<OrderDetails> orderDetailsCollection) {
        this.orderDetailsCollection = orderDetailsCollection;
    }

    public Collection<ProductRating> getProductRatingCollection() {
        return productRatingCollection;
    }

    public void setProductRatingCollection(Collection<ProductRating> productRatingCollection) {
        this.productRatingCollection = productRatingCollection;
    }

    public Collection<ProductsEditHistory> getProductsEditHistoryCollection() {
        return productsEditHistoryCollection;
    }

    public void setProductsEditHistoryCollection(Collection<ProductsEditHistory> productsEditHistoryCollection) {
        this.productsEditHistoryCollection = productsEditHistoryCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productId != null ? productId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Products)) {
            return false;
        }
        Products other = (Products) object;
        if ((this.productId == null && other.productId != null) || (this.productId != null && !this.productId.equals(other.productId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Products[ productId=" + productId + " ]";
    }
    
}
