package implementazioneDao;

import java.sql.Connection;
import java.sql.SQLException;

import Model.Corso;
import database_connection.database_connection;

public class impCorsoDao {

	public Connection connessione;
	
	public void CorsoDAO() {
        try {
            connessione = database_connection.getInstance().getConnection();
        } catch (SQLException e) {
            System.out.println("Connessione fallita.");
            e.printStackTrace();
        }
    }

	public void InserisciCorso(Corso c) {
		// TODO Auto-generated method stub
		
	} 
	
}
