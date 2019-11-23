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
public class ProductRatingFacade extends AbstractFacade<ProductRating> implements ProductRatingFacadeLocal {
    @PersistenceContext(unitName = "TQHShop-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProductRatingFacade() {
        super(ProductRating.class);
    }

    @Override
    public List<ProductRating> findRatingByProductId(String productId) {
        Query q = em.createQuery("SELECT p FROM ProductRating p WHERE p.productRatingPK.productId = ?1");
        q.setParameter(1, productId);
        List<ProductRating> listResult = q.getResultList();
        if ( listResult != null ) {
            return listResult;
        }
        return null;
    }
    
    
}
