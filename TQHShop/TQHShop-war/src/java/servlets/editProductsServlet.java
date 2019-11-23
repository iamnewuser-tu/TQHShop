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
import entities.ProductTypes;
import entities.ProductTypesFacadeLocal;
import entities.Products;
import entities.ProductsEditHistory;
import entities.ProductsEditHistoryFacadeLocal;
import entities.ProductsEditHistoryPK;
import entities.ProductsFacadeLocal;
import entities.Users;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author nth15
 */
public class editProductsServlet extends HttpServlet {

    @EJB
    private CategoriesFacadeLocal categoriesFacade;

    @EJB
    private ProductsEditHistoryFacadeLocal productsEditHistoryFacade;
    @EJB
    private ProductTypesFacadeLocal productTypesFacade;
    @EJB
    private BrandsFacadeLocal brandsFacade;

    @EJB
    private ProductsFacadeLocal productsFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String productId;
        Products product = null;
        Date today = null;
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            request.setAttribute("message", "Please log in");
            request.getRequestDispatcher("HomeServlet").forward(request, response);
            return;
        }
        String roleUser = user.getRole();
        switch (action) {
            case "sellerEditProductStatus":
                if (wrongRole(roleUser, "seller", request, response))
                    return;
                productId = request.getParameter("productId");
                product = productsFacade.find(productId);
                if (product.getProductStatus()) {
                    product.setProductStatus(false);
                } else {
                    product.setProductStatus(true);
                }
                productsFacade.edit(product);
                request.getRequestDispatcher("viewServlet?action=sellerProduct").forward(request, response);
                break;
            case "sellerEditProductDetail":
                if (wrongRole(roleUser, "seller", request, response))
                    return;
                productId = request.getParameter("txtProductID");
                ProductsEditHistoryPK editHistoryPKE = new ProductsEditHistoryPK(productId, 1);
                ProductsEditHistory editHistoryE = productsEditHistoryFacade.find(editHistoryPKE);
                //Check whether this product has eidt history or not. If not, create new
                if (editHistoryE != null) {
                    int version = productsEditHistoryFacade.newVersion(productId);
                    editHistoryPKE = new ProductsEditHistoryPK(productId, version);
                }
                editHistoryE = new ProductsEditHistory(editHistoryPKE);
                //Save current information of product to history
                product = productsFacade.find(productId);
                Date getTodayE = new Date(new Date().getTime());//return current time
                editHistoryE.setProductName(product.getProductName());
                editHistoryE.setProductPrice(product.getProductPrice());
                editHistoryE.setProductDiscount(product.getProductDiscount());
                editHistoryE.setEditTime(getTodayE);
                productsEditHistoryFacade.create(editHistoryE);

                StringBuilder image = new StringBuilder();
                image.append(request.getParameter("txtImage")).append(",");
                image.append(request.getParameter("txtSubImage1")).append(",");
                image.append(request.getParameter("txtSubImage2")).append(",");
                image.append(request.getParameter("txtSubImage3")).append(",");
                image.append(request.getParameter("txtSubImage4"));

                product.setTypeId(productTypesFacade.find(request.getParameter("txtProductType")));
                product.setBrandId(brandsFacade.find(request.getParameter("txtBrand")));
                product.setProductName(request.getParameter("txtProductName"));
                product.setProductDesc(request.getParameter("txtDescription"));
                product.setProductSummary(request.getParameter("txtSummary"));
                product.setProductPrice(Double.parseDouble(request.getParameter("txtPrice")));
                product.setProductImage(image.toString());
                product.setProductUnit(request.getParameter("txtUnit"));
                product.setProductQuantity(Integer.parseInt(request.getParameter("txtQuantity")));
                String weightE = request.getParameter("txtWeight");
                if (weightE.equals("")) {
                    weightE = "0";
                }
                product.setProductWeight(Double.parseDouble(request.getParameter("txtWeight")));
                String widthE = request.getParameter("txtWidth");
                if (widthE.equals("")) {
                    widthE = "0";
                }
                product.setProductWidth(Double.parseDouble(widthE));
                String heightE = request.getParameter("txtHeight");
                if (heightE.equals("")) {
                    heightE = "0";
                }
                product.setProductHeigth(Double.parseDouble(heightE));
                String lengthE = request.getParameter("txtLength");
                if (lengthE.equals("")) {
                    lengthE = "0";
                }
                product.setProductLength(Double.parseDouble(lengthE));

                product.setProductWidth(Double.parseDouble(request.getParameter("txtWidth")));
                product.setProductHeigth(Double.parseDouble(request.getParameter("txtHeight")));
                product.setProductLength(Double.parseDouble(request.getParameter("txtLength")));
                String discountE = request.getParameter("txtDiscount");
                if (discountE.equals("")) {
                    discountE = "0";
                }
                product.setProductDiscount(Integer.parseInt(discountE));
                productsFacade.edit(product);

                request.getRequestDispatcher("viewServlet?action=sellerProduct").forward(request, response);
                break;
            case "sellerCancelProduct":
                request.getRequestDispatcher("viewServlet?action=sellerProduct").forward(request, response);
                break;
            case "editProduct":
                if (wrongRole(roleUser, "admin", request, response))
                    return;
                productId = request.getParameter("txtProductID");
                ProductsEditHistoryPK editHistoryPK = new ProductsEditHistoryPK(productId, 1);
                ProductsEditHistory editHistory = productsEditHistoryFacade.find(editHistoryPK);
                //Check whether this product has eidt history or not. If not, create new
                if (editHistory != null) {
                    int version = productsEditHistoryFacade.newVersion(productId);
                    editHistoryPK = new ProductsEditHistoryPK(productId, version);
                }
                editHistory = new ProductsEditHistory(editHistoryPK);
                //Save current information of product to history
                Products products = productsFacade.find(productId);
                java.sql.Date getToday = new java.sql.Date(new Date().getTime());//return current time
                editHistory.setProductName(products.getProductName());
                editHistory.setProductPrice(products.getProductPrice());
                editHistory.setProductDiscount(products.getProductDiscount());
                editHistory.setEditTime(getToday);
                productsEditHistoryFacade.create(editHistory);
                //Edit product
                Brands brands = brandsFacade.find(request.getParameter("txtBrand"));
                ProductTypes productTypes = productTypesFacade.find(request.getParameter("txtProductType"));
                products.setTypeId(productTypes);
                products.setBrandId(brands);
                products.setProductName(request.getParameter("txtProductName"));
                products.setProductDesc(request.getParameter("txtDescription"));
                products.setProductSummary(request.getParameter("txtSummary"));
                products.setProductPrice(Double.parseDouble(request.getParameter("txtPrice")));
                products.setProductUnit(request.getParameter("txtUnit"));
                String weight = request.getParameter("txtWeight");
                if (weight.equals("")) {
                    weight = "0";
                }
                products.setProductWeight(Double.parseDouble(weight));
                String width = request.getParameter("txtWidth");
                if (width.equals("")) {
                    width = "0";
                }
                products.setProductWidth(Double.parseDouble(width));
                String height = request.getParameter("txtHeight");
                if (height.equals("")) {
                    height = "0";
                }
                products.setProductHeigth(Double.parseDouble(height));
                String length = request.getParameter("txtLength");
                if (length.equals("")) {
                    length = "0";
                }
                products.setProductLength(Double.parseDouble(length));
                products.setProductQuantity(Integer.parseInt(request.getParameter("txtQuantity")));
                //Append strings to save to database
                String imageChain = request.getParameter("txtImage");
                for (int i = 1; i < 5; i++) {
                    if (!request.getParameter("txtImage" + i).equals("")) {
                        imageChain += "," + request.getParameter("txtImage" + i);
                    }
                }
                products.setProductImage(imageChain);
                String discount = request.getParameter("txtDiscount");
                if (discount.equals("")) {
                    discount = "0";
                }
                products.setProductDiscount(Integer.parseInt(discount));
                productsFacade.edit(products);
                request.setAttribute("message", "Edit successful!");
                request.getRequestDispatcher("viewServlet?action=showProductAdmin").forward(request, response);
                break;
            case "blockProduct":
                if (wrongRole(roleUser, "admin", request, response))
                    return;
                productId = request.getParameter("pid");
                product = productsFacade.find(productId);
                String userRole = product.getUserId().getRole();
                product.getTypeId().getProductsCollection().remove(product);
                product.getBrandId().getProductsCollection().remove(product);
                boolean unblock = false;
                if (request.getParameter("bl").equals("Unblock")) {
                    unblock = true;
                }
                String forwardUrl = "viewServlet?action=showProductAdmin";
                //Check whether this is seller's product
                if (!userRole.equals("admin")) {
                    String sellerId = product.getUserId().getUserId();
                    forwardUrl = "viewServlet?action=viewProductSeller&sellerID=" + sellerId;
                }
                if (unblock) {
                    if (!product.getTypeId().getTypeStatus()) {
                        request.setAttribute("message", "The Type of this product is blocked. Unblock or change type before unblock this product!");
                        request.getRequestDispatcher(forwardUrl).forward(request, response);
                        break;
                    } else if (!product.getBrandId().getBrandStatus()) {
                        request.setAttribute("message", "The brand of this product is blocked. Unblock or change brand before unblock this product!");
                        request.getRequestDispatcher(forwardUrl).forward(request, response);
                        break;
                    }
                }
                //block product
                product.setProductStatus(unblock);
                productsFacade.edit(product);
                product.getTypeId().getProductsCollection().add(product);
                product.getBrandId().getProductsCollection().add(product);
                request.setAttribute("message", unblock ? "Unblock product successful!" : "Block product successful!");
                request.getRequestDispatcher(forwardUrl).forward(request, response);
                break;
            case "cancelProduct":
                request.getRequestDispatcher("viewServlet?action=showProductAdmin").forward(request, response);
                break;
            //admin edit product type
            case "editProductType":
                if (wrongRole(roleUser, "admin", request, response))
                    return;
                String typeId = request.getParameter("txtTypeId");
                ProductTypes type = productTypesFacade.find(typeId);
                type.setTypeName(request.getParameter("txtTypeName"));
                Categories cat = categoriesFacade.find(request.getParameter("txtCategory"));
                type.setCategoryId(cat);
                type.setTypeDesc(request.getParameter("txtTypeDesc"));
                type.setTypeIcon(request.getParameter("txtTypeIcon"));
                productTypesFacade.edit(type);
                request.setAttribute("message", "Edit successful!");
                request.getRequestDispatcher("viewServlet?action=showProductType").forward(request, response);
                break;
            case "editBrand":
                if (wrongRole(roleUser, "admin", request, response))
                    return;
                String brandId = request.getParameter("txtBrandId");
                Brands brand = brandsFacade.find(brandId);
                brand.setBrandName(request.getParameter("txtBrandName"));
                brand.setBrandIcon(request.getParameter("txtBrandIcon"));
                brandsFacade.edit(brand);
                request.setAttribute("message", "Edit successful!");
                request.getRequestDispatcher("viewServlet?action=showBrand").forward(request, response);
                break;
            case "blockBrand":
                if (wrongRole(roleUser, "admin", request, response))
                    return;
                String blockBrandId = request.getParameter("bId");
                Brands blockBr = brandsFacade.find(blockBrandId);
                List<Products> listProBrand = (List<Products>) blockBr.getProductsCollection();
                if (request.getParameter("bl").equals("Block")) {
                    boolean isBrandCanDisable = true; //Check List Product has all products are blocked or not
                    if (!listProBrand.isEmpty()) {
                        for (Products pro : listProBrand) {
                            if (pro.getProductStatus()) {
                                isBrandCanDisable = false;
                                request.setAttribute("message", "This brand has products which is active, cannot block this brand!");
                                break;
                            }
                        }
                    }
                    if (isBrandCanDisable) { //If List Product has all products which are blocked
                        blockBr.setBrandStatus(Boolean.FALSE);
                        brandsFacade.edit(blockBr);
                        if (listProBrand.isEmpty()) {
                            request.setAttribute("message", "This brand has no product. Block successfully!");
                        } else {
                            request.setAttribute("message", "All products of this brand are deactivated. Block successfully!");
                        }
                    }
                } else { //Unblock brand
                    blockBr.setBrandStatus(true);
                    brandsFacade.edit(blockBr);
                    request.setAttribute("message", "Unblock brand successfully!");
                }
                request.getRequestDispatcher("viewServlet?action=showBrand").forward(request, response);
                break;
            case "blockType":
                if (wrongRole(roleUser, "admin", request, response))
                    return;
                String typeIdBlock = request.getParameter("typeId");
                ProductTypes typeBlock = productTypesFacade.find(typeIdBlock);
                List<Products> listProType = (List<Products>) typeBlock.getProductsCollection();
                if (request.getParameter("bl").equals("Block")) {
                    boolean isTypeCanDisable = true; //Check List Product has all products are blocked or not
                    //If type has products, do not block type. If not, block type
                    if (!listProType.isEmpty()) {
                        for (Products pro : listProType) {
                            if (pro.getProductStatus()) {
                                isTypeCanDisable = false;
                                request.setAttribute("message", "This type has products which is active, cannot block this type!");
                                break;
                            }
                        }
                    }
                    if (isTypeCanDisable) { //If List Product has all products which are blocked
                        typeBlock.getCategoryId().getProductTypesCollection().remove(typeBlock);
                        typeBlock.setTypeStatus(Boolean.FALSE);
                        productTypesFacade.edit(typeBlock);
                        typeBlock.getCategoryId().getProductTypesCollection().add(typeBlock);
                        if (listProType.isEmpty()) {
                            request.setAttribute("message", "This type has no product. Block successfully!");
                        } else {
                            request.setAttribute("message", "All products of this type are deactivated. Block successfully!");
                        }
                    }
                } else { //Unblock type
                    if (!typeBlock.getCategoryId().getCategoryStatus()) {
                        request.setAttribute("message", "The Category of this Type is blocked. Unblock or change Category before unblock this Type!");
                        request.getRequestDispatcher("viewServlet?action=showProductType").forward(request, response);
                        break;
                    }
                    typeBlock.getCategoryId().getProductTypesCollection().remove(typeBlock);
                    typeBlock.setTypeStatus(true);
                    productTypesFacade.edit(typeBlock);
                    typeBlock.getCategoryId().getProductTypesCollection().add(typeBlock);
                    request.setAttribute("message", "Unblock type successfully!");
                }
                request.getRequestDispatcher("viewServlet?action=showProductType").forward(request, response);
                break;
            //admin cancel product type
            case "cancelProductType":
                request.getRequestDispatcher("viewServlet?action=showProductType").forward(request, response);
                break;

            case "cancelBrand":
                request.getRequestDispatcher("viewServlet?action=showBrand").forward(request, response);
                break;
            //admin edit category
            case "editCategory":
                if (wrongRole(roleUser, "admin", request, response))
                    return;
                String catId = request.getParameter("txtCategoryId");
                Categories catEdit = categoriesFacade.find(catId);
                catEdit.setCategoryName(request.getParameter("txtCategoryName"));
                catEdit.setCategoryDesc(request.getParameter("txtDescription"));
                catEdit.setCategoryIcon(request.getParameter("txtIcon"));
                categoriesFacade.edit(catEdit);
                request.setAttribute("message", "Edit successful!");
                request.getRequestDispatcher("viewServlet?action=showCategories").forward(request, response);
                break;
            case "blockCategory":
                if (wrongRole(roleUser, "admin", request, response))
                    return;
                String catIdBlock = request.getParameter("catId");
                Categories catBlock = categoriesFacade.find(catIdBlock);
                List<ProductTypes> listTypeCat = (List<ProductTypes>) catBlock.getProductTypesCollection();
                if (request.getParameter("bl").equals("Block")) {
                    boolean isCategoryCanDisable = true; //Check List Product has all products are blocked or not
                    boolean isAllTypeEmpty = true;
                    if (!listTypeCat.isEmpty()) {
                        for (ProductTypes pt : listTypeCat) {
                            List<Products> listProTypeCat = (List<Products>) pt.getProductsCollection();
                            if (!listProTypeCat.isEmpty()) {
                                for (Products pro : listProTypeCat) {
                                    if (pro.getProductStatus()) {
                                        isCategoryCanDisable = false;
                                        request.setAttribute("message", "This category has products which is active, cannot block this category!");
                                        break;
                                    }
                                }
                                isAllTypeEmpty = false;
                            }
                        }
                    }
                    if (isCategoryCanDisable) {
                        catBlock.setCategoryStatus(Boolean.FALSE);
                        categoriesFacade.edit(catBlock);
                        if (listTypeCat.isEmpty() || isAllTypeEmpty) {
                            request.setAttribute("message", "This category has no product. Block successfully");
                        } else {
                            request.setAttribute("message", "All products of this category are deactivated. Block category successfully!");
                        }
                    }
                } else { //Unblock
                    for (ProductTypes pt : listTypeCat) {
                        pt.setTypeStatus(true);
                        productTypesFacade.edit(pt);
                    }
                    catBlock.setCategoryStatus(true);
                    categoriesFacade.edit(catBlock);
                    request.setAttribute("message", "Unblock category successfully!");
                }
                request.getRequestDispatcher("viewServlet?action=showCategories").forward(request, response);
                break;
            //admin cancel category

            case "cancelCategory":
                request.getRequestDispatcher("viewServlet?action=showCategories").forward(request, response);
                break;
            default:
                request.setAttribute("error", "Page not found");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                break;

        }
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

}
