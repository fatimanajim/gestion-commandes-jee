<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Client</title></head>
<body>
<jsp:include page="/menu.jsp"/>
<div class="content">
    <h2><c:choose>
        <c:when test="${empty client}">Ajouter un client</c:when>
        <c:otherwise>Modifier un client</c:otherwise>
    </c:choose></h2>

    <form class="f" action="${pageContext.request.contextPath}/clients" method="post">
        <input type="hidden" name="id" value="${client.id}"/>

        <label>Nom :</label>
        <input name="nom" value="${client.nom}" required/><br/>

        <label>Prénom :</label>
        <input name="prenom" value="${client.prenom}" required/><br/>

        <label>Email :</label>
        <input type="email" name="email" value="${client.email}"/><br/>

        <label>Téléphone :</label>
        <input name="telephone" value="${client.telephone}"/><br/>

        <label>Adresse :</label>
        <input name="adresse" value="${client.adresse}"/><br/><br/>

        <button class="btn" type="submit">Enregistrer</button>
        <a class="btn btn-gray" href="${pageContext.request.contextPath}/clients">Annuler</a>
    </form>
</div>
</body>
</html>
