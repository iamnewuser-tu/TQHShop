/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Stateless
public class OrderDetailsFacade extends AbstractFacade<OrderDetails> implements OrderDetailsFacadeLocal {
    @PersistenceContext(unitName = "TQHShop-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrderDetailsFacade() {
        super(OrderDetails.class);
    }

    @Override
    public long sumProductsSold() {
        Query q = em.createQuery("SELECT SUM(o.quantity) FROM OrderDetails o WHERE o.orderMaster.orderStatus = :orderStatus");
        try {
            q.setParameter("orderStatus", "Done");
        } catch (Exception e) {
        }
        return (long) q.getSingleResult();
    }
    
}
