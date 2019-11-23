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
public class ProductsEditHistoryFacade extends AbstractFacade<ProductsEditHistory> implements ProductsEditHistoryFacadeLocal {
    @PersistenceContext(unitName = "TQHShop-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProductsEditHistoryFacade() {
        super(ProductsEditHistory.class);
    }

    //generate version of product history
    @Override
    public int newVersion(String productId) {
        int newVersion = 0;
        Query q = em.createNamedQuery("ProductsEditHistory.findByProductId");
        q.setParameter("productId", productId);
        List<ProductsEditHistory> editHistorys = q.getResultList();
        newVersion = editHistorys.size() + 1;
        return newVersion;
    }

    @Override
    public List<ProductsEditHistory> findByProductId(String productId) {
        Query q = em.createQuery("SELECT p FROM ProductsEditHistory p WHERE p.productsEditHistoryPK.productId = ?1");
        q.setParameter(1, productId);
        List<ProductsEditHistory> listResult = q.getResultList();
        if (listResult != null) {
            return listResult;
        }
        return null;
    }
    
    
    
}
