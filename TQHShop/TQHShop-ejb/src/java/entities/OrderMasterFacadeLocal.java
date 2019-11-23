/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.Date;
import java.util.List;
import javax.ejb.Local;

@Local
public interface OrderMasterFacadeLocal {

    void create(OrderMaster orderMaster);

    void edit(OrderMaster orderMaster);

    void remove(OrderMaster orderMaster);

    OrderMaster find(Object id);

    List<OrderMaster> findAll();

    List<OrderMaster> findRange(int[] range);

    int count();

    String newId();

    long countDoneOrder();

    long countOrderByMonth(Date aftermonth, Date beforemonth);

    List<OrderMaster> getOrderByUserID(String userID);
    
    List<Object> searchOrderMastersByDate(String customerID, String date);

    List<OrderMaster> showAll();

}
