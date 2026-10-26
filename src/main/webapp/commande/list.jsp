<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head><title>Commandes</title></head>
<body>
  <jsp:include page="/menu.jsp"/>
  <div class="content">
    <h2>Liste des commandes</h2>
    <a class="btn" href="commandes?action=new">+ Nouvelle commande</a><br/><br/>
    <table>
      <tr><th>N°</th><th>Date</th><th>Client</th><th>Total (DH)</th><th>Actions</th></tr>
      <c:forEach var="cmd" items="${commandes}">
        <tr>
          <td>${cmd.id}</td>
          <td>${cmd.dateCommande}</td>
          <td><c:out value="${cmd.clientNom}"/></td>
          <td><fmt:formatNumber value="${cmd.total}" minFractionDigits="2"/></td>
          <td>
            <a class="btn" href="commandes?action=detail&id=${cmd.id}">Détail</a>
            <a class="btn btn-edit" href="commandes?action=edit&id=${cmd.id}">Modifier</a>
            <a class="btn btn-danger" href="commandes?action=delete&id=${cmd.id}"
               onclick="return confirm('Supprimer cette commande et ses lignes ?')">Supprimer</a>
          </td>
        </tr>
      </c:forEach>
      <c:if test="${empty commandes}">
        <tr><td colspan="5">Aucune commande.</td></tr>
      </c:if>
    </table>
  </div>
</body>
</html>