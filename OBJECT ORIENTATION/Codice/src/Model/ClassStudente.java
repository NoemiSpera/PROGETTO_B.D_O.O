package Model;

import java.util.ArrayList;

public class Studente extends Utente {

	private String IdStudente;
	
	public ArrayList <Corso> CorsiSeguiti=new ArrayList <Corso>();
	public ArrayList<QuizSvolti> TestSvolto=new ArrayList<QuizSvolti>();
	
	
	public Studente(String nome, String cognome, String login, String password) {
		super(nome, cognome, login, password);
		// TODO Auto-generated constructor stub
	
	}

	//METODI
	
	   //getter id_studente
	public String getIdStudente() {
		return IdStudente;
	}
	
}
