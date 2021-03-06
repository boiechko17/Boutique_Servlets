<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/updatePassword.css">
</head>
<body>
<div class="container" style="margin-top: 80px;">

    <h1 class="title">Оновлення паролю</h1>

    <div class="form" id="form">

        <label class="form__label">
            <b>Пароль</b>
            <input id="password" type="password" required>
        </label>

        <label class="form__label">
            <b>Підтвердження</b>
            <input id="confirm" type="password" required>
        </label>

        <button onclick="validate()" class="button button_updatePassword" type="submit">Підтвердити</button>

    </div>
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

    function validate() {

        let password = document.getElementById('password').value;
        let confirmPassword = document.getElementById('confirm').value;

        if (password !== confirmPassword) {

            alert("Паролі відрізняються!");

            return false;
        }

        let success = false;

        $.ajax({

            url: "/forget/updatePassword?password=" + password + "&email=${email}",
            async: false,
            type: "PUT",

        }).done(function () {

            success = true;
            $('.overlay, #thanks').fadeIn('slow');

        }).fail(function (response) {

            success = false;

            if (response.status === 500)
                alert("Не вдалось оновити пароль. Зверніться до технічної підтримки!");
            else if (response.status === 403)
                alert("Придумайте новий пароль!");

        });

        return success;
    }

</script>
</body>
</html>