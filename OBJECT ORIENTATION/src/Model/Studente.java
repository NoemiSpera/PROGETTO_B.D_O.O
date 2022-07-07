package Model;

public class Studente extends Utente {

	private String matricolaStud;
	
public Studente(String Nome, String Cognome, String Login, String Password, String MatricolaStud) {
		this.matricolaStud=MatricolaStud;
}

public String getMatricolaStud() {
	return matricolaStud;
}

public void setMatricolaStud(String matricolaStud) {
	this.matricolaStud = matricolaStud;
}
	 
	
}
