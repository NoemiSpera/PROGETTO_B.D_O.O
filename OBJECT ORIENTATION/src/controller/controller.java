package Controlller;
import Model.*;
import database_connection.database_connection;
import DAO.*;

public class controller {

	Studente s;
	Insegnante i;
	
	public void registraStud (String nome, String cognome, String login, String password, String matricolaStud) {
		s=new Studente(nome, cognome, login, password, matricolaStud);
		StudenteDAO studentedb=new StudenteDAO();
		studentedb.InserisciStud(s);
	}

	public void registraInsegnante (String nome, String cognome, String login, String password, String matricolaIns ) {
		i=new Insegnante(nome, cognome, login, password, matricolaIns);
		InsegnanteDAO insegnantedb=new InsegnanteDAO();
		insegnantedb.InserisciIns(i);
	}

}
