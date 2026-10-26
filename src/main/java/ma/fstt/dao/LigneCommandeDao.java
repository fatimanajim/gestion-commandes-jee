package ma.fstt.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.enterprise.context.ApplicationScoped;
import ma.fstt.entities.LigneCommande;
import ma.fstt.service.IDao;

@ApplicationScoped
public class LigneCommandeDao implements IDao<LigneCommande> {

    private static final String SELECT =
        "SELECT l.id, l.commande_id, l.produit_id, l.quantite, " +
        "p.designation, p.prix " +
        "FROM ligne_commande l JOIN produit p ON l.produit_id = p.id ";

    @Override
    public void save(LigneCommande l) throws Exception {
        String sql = "INSERT INTO ligne_commande(commande_id, produit_id, quantite) VALUES(?,?,?)";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, l.getCommandeId());
            ps.setInt(2, l.getProduitId());
            ps.setInt(3, l.getQuantite());
            ps.executeUpdate();
        }
    }

    @Override
    public void update(LigneCommande l) throws Exception {
        String sql = "UPDATE ligne_commande SET produit_id=?, quantite=? WHERE id=?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, l.getProduitId());
            ps.setInt(2, l.getQuantite());
            ps.setInt(3, l.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement("DELETE FROM ligne_commande WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public LigneCommande findById(int id) throws Exception {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(SELECT + "WHERE l.id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    @Override
    public List<LigneCommande> findAll() throws Exception {
        List<LigneCommande> list = new ArrayList<>();
        try (Connection cn = DBConnection.getConnection();
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery(SELECT + "ORDER BY l.id")) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<LigneCommande> findByCommande(int commandeId) throws Exception {
        List<LigneCommande> list = new ArrayList<>();
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(SELECT + "WHERE l.commande_id=? ORDER BY l.id")) {
            ps.setInt(1, commandeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    private LigneCommande map(ResultSet rs) throws SQLException {
        LigneCommande l = new LigneCommande(rs.getInt("id"), rs.getInt("commande_id"),
                rs.getInt("produit_id"), rs.getInt("quantite"));
        l.setProduitDesignation(rs.getString("designation"));
        l.setProduitPrix(rs.getDouble("prix"));
        return l;
    }
}