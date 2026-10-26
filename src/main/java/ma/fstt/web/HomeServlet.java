package ma.fstt.web;

import java.io.IOException;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ma.fstt.dao.ClientDao;
import ma.fstt.dao.CommandeDao;
import ma.fstt.dao.ProduitDao;
import ma.fstt.entities.Commande;

@WebServlet("/accueil")
public class HomeServlet extends HttpServlet {

    @Inject private ClientDao clientDao;
    @Inject private ProduitDao produitDao;
    @Inject private CommandeDao commandeDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<Commande> commandes = commandeDao.findAll();

            double chiffreAffaires = 0;
            for (Commande c : commandes) chiffreAffaires += c.getTotal();

            req.setAttribute("nbClients", clientDao.findAll().size());
            req.setAttribute("nbProduits", produitDao.findAll().size());
            req.setAttribute("nbCommandes", commandes.size());
            req.setAttribute("chiffreAffaires", chiffreAffaires);
            req.setAttribute("dernieres", commandes.subList(0, Math.min(5, commandes.size())));

            req.getRequestDispatcher("/accueil.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}