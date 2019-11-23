/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.List;
import javax.ejb.Local;

@Local
public interface ProductsCommentFacadeLocal {

    void create(ProductsComment productsComment);

    void edit(ProductsComment productsComment);

    void remove(ProductsComment productsComment);

    ProductsComment find(Object id);

    List<ProductsComment> findAll();

    List<ProductsComment> findRange(int[] range);

    int count();

    List<ProductsComment> getListComment(String productID);

    String newId();

}
