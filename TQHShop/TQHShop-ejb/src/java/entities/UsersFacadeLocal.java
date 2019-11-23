/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entities;

import java.util.List;
import javax.ejb.Local;

@Local
public interface UsersFacadeLocal {

    void create(Users users);

    void edit(Users users);

    void remove(Users users);

    Users find(Object id);

    List<Users> findAll();

    List<Users> findRange(int[] range);

    int count();
    
    Users checkLogin(String userID, String pwd);

    List<Users> getListSeller();
    
    List<Users> getListCustomer();

    long countActiveSeller();

    long countActiveCustomer();
    
    Users getUserById(String user);
}
