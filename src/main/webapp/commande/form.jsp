<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Commande</title></head>
<body>
  <jsp:include page="/menu.jsp"/>
  <div class="content">
    <h2><c:out value="${empty commande ? 'Nouvelle' : 'Modifier la'}"/> commande</h2>
    <form class="f" action="commandes" method="post">
      <input type="hidden" name="id" value="${commande.id}"/>
      <label>Date :</label>
      <input type="date" name="dateCommande"
             value="${empty commande ? today : commande.dateCommande}" required/><br/>
      <label>Client :</label>
      <select name="clientId" required>
        <c:forEach var="cl" items="${clients}">
          <option value="${cl.id}" ${cl.id == commande.clientId ? 'selected' : ''}>
            <c:out value="${cl.nom} ${cl.prenom}"/>
          </option>
        </c:forEach>
      </select><br/><br/>
      <button class="btn" type="submit">Enregistrer</button>
      <a class="btn btn-gray" href="commandes">Annuler</a>
    </form>
  </div>
</body>
</html>