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
public interface ProductsFacadeLocal {

    void create(Products products);

    void edit(Products products);

    void remove(Products products);

    Products find(Object id);

    List<Products> findAll();

    List<Products> findRange(int[] range);

    int count();
    
    List<Products> getListProductByDatePost();
    
    List<Products> getListProductByDiscount();
    
    List<Products> getListProductsByName(String productName);
    
    List<Products> getListProductSeller();
    
    String newProductID();
    
    List<Products> getListProductBySeller(String seller);//get product is posted by seller

    long countSoldProduct();

    List<Products> getTopProduct();

    List<Products> showAll();

    List<ProductTypes> getListTypeByName(String productName);

    long countProductsByMonth(Date beforeMonth, Date afterMonth);
    
    List<Products> getTopProduct(String seller);

}
