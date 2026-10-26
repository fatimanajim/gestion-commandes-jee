package ma.fstt.web;

import java.io.IOException;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ma.fstt.dao.ProduitDao;
import ma.fstt.entities.Produit;

@WebServlet("/produits")
public class ProduitServlet extends HttpServlet {

    @Inject
    private ProduitDao dao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    req.getRequestDispatcher("/produit/form.jsp").forward(req, resp);
                    break;
                case "edit":
                    req.setAttribute("produit",
                        dao.findById(Integer.parseInt(req.getParameter("id"))));
                    req.getRequestDispatcher("/produit/form.jsp").forward(req, resp);
                    break;
                case "delete":
                    try {
                        dao.delete(Integer.parseInt(req.getParameter("id")));
                        resp.sendRedirect(req.getContextPath() + "/produits");
                    } catch (Exception e) {
                        req.setAttribute("error",
                            "Suppression impossible : ce produit est utilisé dans des commandes.");
                        showList(req, resp);
                    }
                    break;
                default:
                    showList(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        req.setAttribute("produits", dao.findAll());
        req.getRequestDispatcher("/produit/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            Produit p = new Produit();
            p.setDesignation(req.getParameter("designation"));
            p.setPrix(Double.parseDouble(req.getParameter("prix")));
            p.setStock(Integer.parseInt(req.getParameter("stock")));

            String id = req.getParameter("id");
            if (id == null || id.isEmpty()) {
                dao.save(p);
            } else {
                p.setId(Integer.parseInt(id));
                dao.update(p);
            }

            resp.sendRedirect(req.getContextPath() + "/produits");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
