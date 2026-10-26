package ma.fstt.entities;

import java.sql.Date;

public class Commande {
    private int id;
    private Date dateCommande;
    private int clientId;
    private String clientNom;   // pour l'affichage (jointure)
    private double total;       // pour l'affichage (somme des lignes)

    public Commande() {}

    public Commande(int id, Date dateCommande, int clientId) {
        this.id = id;
        this.dateCommande = dateCommande;
        this.clientId = clientId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getDateCommande() { return dateCommande; }
    public void setDateCommande(Date dateCommande) { this.dateCommande = dateCommande; }
    public int getClientId() { return clientId; }
    public void setClientId(int clientId) { this.clientId = clientId; }
    public String getClientNom() { return clientNom; }
    public void setClientNom(String clientNom) { this.clientNom = clientNom; }
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
}