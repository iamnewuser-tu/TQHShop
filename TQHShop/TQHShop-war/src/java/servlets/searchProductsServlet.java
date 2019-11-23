/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import entities.Categories;
import entities.CategoriesFacadeLocal;
import entities.ProductTypes;
import entities.Products;
import entities.ProductsFacadeLocal;
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
import org.apache.commons.lang3.StringUtils;
import utils.PageProduct;
import utils.TQHShopUtils;

public class searchProductsServlet extends HttpServlet {

    @EJB
    private ProductsFacadeLocal productsFacade;
    @EJB
    private CategoriesFacadeLocal categoriesFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        List<Products> listProductSearch;
        HttpSession session = request.getSession();
        String referer = request.getHeader("referer");
        PageProduct paging;
        List<Categories> listCategories = categoriesFacade.showActiveCategories();
        try (PrintWriter out = response.getWriter()) {
            switch (action) {
                case "Search":
                    String keyword = request.getParameter("txtProductName");
                    listProductSearch = productsFacade.getListProductsByName(keyword);
                    paging = new PageProduct(listProductSearch, 12);
                    buildPaging(request, session, paging, referer, "pageProduct");
                    List<ProductTypes> listTypeSearch = productsFacade.getListTypeByName(keyword);
                    ProductTypes fakeSelect = new ProductTypes("Select");
                    fakeSelect.setTypeName("All Product Type");
                    listTypeSearch.add(0, fakeSelect);
                    getServletContext().setAttribute("listProductSearch", listProductSearch);
                    getServletContext().setAttribute("keyword", keyword);
                    getServletContext().setAttribute("listTypeSearch", listTypeSearch);
                    request.setAttribute("listProductSearch", listProductSearch);
                    request.setAttribute("listCategories", listCategories);
                    request.setAttribute("action", "search");
                    request.getRequestDispatcher("search.jsp").forward(request, response);
                    break;
                case "filter":
                    String typeIdSelected = request.getParameter("txtTypeName");
                    String strMin = request.getParameter("txtMin");
                    String strMax = request.getParameter("txtMax");
                    List<Products> listForward = (List<Products>) getServletContext().getAttribute("listForward");
                    listProductSearch = (List<Products>) getServletContext().getAttribute("listProductSearch");
                    if (listForward == null) {
                        listForward = listProductSearch;
                    }
                    if (!typeIdSelected.equals("Select") && strMin.equals("") && strMax.equals("")) { //filter by type
                        listForward = filterByType(listProductSearch, typeIdSelected);
                        //filter by price
                    } else if (typeIdSelected.equals("Select") && (!strMin.equals("") || !strMax.equals(""))) {
                        listForward = filterByPrice(listProductSearch, strMin, strMax);
                    } else if (typeIdSelected.equals("Select") && strMin.equals("") && strMax.equals("")) {
                        listForward = listProductSearch;
                        request.setAttribute("listProductSearch", listForward);
                        getServletContext().setAttribute("listForward", listForward);
                        request.setAttribute("listCategories", listCategories);
                        request.getRequestDispatcher("search.jsp").forward(request, response);
                        break;
                    } else { //both
                        listForward = filterByType(listProductSearch, typeIdSelected);
                        if (listForward != null) {
                            listForward = filterByPrice(listForward, strMin, strMax);
                        }
                    }
                     paging = new PageProduct(listForward, 12);
                    buildPaging(request, session, paging, referer, "pageProduct");
                    request.setAttribute("listProductSearch", listForward);
                    getServletContext().setAttribute("listForward", listForward);
                    request.setAttribute("strMin", strMin);
                    request.setAttribute("strMax", strMax);
                    request.setAttribute("typeIdSelected", typeIdSelected);
                    request.setAttribute("listCategories", listCategories);
                    request.setAttribute("action", "filter");
                    request.getRequestDispatcher("search.jsp").forward(request, response);
                    break;
            }

        }
    }

    private List<Products> filterByType(List<Products> listToFilter, String typeIdSelected) {
        List<Products> listByType = new ArrayList<>();
        for (Products pro : listToFilter) {
            if (pro.getTypeId().getTypeId().equals(typeIdSelected)) {
                listByType.add(pro);
            }
        }
        return listByType;
    }

    private List<Products> filterByPrice(List<Products> listToFilter, String strMin, String strMax) {
        double min = 0, max = Double.MAX_VALUE;
        if (!strMin.equals("") && strMax.equals("")) {
            min = Double.parseDouble(strMin);
        } else if (strMin.equals("") && !strMax.equals("")) {
            max = Double.parseDouble(strMax);
        } else {
            min = Double.parseDouble(strMin);
            max = Double.parseDouble(strMax);
        }
        List<Products> listByPrice = new ArrayList<>();
        for (Products pro : listToFilter) {
            if (pro.getProductPrice() >= min && pro.getProductPrice() <= max) {
                listByPrice.add(pro);
            }
        }
        return listByPrice;
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
    
    private void buildPaging(HttpServletRequest request, HttpSession session, PageProduct paging, String referer, String AttributeName) {
        String n3 = request.getParameter("btn");
        String nextCurrent = request.getParameter("page");
        int nextPage = 1;
        int current = 1;
        if (StringUtils.isNotBlank(nextCurrent)) {
            nextPage = Integer.parseInt(nextCurrent);
            current = nextPage;
        }
        else if (session.getAttribute("currentPage") != null) {
            current = (int) session.getAttribute("currentPage");
        }
        else {
            String currentPage = StringUtils.substringAfterLast(referer,"page=");
            if (StringUtils.isNotBlank(currentPage) ) {
                current = Integer.parseInt(currentPage);
            }
        }
        paging.setPageIndex(current);

        if (n3 != null) {
            if (n3.equals("next")) {
                paging.next();
                nextPage = current >= paging.getPages() ? paging.getPages() : current+1;
            }
            if (n3.equals("prev")) {
                paging.prev();
                nextPage = current == 1 ? current : current-1;
            }
        }
        paging.updateModel();
        session.setAttribute("currentPage", nextPage);
        request.setAttribute(AttributeName, paging);
    }
}
