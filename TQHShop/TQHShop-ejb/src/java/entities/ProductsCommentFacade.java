/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Stateless
public class ProductsCommentFacade extends AbstractFacade<ProductsComment> implements ProductsCommentFacadeLocal {
    @PersistenceContext(unitName = "TQHShop-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProductsCommentFacade() {
        super(ProductsComment.class);
    }

    @Override
    public List<ProductsComment> getListComment(String productID) {
        Query q = em.createQuery("SELECT p FROM ProductsComment p WHERE p.productId.productId = :productID");
        q.setParameter("productID", productID);
        return q.getResultList();
    }

    @Override
    public String newId() {
        Query q = em.createQuery("SELECT p FROM ProductsComment p ORDER BY p.commentID DESC");
        List<ProductsComment> p = q.setMaxResults(1).getResultList();
        if (p != null) {
            String lastProductID = p.get(0).getCommentID().replace("CMT", "");
            int lastNumb = Integer.parseInt(lastProductID) + 1;
            String commentId = String.format("CMT" + "%03d", lastNumb);
            return commentId;
        }
        return null;
    }
    
    
            
}
