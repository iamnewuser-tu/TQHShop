/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.List;
import javax.ejb.Local;

@Local
public interface OrderAddressFacadeLocal {

    void create(OrderAddress orderAddress);

    void edit(OrderAddress orderAddress);

    void remove(OrderAddress orderAddress);

    OrderAddress find(Object id);

    List<OrderAddress> findAll();

    List<OrderAddress> findRange(int[] range);

    int count();
    
}
