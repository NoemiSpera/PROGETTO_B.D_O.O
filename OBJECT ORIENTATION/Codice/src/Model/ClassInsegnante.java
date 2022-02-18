package Classes;

import java.util.ArrayList;

public class Insegnante extends Utente {

	private String IdInsegnante;
	
	public ArrayList<Corso> CorsiInsegnati=new ArrayList<Corso>();
	public ArrayList<Test> CreaTest=new ArrayList<Test>();
	
	public Insegnante(String nome, String cognome, String login, String password) {
		super(nome, cognome, login, password);
		// TODO Auto-generated constructor stub
	}
	
	
	//METODI
	 
	     //getter id_insegnante
	public String getIdInsegnante() {
		return IdInsegnante;
	}
		
}
