/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.List;
import javax.ejb.Local;

@Local
public interface ProductRatingFacadeLocal {

    void create(ProductRating productRating);

    void edit(ProductRating productRating);

    void remove(ProductRating productRating);

    ProductRating find(Object id);

    List<ProductRating> findAll();

    List<ProductRating> findRange(int[] range);

    int count();

    List<ProductRating> findRatingByProductId(String productId);
    
}
