package ma.fstt.entities;

public class LigneCommande {
    private int id;
    private int commandeId;
    private int produitId;
    private int quantite;
    private String produitDesignation;  // pour l'affichage (jointure)
    private double produitPrix;         // pour l'affichage (jointure)

    public LigneCommande() {}

    public LigneCommande(int id, int commandeId, int produitId, int quantite) {
        this.id = id;
        this.commandeId = commandeId;
        this.produitId = produitId;
        this.quantite = quantite;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getCommandeId() { return commandeId; }
    public void setCommandeId(int commandeId) { this.commandeId = commandeId; }
    public int getProduitId() { return produitId; }
    public void setProduitId(int produitId) { this.produitId = produitId; }
    public int getQuantite() { return quantite; }
    public void setQuantite(int quantite) { this.quantite = quantite; }
    public String getProduitDesignation() { return produitDesignation; }
    public void setProduitDesignation(String d) { this.produitDesignation = d; }
    public double getProduitPrix() { return produitPrix; }
    public void setProduitPrix(double p) { this.produitPrix = p; }

    public double getSousTotal() { return quantite * produitPrix; }
}