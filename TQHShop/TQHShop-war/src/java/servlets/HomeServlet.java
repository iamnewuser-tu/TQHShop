/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import entities.Brands;
import entities.BrandsFacadeLocal;
import entities.Categories;
import entities.CategoriesFacadeLocal;
import entities.Products;
import entities.ProductsFacadeLocal;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.TQHShopUtils;

public class HomeServlet extends HttpServlet {

    @EJB
    private BrandsFacadeLocal brandsFacade;
    @EJB
    private CategoriesFacadeLocal categoriesFacade;
    @EJB
    private ProductsFacadeLocal productsFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        buildProductRequest("ListProductByDatePost", request, productsFacade.getListProductByDatePost());
        buildProductRequest("ListProductByDiscount", request, productsFacade.getListProductByDiscount());
        buildProductRequest("ListProductBySeller", request, productsFacade.getListProductSeller());
        List<Categories> listCategories = categoriesFacade.showActiveCategories();
        if (listCategories.isEmpty()) {
            request.setAttribute("message", "Please run sql query to insert database correctly");
        }
        else {
            request.setAttribute("listCategories", listCategories);
            
        }
        List<Brands> listBrands = brandsFacade.showActiveBrands();
        if (listBrands.isEmpty()) {
            request.setAttribute("message", "Please run sql query to insert database correctly");
        }
        else {
            request.setAttribute("listBrands", listBrands.subList(0, 6));
        }
        
        request.getRequestDispatcher("index.jsp").forward(request, response);
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

    private void buildProductRequest(String listName, HttpServletRequest request, List<Products> listProduct) {
        if (!listProduct.isEmpty()) {
            request.setAttribute(listName + "1", TQHShopUtils.buidProductIndexModel(listProduct.subList(0, 4)));
            request.setAttribute(listName + "2", TQHShopUtils.buidProductIndexModel(listProduct.subList(5, 9)));
        }
        else {
            request.setAttribute("message", "Please run sql query to insert database correctly");
        }
    }

}
