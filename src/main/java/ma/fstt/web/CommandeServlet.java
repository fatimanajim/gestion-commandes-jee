package ma.fstt.web;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ma.fstt.dao.ClientDao;
import ma.fstt.dao.CommandeDao;
import ma.fstt.dao.LigneCommandeDao;
import ma.fstt.dao.ProduitDao;
import ma.fstt.entities.Commande;
import ma.fstt.entities.LigneCommande;

@WebServlet("/commandes")
public class CommandeServlet extends HttpServlet {

    @Inject private CommandeDao commandeDao;
    @Inject private LigneCommandeDao ligneDao;
    @Inject private ClientDao clientDao;
    @Inject private ProduitDao produitDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";
        try {
            switch (action) {
                case "new":
                    req.setAttribute("clients", clientDao.findAll());
                    req.setAttribute("today", LocalDate.now().toString());
                    req.getRequestDispatcher("/commande/form.jsp").forward(req, resp);
                    break;

                case "edit":
                    req.setAttribute("commande", commandeDao.findById(Integer.parseInt(req.getParameter("id"))));
                    req.setAttribute("clients", clientDao.findAll());
                    req.getRequestDispatcher("/commande/form.jsp").forward(req, resp);
                    break;

                case "detail":
                    showDetail(req, resp, Integer.parseInt(req.getParameter("id")));
                    break;

                case "delete":
                    commandeDao.delete(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect("commandes");
                    break;

                case "deleteLigne":
                    ligneDao.delete(Integer.parseInt(req.getParameter("ligneId")));
                    resp.sendRedirect("commandes?action=detail&id=" + req.getParameter("id"));
                    break;

                default:
                    req.setAttribute("commandes", commandeDao.findAll());
                    req.getRequestDispatcher("/commande/list.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp, int id) throws Exception {
        Commande commande = commandeDao.findById(id);
        if (commande == null) {
            resp.sendRedirect("commandes");
            return;
        }
        req.setAttribute("commande", commande);
        req.setAttribute("lignes", ligneDao.findByCommande(id));
        req.setAttribute("produits", produitDao.findAll());
        req.getRequestDispatcher("/commande/detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        try {
            if ("addLigne".equals(action)) {
                LigneCommande l = new LigneCommande();
                l.setCommandeId(Integer.parseInt(req.getParameter("commandeId")));
                l.setProduitId(Integer.parseInt(req.getParameter("produitId")));
                l.setQuantite(Integer.parseInt(req.getParameter("quantite")));
                ligneDao.save(l);
                resp.sendRedirect("commandes?action=detail&id=" + l.getCommandeId());
                return;
            }

            // Enregistrement d'une commande (création ou modification)
            Commande c = new Commande();
            c.setDateCommande(Date.valueOf(req.getParameter("dateCommande")));
            c.setClientId(Integer.parseInt(req.getParameter("clientId")));

            String id = req.getParameter("id");
            if (id == null || id.isEmpty()) {
                commandeDao.save(c);          // c.getId() est renseigné par le DAO
            } else {
                c.setId(Integer.parseInt(id));
                commandeDao.update(c);
            }
            resp.sendRedirect("commandes?action=detail&id=" + c.getId());
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}