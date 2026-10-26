<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Clients</title></head>
<body>
<jsp:include page="/menu.jsp"/>
<div class="content">
    <h2>Liste des clients</h2>
    <a class="btn" href="${pageContext.request.contextPath}/clients?action=new">+ Nouveau client</a>
    <br/><br/>
    <table>
        <tr>
            <th>ID</th><th>Nom</th><th>Prénom</th><th>Email</th>
            <th>Téléphone</th><th>Adresse</th><th>Actions</th>
        </tr>
        <c:forEach var="cl" items="${clients}">
            <tr>
                <td>${cl.id}</td>
                <td><c:out value="${cl.nom}"/></td>
                <td><c:out value="${cl.prenom}"/></td>
                <td><c:out value="${cl.email}"/></td>
                <td><c:out value="${cl.telephone}"/></td>
                <td><c:out value="${cl.adresse}"/></td>
                <td>
                    <a class="btn btn-edit"
                       href="${pageContext.request.contextPath}/clients?action=edit&id=${cl.id}">Modifier</a>
                    <a class="btn btn-danger"
                       href="${pageContext.request.contextPath}/clients?action=delete&id=${cl.id}"
                       onclick="return confirm('Supprimer ce client ?')">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty clients}">
            <tr><td colspan="7">Aucun client.</td></tr>
        </c:if>
    </table>
</div>
</body>
</html>
