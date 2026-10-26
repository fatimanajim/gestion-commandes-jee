package ma.fstt.dao;

public class Test {
    public static void main(String[] args) throws Exception {
        new ClientDao().findAll().forEach(c ->
            System.out.println(c.getId() + " " + c.getNom() + " " + c.getPrenom()));
        new CommandeDao().findAll().forEach(c ->
            System.out.println("Commande " + c.getId() + " - " + c.getClientNom() + " - " + c.getTotal()));
    }
}