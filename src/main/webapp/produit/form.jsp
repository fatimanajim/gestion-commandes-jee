<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Produit</title></head>
<body>
<jsp:include page="/menu.jsp"/>
<div class="content">
    <h2><c:choose>
        <c:when test="${empty produit}">Ajouter un produit</c:when>
        <c:otherwise>Modifier un produit</c:otherwise>
    </c:choose></h2>

    <form class="f" action="${pageContext.request.contextPath}/produits" method="post">
        <input type="hidden" name="id" value="${produit.id}"/>

        <label>Désignation :</label>
        <input name="designation" value="${produit.designation}" required/><br/>

        <label>Prix :</label>
        <input type="number" step="0.01" min="0" name="prix" value="${produit.prix}" required/><br/>

        <label>Stock :</label>
        <input type="number" min="0" name="stock" value="${empty produit ? 0 : produit.stock}" required/><br/><br/>

        <button class="btn" type="submit">Enregistrer</button>
        <a class="btn btn-gray" href="${pageContext.request.contextPath}/produits">Annuler</a>
    </form>
</div>
</body>
</html>
