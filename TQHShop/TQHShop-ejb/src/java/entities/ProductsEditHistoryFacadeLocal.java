/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.List;
import javax.ejb.Local;

@Local
public interface ProductsEditHistoryFacadeLocal {

    void create(ProductsEditHistory productsEditHistory);

    void edit(ProductsEditHistory productsEditHistory);

    void remove(ProductsEditHistory productsEditHistory);

    ProductsEditHistory find(Object id);

    List<ProductsEditHistory> findAll();

    List<ProductsEditHistory> findRange(int[] range);

    int count();

    int newVersion(String productId);

    List<ProductsEditHistory> findByProductId(String productId);
    
}
