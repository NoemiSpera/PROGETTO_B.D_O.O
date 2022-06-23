package implementazioneDao;

import java.sql.Connection;
import java.sql.SQLException;

import Model.Insegnante;
import database_connection.database_connection;

public class impInsegnanteDao {

	public Connection connessione;
	
	public void InsegnanteDAO() {
        try {
            connessione = database_connection.getInstance().getConnection();
        } catch (SQLException e) {
            System.out.println("Connessione fallita.");
            e.printStackTrace();
        }
    }

	public void InserisciIns(Insegnante i) {
		// TODO Auto-generated method stub
		
	}
	
}
