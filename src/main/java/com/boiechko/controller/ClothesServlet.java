package com.boiechko.controller;

import com.boiechko.entity.Person;
import com.boiechko.entity.Product;
import com.boiechko.service.implementations.ClothesServiceImpl;
import com.boiechko.service.implementations.PersonServiceImpl;
import com.boiechko.service.implementations.ProductServiceImpl;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.PersonService;
import com.boiechko.service.interfaces.ProductService;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import static javax.servlet.http.HttpServletResponse.SC_INTERNAL_SERVER_ERROR;
import static javax.servlet.http.HttpServletResponse.SC_NOT_IMPLEMENTED;

@WebServlet("/manClothes/*")
@MultipartConfig
public class ClothesServlet extends HttpServlet {

    private final Logger logger = Logger.getLogger(ClothesServlet.class);

    private final ProductService productService = new ProductServiceImpl();
    private final ClothesService clothesService = new ClothesServiceImpl();
    private final PersonService personService = new PersonServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        final HttpSession session = request.getSession();

        final Person person = (Person) session.getAttribute("person");

        if (personService.isPersonAdmin(person)) {
            request.setAttribute("isPersonCanAddClothes", true);
        }

        final String pageNumber = request.getParameter("page");

        if (pageNumber.equals("1")) {
            session.setAttribute("clothes", clothesService.getListOfClothes(request));
        }

        final List<Product> clothes = (List<Product>) session.getAttribute("clothes");

        final int numberOfProductsShownOnPage = clothesService.getNumberOfProductsShownOnPage(pageNumber, clothes.size());

        request.setAttribute("numberOfProductsShownOnPage", numberOfProductsShownOnPage);
        request.setAttribute("lastIndexOfShownProduct", numberOfProductsShownOnPage - 1);
        request.setAttribute("pageNumber", pageNumber);

        request.getRequestDispatcher("/jsp-pages/clothes.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        final String typeName = request.getParameter("type");
        final String productName = request.getParameter("product");
        final String sex = request.getParameter("sex");
        final String brand = request.getParameter("brand");
        final String model = request.getParameter("model");
        final String size = request.getParameter("size");
        final String color = request.getParameter("color");
        final Part image = request.getPart("image");
        final String destination = request.getParameter("destination");
        final int price = Integer.parseInt(request.getParameter("price"));
        final String description = request.getParameter("description");

        final Product product = new Product
                (typeName, productName, sex, brand, model, size, color,
                        "dataBaseImages/" + productService.getDestinationOfImage(image, destination),
                        price, description
                );

        if (productService.saveImage(image, destination)) {

            if (!productService.addProduct(product)) {
                response.sendError(SC_INTERNAL_SERVER_ERROR);
                logger.error("Не вдалось зберегти продукт");
            }

        } else {
            response.sendError(SC_NOT_IMPLEMENTED);
            logger.error("Не вдалось зберегти зображення");
        }
    }

}
