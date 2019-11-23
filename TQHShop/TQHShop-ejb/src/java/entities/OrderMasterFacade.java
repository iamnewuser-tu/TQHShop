/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Stateless
public class OrderMasterFacade extends AbstractFacade<OrderMaster> implements OrderMasterFacadeLocal {
    @PersistenceContext(unitName = "TQHShop-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrderMasterFacade() {
        super(OrderMaster.class);
    }
       
    @Override
    public String newId() {
        Query q = em.createQuery("SELECT o FROM OrderMaster o ORDER BY o.orderMId DESC");
        List<OrderMaster> list = q.setMaxResults(1).getResultList();
        if (list != null) {
            String lastId = list.get(0).getOrderMId().replace("ORD", "");
            int lastNum = Integer.parseInt(lastId) + 1;
            String newId = String.format("ORD" + "%03d", lastNum);
            return newId;
        }
        return null;
    }

    @Override
    public long countDoneOrder() {
        Query q = em.createQuery("SELECT COUNT(o) FROM OrderMaster o WHERE o.orderStatus = :orderStatus");
        try {
            q.setParameter("orderStatus", "Done");
        } catch (Exception e) {
        }
        return (long) q.getSingleResult();
    }

    @Override
    public long countOrderByMonth(Date aftermonth, Date beforemonth) {
        Query q = em.createQuery("SELECT COUNT(o) FROM OrderMaster o WHERE o.dateOrdered between ?1 and ?2");
        q.setParameter(1, aftermonth);
        q.setParameter(2, beforemonth);
        long count = (long) q.getSingleResult();
        return count;
    }

    @Override
    public List<OrderMaster> getOrderByUserID(String userID) {
        Query q = em.createQuery("SELECT o FROM OrderMaster o WHERE o.userId.userId = :userId ORDER BY o.dateOrdered DESC");
        try {
            q.setParameter("userId", userID);
        } catch (Exception e) {
        }
        return q.getResultList();
    }
    
    @Override
    public List<Object> searchOrderMastersByDate(String customerID, String date) {
        em.clear();
        em.getEntityManagerFactory().getCache().evictAll();
        if (date.equalsIgnoreCase("")) {
            Query q = em.createQuery("SELECT o.orderMId, o.dateOrdered, o.orderAddress.orderAddressDetail,o.orderStatus, o.orderTotalPrice FROM OrderMaster o WHERE o.userId.userId = :customerID ORDER BY o.orderMId DESC");
            q.setParameter("customerID", customerID);
            return q.getResultList();
        }else{
            Query q = em.createQuery("SELECT o.orderMId, o.dateOrdered, o.orderAddress.orderAddressDetail, o.orderStatus, o.orderTotalPrice FROM OrderMaster o WHERE o.userId.userId = :customerID AND CAST(o.dateOrdered as DATE) = CAST(:date as DATE ) ORDER BY o.orderMId DESC");
            q.setParameter("customerID", customerID);
            q.setParameter("date", date);
            return q.getResultList();
        }
    }

    @Override
    public List<OrderMaster> showAll() {
        Query q = em.createQuery("SELECT o FROM OrderMaster o ORDER BY o.orderMId DESC");
        List<OrderMaster> list = q.getResultList();
        if (list != null) {
            return list;
        }
        return null;
    }
}

