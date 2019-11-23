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
public class SellerFacade extends AbstractFacade<Seller> implements SellerFacadeLocal {
    @PersistenceContext(unitName = "TQHShop-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public SellerFacade() {
        super(Seller.class);
    }

    @Override
    public List<Seller> showAll() {
        Query q = em.createQuery("SELECT s FROM Seller s ORDER BY s.userId DESC");
        List<Seller> list = q.getResultList();
        if (list != null ) {
            return list;
        }
        return null;
    }

    @Override
    public Seller getSellerById(String seller) {
        Query q = em.createQuery("SELECT s FROM Seller s where s.userId = :seller");
        q.setParameter("seller", seller);
        return (Seller) q.getSingleResult();
    }

    
}
