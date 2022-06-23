package Model;

public class Insegnante extends Utente {

	private String matricolaIns;
	
 public Insegnante (String nome, String cognome, String login, String password, String matricolaIns) {
		this.setNome(nome);
		this.setCognome(cognome);
		this.setLogin(login);
		this.setPassword(password);
		this.setMatricolaIns(matricolaIns);
	}

public String getMatricolaIns() {
	return matricolaIns;
}

public void setMatricolaIns(String matricolaIns) {
	this.matricolaIns = matricolaIns;
}
		
	
}
