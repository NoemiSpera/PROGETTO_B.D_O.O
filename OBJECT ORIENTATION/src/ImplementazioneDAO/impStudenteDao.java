package implementazioneDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Model.Studente;
import database_connection.database_connection;


public class impStudenteDao {
	public Connection connessione;
	
	public impStudenteDao() {
        try {
            connessione = database_connection.getInstance().getConnection();
        } catch (SQLException e) {
            System.out.println("Connessione fallita.");
            e.printStackTrace();
        }
    }

	public void InserisciStud(Studente s) {
		// TODO Auto-generated method stub
		
	}
	
	
}
