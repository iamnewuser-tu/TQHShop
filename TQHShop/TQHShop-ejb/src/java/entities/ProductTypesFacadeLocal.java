/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.List;
import javax.ejb.Local;

@Local
public interface ProductTypesFacadeLocal {

    void create(ProductTypes productTypes);

    void edit(ProductTypes productTypes);

    void remove(ProductTypes productTypes);

    ProductTypes find(Object id);

    List<ProductTypes> findAll();

    List<ProductTypes> findRange(int[] range);

    int count();

    String newId();

    List<ProductTypes> showAll();

    List<ProductTypes> showActiveTypes();
    
}
