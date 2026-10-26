package ma.fstt.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.enterprise.context.ApplicationScoped;
import ma.fstt.entities.Commande;
import ma.fstt.service.IDao;

@ApplicationScoped
public class CommandeDao implements IDao<Commande> {

    private static final String SELECT =
        "SELECT c.id, c.date_commande, c.client_id, " +
        "CONCAT(cl.nom, ' ', cl.prenom) AS client_nom, " +
        "COALESCE((SELECT SUM(l.quantite * p.prix) FROM ligne_commande l " +
        "          JOIN produit p ON l.produit_id = p.id " +
        "          WHERE l.commande_id = c.id), 0) AS total " +
        "FROM commande c JOIN client cl ON c.client_id = cl.id ";

    @Override
    public void save(Commande c) throws Exception {
        String sql = "INSERT INTO commande(date_commande, client_id) VALUES(?,?)";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setDate(1, c.getDateCommande());
            ps.setInt(2, c.getClientId());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) c.setId(keys.getInt(1));   // récupère l'id généré
            }
        }
    }

    @Override
    public void update(Commande c) throws Exception {
        String sql = "UPDATE commande SET date_commande=?, client_id=? WHERE id=?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setDate(1, c.getDateCommande());
            ps.setInt(2, c.getClientId());
            ps.setInt(3, c.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement("DELETE FROM commande WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();   // les lignes sont supprimées en cascade
        }
    }

    @Override
    public Commande findById(int id) throws Exception {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(SELECT + "WHERE c.id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    @Override
    public List<Commande> findAll() throws Exception {
        List<Commande> list = new ArrayList<>();
        try (Connection cn = DBConnection.getConnection();
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery(SELECT + "ORDER BY c.id DESC")) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    private Commande map(ResultSet rs) throws SQLException {
        Commande c = new Commande(rs.getInt("id"), rs.getDate("date_commande"), rs.getInt("client_id"));
        c.setClientNom(rs.getString("client_nom"));
        c.setTotal(rs.getDouble("total"));
        return c;
    }
}