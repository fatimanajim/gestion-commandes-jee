<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head><title>Produits</title></head>
<body>
<jsp:include page="/menu.jsp"/>
<div class="content">
    <h2>Liste des produits</h2>
    <c:if test="${not empty error}">
        <div class="error"><c:out value="${error}"/></div>
    </c:if>

    <a class="btn" href="${pageContext.request.contextPath}/produits?action=new">+ Nouveau produit</a>
    <br/><br/>
    <table>
        <tr><th>ID</th><th>Désignation</th><th>Prix (DH)</th><th>Stock</th><th>Actions</th></tr>
        <c:forEach var="p" items="${produits}">
            <tr>
                <td>${p.id}</td>
                <td><c:out value="${p.designation}"/></td>
                <td><fmt:formatNumber value="${p.prix}" minFractionDigits="2"/></td>
                <td>${p.stock}</td>
                <td>
                    <a class="btn btn-edit"
                       href="${pageContext.request.contextPath}/produits?action=edit&id=${p.id}">Modifier</a>
                    <a class="btn btn-danger"
                       href="${pageContext.request.contextPath}/produits?action=delete&id=${p.id}"
                       onclick="return confirm('Supprimer ce produit ?')">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty produits}">
            <tr><td colspan="5">Aucun produit.</td></tr>
        </c:if>
    </table>
</div>
</body>
</html>
