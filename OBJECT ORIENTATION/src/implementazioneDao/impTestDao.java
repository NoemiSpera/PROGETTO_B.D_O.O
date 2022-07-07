package implementazioneDao;

import java.sql.Connection;
import java.sql.SQLException;

import database_connection.database_connection;

public class impTestDao {
	public Connection connessione;
	
	public void TestDAO() {
        try {
            connessione = database_connection.getInstance().getConnection();
        } catch (SQLException e) {
            System.out.println("Connessione fallita.");
            e.printStackTrace();
        }
    }
	

}
