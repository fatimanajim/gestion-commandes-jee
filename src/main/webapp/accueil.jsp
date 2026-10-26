<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head><title>Accueil - Gestion des commandes</title></head>
<body>
<jsp:include page="/menu.jsp"/>

<div class="content">
    <h2>Tableau de bord</h2>

    <div class="stats">
        <a class="stat s1" href="${pageContext.request.contextPath}/clients">
            <div class="nb">${nbClients}</div><div class="lib">Clients</div>
        </a>
        <a class="stat s2" href="${pageContext.request.contextPath}/produits">
            <div class="nb">${nbProduits}</div><div class="lib">Produits</div>
        </a>
        <a class="stat s3" href="${pageContext.request.contextPath}/commandes">
            <div class="nb">${nbCommandes}</div><div class="lib">Commandes</div>
        </a>
        <div class="stat s4">
            <div class="nb"><fmt:formatNumber value="${chiffreAffaires}" minFractionDigits="2"/></div>
            <div class="lib">Chiffre d'affaires (DH)</div>
        </div>
    </div>

    <h3>Dernières commandes</h3>
    <table>
        <tr><th>N°</th><th>Date</th><th>Client</th><th>Total (DH)</th><th></th></tr>
        <c:forEach var="cmd" items="${dernieres}">
            <tr>
                <td>${cmd.id}</td>
                <td>${cmd.dateCommande}</td>
                <td><c:out value="${cmd.clientNom}"/></td>
                <td><fmt:formatNumber value="${cmd.total}" minFractionDigits="2"/></td>
                <td><a class="btn" href="${pageContext.request.contextPath}/commandes?action=detail&id=${cmd.id}">Détail</a></td>
            </tr>
        </c:forEach>
        <c:if test="${empty dernieres}">
            <tr><td colspan="5">Aucune commande pour le moment.</td></tr>
        </c:if>
    </table>
    <br/>
    <a class="btn" href="${pageContext.request.contextPath}/commandes?action=new">+ Nouvelle commande</a>
    <a class="btn btn-edit" href="${pageContext.request.contextPath}/clients?action=new">+ Nouveau client</a>
    <a class="btn btn-gray" href="${pageContext.request.contextPath}/produits?action=new">+ Nouveau produit</a>
</div>
</body>
</html>