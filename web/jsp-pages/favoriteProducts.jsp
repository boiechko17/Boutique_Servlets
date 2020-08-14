<%@ page import="com.boiechko.entity.Product" %>
<%@ page import="com.boiechko.service.implementations.ProductServiceImpl" %>
<%@ page import="com.boiechko.service.interfaces.ProductService" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Favorite clothes</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/clothes.css">
</head>
<body>
<jsp:include page="components/header.jsp"/>
<%
    ProductService productService = new ProductServiceImpl();
    List<Product> favorite = new ArrayList<>();
    List<Integer> favoriteId = (List<Integer>) session.getAttribute("favoriteId");

    for (Integer id : favoriteId)
        favorite.add(productService.getById(id));

    String displayProducts, header;

    if (favorite.size() == 0) {
        displayProducts = "none";
        header = "block";
    } else {
        displayProducts = "block";
        header = "none";
    }

    request.setAttribute("favorite", favorite);

%>
<div class="clothes" style="display: <%=displayProducts%>;">

    <div class="container">

        <div class="row">

            <c:forEach items="${favorite}" var="product">

                <div class="col-md-4">

                    <a href="${pageContext.request.contextPath}/new/${product.idProduct}">

                        <div class="clothes__block">

                            <div class="clothes__block__img">

                                <img class="clothes__block__img_main"
                                     src="${pageContext.request.contextPath}${product.image}"
                                     alt="${product.productName}">

                                <div class="hover"></div>

                            </div>

                            <div class="clothes__block__text">

                                <div class="clothes__block__text_title">
                                        ${product.description}
                                </div>

                                <div class="clothes__block__text_price">
                                        ${product.price} грн.
                                </div>

                            </div>

                        </div>
                    </a>

                    <button onclick="deleteFavorite(${product.idProduct})" class="clothes__block__img__favorite clothes__block__img__favorite_favorite">

                        <img src="${pageContext.request.contextPath}/img/other/delete.png"
                             alt="favorite">

                    </button>

                    <button class="buttonFavorite">Добавити в корзину</button>

                </div>

            </c:forEach>

        </div>

    </div>

</div>

<div class="headerFavorite" style="display: <%=header%>;">

    <div class="container">

        <img src="${pageContext.request.contextPath}/img/other/favorite.png" alt="favorite">
        <div class="headerFavorite__title">Немає збережених товарів</div>
        <div class="headerFavorite__descr">
            Зберігайте товари, які Вам сподобалися в улюблені простим натисканням на сердечко.
        </div>
        <a href="${pageContext.request.contextPath}/">Розпочати шопінг</a>

    </div>

</div>

<jsp:include page="components/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script>

    function deleteFavorite(idProduct) {

        let success = false;

        $.ajax({

            url: "/favorite?idProduct=" + idProduct,
            async: true,
            method: "DELETE",

        }).done(function () {

            success = true;
            alert("Продукт видалено з улюблених");
            location.reload();

        }).fail(function (response) {

            success = false;

            if (response.status === 401)
                alert("Потрібно увійти");
            else if (response.status === 500)
                alert("Проблеми з сервером");

        });

        return success;

    }

</script>

</body>
</html>
