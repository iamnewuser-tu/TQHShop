/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import entities.Customers;
import entities.CustomersFacadeLocal;
import entities.ProductsComment;
import entities.ProductsCommentFacadeLocal;
import entities.Users;
import entities.UsersFacadeLocal;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nth15
 */
public class editCustomerServlet extends HttpServlet {

    @EJB
    private ProductsCommentFacadeLocal productsCommentFacade;

    @EJB
    private CustomersFacadeLocal customersFacade;
    @EJB
    private UsersFacadeLocal usersFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("user");
            session.setAttribute("user", user);
            if (user == null) {
                request.setAttribute("message", "Please log in");
                request.getRequestDispatcher("HomeServlet").forward(request, response);
                return;
            }
            String roleUser = user.getRole();
            switch (action) {
                case "editProfileCustomer":
                    if (wrongRole(roleUser, "customer", request, response))
                        return;
                    user.setFullname(request.getParameter("txtName"));
                    user.setEmail(request.getParameter("txtEmail"));
                    user.setPhone(request.getParameter("txtPhone"));
                    usersFacade.edit(user);
                    //start with customer
                    Customers customer = customersFacade.find(user.getUserId());
                    String birthday = request.getParameter("ddlDay") + "/" + request.getParameter("ddlMonth") + "/" + request.getParameter("ddlYear");
                    String edAddress = request.getParameter("txtAddress");
                    if (edAddress == null) {
                        customer.setAddress("");
                    } else {
                        customer.setAddress(edAddress);
                    }
                    customer.setGender(request.getParameter("gender"));
                    customer.setDob(birthday);
                    customersFacade.edit(customer);//completed edit customer
                    //re-display birthday
                    String disBirthday[] = customer.getDob().split("/");

                    request.setAttribute("date", Integer.parseInt(disBirthday[0]));
                    request.setAttribute("month", Integer.parseInt(disBirthday[1]));
                    request.setAttribute("year", Integer.parseInt(disBirthday[2]));
                    buildDatePicker(request);
                    request.setAttribute("customer", customer);
                    request.setAttribute("message", "Edit successful!");
                    session.setAttribute("user", user);
                    request.getRequestDispatcher("viewServlet?action=homeCustomer").forward(request, response);
                    break;
                case "cusChangePassword":
                    if (wrongRole(roleUser, "customer", request, response))
                        return;
                    String inputPass = request.getParameter("txtOldPassword");
                    if (!inputPass.equals(user.getPassword())) {
                        request.setAttribute("message", "Incorrect password!");
                        request.getRequestDispatcher("viewServlet?action=homeCustomer").forward(request, response);
                        break;
                    }
                    user.setPassword(request.getParameter("txtNewPass"));
                    usersFacade.edit(user);
                    request.getRequestDispatcher("viewServlet?action=homeCustomer").forward(request, response);
                    break;
                case "blockCustomer":
                    if (wrongRole(roleUser, "admin", request, response))
                        return;
                    String cusIdBlock = request.getParameter("cusId");
                    Users uBlock = usersFacade.find(cusIdBlock);
                    List<ProductsComment> listCm = (List<ProductsComment>) uBlock.getProductsCommentCollection();
                    boolean unblock = false;
                    if (request.getParameter("bl").equals("Unblock")) {
                        unblock = true;
                    }
                    //Block customer comments
                    for (ProductsComment pc : listCm) {
                        if (!unblock) {
                            pc.setCommentStatus(unblock);
                            productsCommentFacade.edit(pc);
                        }
                    }
                    //Block customer
                    uBlock.setUserStatus(unblock);
                    usersFacade.edit(uBlock);
                    request.setAttribute("message", unblock ? "Unblock customer successfully!" : "Block customer successfully!");
                    request.getRequestDispatcher("viewServlet?action=showCustomer").forward(request, response);
                    break;
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void buildDatePicker(HttpServletRequest request) {
        List<Integer> listDate = new ArrayList<>();
        List< Integer> listMonth = new ArrayList<>();
        List< Integer> listYear = new ArrayList<>();
        for (int i = 1; i < 32; i++) {
            listDate.add(i);
            if (i < 13) {
                listMonth.add(i);
            }
        }
        for (int i = 1950; i < 2018; i++) {
            listYear.add(i);
        }
        request.setAttribute("listDate", listDate);
        request.setAttribute("listMonth", listMonth);
        request.setAttribute("listYear", listYear);
    }

    private boolean wrongRole(String role, String check, HttpServletRequest request, HttpServletResponse response) {
        try {
            if (!role.equals(check)) {
                request.setAttribute("message", "Please log in as " + check);
                request.getRequestDispatcher("HomeServlet").forward(request, response);
                return true;
            }
        } catch (ServletException | IOException e) {
        }
        return false;
    }
}
