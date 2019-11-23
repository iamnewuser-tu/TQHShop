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
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "ProductsComment", catalog = "TQHShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProductsComment.findAll", query = "SELECT p FROM ProductsComment p"),
    @NamedQuery(name = "ProductsComment.findByCommentID", query = "SELECT p FROM ProductsComment p WHERE p.commentID = :commentID"),
    @NamedQuery(name = "ProductsComment.findByCommentContent", query = "SELECT p FROM ProductsComment p WHERE p.commentContent = :commentContent"),
    @NamedQuery(name = "ProductsComment.findByCommentStatus", query = "SELECT p FROM ProductsComment p WHERE p.commentStatus = :commentStatus")})
public class ProductsComment implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "commentID", nullable = false, length = 10)
    private String commentID;
    @Size(max = 3000)
    @Column(name = "commentContent", length = 3000)
    private String commentContent;
    @Column(name = "commentStatus")
    private Boolean commentStatus;
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    @ManyToOne
    private Users userId;
    @JoinColumn(name = "productId", referencedColumnName = "productId")
    @ManyToOne
    private Products productId;

    public ProductsComment() {
    }

    public ProductsComment(String commentID) {
        this.commentID = commentID;
    }

    public String getCommentID() {
        return commentID;
    }

    public void setCommentID(String commentID) {
        this.commentID = commentID;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Boolean getCommentStatus() {
        return commentStatus;
    }

    public void setCommentStatus(Boolean commentStatus) {
        this.commentStatus = commentStatus;
    }

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    public Products getProductId() {
        return productId;
    }

    public void setProductId(Products productId) {
        this.productId = productId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (commentID != null ? commentID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductsComment)) {
            return false;
        }
        ProductsComment other = (ProductsComment) object;
        if ((this.commentID == null && other.commentID != null) || (this.commentID != null && !this.commentID.equals(other.commentID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ProductsComment[ commentID=" + commentID + " ]";
    }
    
}
