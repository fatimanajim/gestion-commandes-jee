<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head><title>Détail commande</title></head>
<body>
  <jsp:include page="/menu.jsp"/>
  <div class="content">
    <h2>Commande n° ${commande.id}</h2>
    <p><b>Date :</b> ${commande.dateCommande}<br/>
       <b>Client :</b> <c:out value="${commande.clientNom}"/></p>

    <h3>Lignes de la commande</h3>
    <table>
      <tr><th>Produit</th><th>Prix unitaire</th><th>Quantité</th><th>Sous-total</th><th>Action</th></tr>
      <c:forEach var="l" items="${lignes}">
        <tr>
          <td><c:out value="${l.produitDesignation}"/></td>
          <td><fmt:formatNumber value="${l.produitPrix}" minFractionDigits="2"/></td>
          <td>${l.quantite}</td>
          <td><fmt:formatNumber value="${l.sousTotal}" minFractionDigits="2"/></td>
          <td>
            <a class="btn btn-danger"
               href="commandes?action=deleteLigne&id=${commande.id}&ligneId=${l.id}"
               onclick="return confirm('Supprimer cette ligne ?')">Supprimer</a>
          </td>
        </tr>
      </c:forEach>
      <c:if test="${empty lignes}">
        <tr><td colspan="5">Aucune ligne. Ajoutez un produit ci-dessous.</td></tr>
      </c:if>
      <tr>
        <th colspan="3" style="text-align:right">TOTAL (DH)</th>
        <th colspan="2"><fmt:formatNumber value="${commande.total}" minFractionDigits="2"/></th>
      </tr>
    </table>

    <h3>Ajouter une ligne</h3>
    <form class="f" action="commandes" method="post">
      <input type="hidden" name="action" value="addLigne"/>
      <input type="hidden" name="commandeId" value="${commande.id}"/>
      <label>Produit :</label>
      <select name="produitId" required>
        <c:forEach var="p" items="${produits}">
          <option value="${p.id}"><c:out value="${p.designation}"/> (<fmt:formatNumber value="${p.prix}" minFractionDigits="2"/> DH)</option>
        </c:forEach>
      </select><br/>
      <label>Quantité :</label><input type="number" name="quantite" min="1" value="1" required/><br/><br/>
      <button class="btn" type="submit">Ajouter</button>
    </form>
    <br/>
    <a class="btn btn-gray" href="commandes">← Retour aux commandes</a>
  </div>
</body>
</html>