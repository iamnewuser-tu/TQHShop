/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.List;
import javax.ejb.Local;

@Local
public interface SellerFacadeLocal {

    void create(Seller seller);

    void edit(Seller seller);

    void remove(Seller seller);

    Seller find(Object id);

    List<Seller> findAll();

    List<Seller> findRange(int[] range);

    int count();

    List<Seller> showAll();
    
    Seller getSellerById(String seller);

    
}
