<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link rel="stylesheet" href="../../css/style.css">
    <link rel="stylesheet" href="../../css/updatePassword.css">
</head>
<body>

<%
    String email = (String) session.getAttribute("email");
    if (email == null)
        response.sendError(404);
%>

<div class="container" style="margin-top: 80px;">

    <h1 class="title">Оновлення паролю</h1>

    <form class="form" id="form" method="post">

        <label class="form__label">
            <b>Пароль</b>
            <input id="password" type="password" required>
        </label>

        <label class="form__label">
            <b>Підтвердження</b>
            <input id="confirm" type="password" required>
        </label>

        <button class="button button_update" type="submit">Підтвердити</button>

    </form>
</div>

<div class="overlay">
    <div class="modalw modalw_mini" id="thanks">
        <div class="modalw__close">&times;</div>
        <p class="modalw__descr">Ваш пароль успішно оновлено!</p>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

<script>

    $(document).ready(function () {

        $('.modalw__close').on('click', function () {
            window.location.href = "${pageContext.request.contextPath}/login";
        });
    });

    document.getElementById("form").onsubmit = function () {
        return validate();
    }

    function validate() {

        let password = document.getElementById('password').value;
        let confirmPassword = document.getElementById('confirm').value;

        if (password !== confirmPassword) {

            alert("Паролі відрізняються!");

            return false;
        }

        let success = false;

        $.ajax({

            url: "/updatePassword",
            async: true,
            type: "POST",
            data: {

                password: password,
                email: "<%=(String) session.getAttribute("email")%>"
            }
        }).done(function () {

            success = true;
            $('.overlay, #thanks').fadeIn('slow');

        }).fail(function (response) {

            success = false;

            if (response.status === 500)
                alert("Не вдалось оновити пароль. Зверніться до технічної підтримки!");
            else if (response.status === 403)
                alert("Придумайте новий пароль!");
            else if (response.status === 503)
                alert("asdad")

        });

        return success;
    }

</script>


</body>
</html>