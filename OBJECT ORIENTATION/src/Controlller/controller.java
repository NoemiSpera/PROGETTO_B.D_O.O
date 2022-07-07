package Controlller;
import Model.*;
import database_connection.database_connection;
import implementazioneDao.impCorsoDao;
import implementazioneDao.impInsegnanteDao;
import implementazioneDao.impStudenteDao;
import implementazioneDao.impTestDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import DAO.*;

public class controller {

	private Studente s;
	private Insegnante i;
	private Corso c;
	private impCorsoDao ic;
	private impInsegnanteDao ii;
	private impStudenteDao is;
	private impTestDao it;
	
	public controller() {
		ic=new impCorsoDao();
		ii=new impInsegnanteDao();
		is=new impStudenteDao();
		it=new impTestDao();
	}
	
	
	private Connection connessione;
	private Test t;
	

public void InserisciStud(Studente s) {
		
		PreparedStatement insert;
        this.s=s;
        try {
            insert = connessione.prepareStatement(
                    "INSERT INTO STUDENTE VALUES ('"+s.getMatricolaStud()+"','"+s.getNome()+"','"+s.getCognome()+"','"+s.getLogin()+"','"+s.getPassword()+"');");

        insert.executeUpdate();

        } 
        catch (SQLException e) {

            e.printStackTrace();

        }
	}
        
   public String contrLog(String login, String pass) {
    		
    		PreparedStatement select;
            try {
                select = connessione.prepareStatement("Select password from STUDENTE where login= ('"+login+"');");
                ResultSet rs = select.executeQuery();
                while ( rs.next() ) {
                    pass = rs.getString("password");
                }

            } 
            catch (SQLException e) {

                e.printStackTrace();

            }
			return pass;

   }
   
	public void InserisciIns(Insegnante i) {
		
		PreparedStatement insert;
        this.i=i;
        try {
            insert = connessione.prepareStatement(
                    "INSERT INTO INSEGNANTE VALUES ('"+i.getMatricolaIns()+"','"+i.getNome()+"','"+i.getCognome()+"','"+i.getLogin()+"','"+i.getPassword()+"');");

        insert.executeUpdate();

        } 
        catch (SQLException e) {

            e.printStackTrace();

        }
		
	}
	
	
	public String contrLogI(String login, String pass) {
		
		PreparedStatement select;
        try {
            select = connessione.prepareStatement("Select password from insegnante where login= ('"+login+"');");
            ResultSet rs = select.executeQuery();
            while ( rs.next() ) {
                pass = rs.getString("password");
            }

        } 
        catch (SQLException e) {

            e.printStackTrace();

        }
		return pass;

}
	
	public List<String> riempiCbox(String login, List<String> cose) {
		
		PreparedStatement select;
        try {
            select = connessione.prepareStatement("SELECT NOME FROM CORSO WHERE ID_INS IN (SELECT ID_INS FROM INSEGNANTE WHERE LOGIN='"+login+"');");
            ResultSet rs = select.executeQuery();
            int i=1;
            while ( rs.next() ) {
            	cose.add(rs.getString("nome"));
            	i++;
            }

        } 
        catch (SQLException e) {

            e.printStackTrace();

        }
		return cose;

}


public List<String> riempiCboxS(String login, List<String> cose) {
		
		PreparedStatement select;
        try {
            select = connessione.prepareStatement("SELECT NOME FROM CORSO");
            ResultSet rs = select.executeQuery();
            int i=1;
            while ( rs.next() ) {
            	cose.add(rs.getString("nome"));
            }

        } 
        catch (SQLException e) {

            e.printStackTrace();

        }
		return cose;

}
	
public void InserisciCorso(Corso c) {
		
		PreparedStatement insert;
        this.c=c;
        try {
            insert = connessione.prepareStatement(
                    "INSERT INTO Corso VALUES ('"+c.getCod_corso()+"','"+c.getNome()+"','"+c.getId_ins()+"','"+c.getData_inizio()+"','"+c.getData_fine()+"');");

        insert.executeUpdate();

        } 
        catch (SQLException e) {

            e.printStackTrace();

        }
		
	}
	

public List<String> riempiCBoxTest(String nome, List<String> te) {
	
	PreparedStatement select;
    try {
        select = connessione.prepareStatement("SELECT nome_id FROM test WHERE cod_corso IN (SELECT cod_corso FROM Corso WHERE nome='"+nome+"');");
        ResultSet rs = select.executeQuery();
        int i=1;
        while ( rs.next() ) {
        	te.add(rs.getString("nome_id"));
        	i++;
        }

    } 
    catch (SQLException e) {

        e.printStackTrace();

    }
	return te;

}







public void InserisciTest(Test t) {
	
	PreparedStatement insert;
    this.t=t;
    try {
        insert = connessione.prepareStatement(
                "INSERT INTO test VALUES ('"+t.getNome_id()+"','"+t.getN_quiz()+"','"+t.getData()+"','"+t.getOra_inizio()+"','"+t.getOra_fine()+"','"+t.getCod_corso()+"','"+t.getId_ins()+"');");

    insert.executeUpdate();

    } 
    catch (SQLException e) {

        e.printStackTrace();

    }
	
}
   

public void registraStud (String nome, String cognome, String login, String password, String matricolaStud) {
	s=new Studente(nome, cognome, login, password, matricolaStud);
	is.InserisciStud(s);
}

public void registraInsegnante (String nome, String cognome, String login, String password, String matricolaIns ) {
	i=new Insegnante(nome, cognome, login, password, matricolaIns);
	
	ii.InserisciIns(i);
}

public void registraCorso (String cod_corso, String nome, String id_ins, String data_inizio, String data_fine ) {
	c=new Corso (cod_corso, nome, id_ins, data_inizio,  data_fine );
	
	ic.InserisciCorso(c);
}
}
