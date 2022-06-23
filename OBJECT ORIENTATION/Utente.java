package Model;

public class Utente {

	private String nome;
	private String cognome;
	private String login;
	private String password;


public Utente(String Nome, String Cognome, String Login, String Password){

	this.setNome(Nome);
	this.setCognome(Cognome);
	this.setLogin(Login);
	this.setPassword(Password);

}

public Utente(){};

public String getLogin() {
	return login;
}


public void setLogin(String login) {
	this.login = login;
}


public String getCognome() {
	return cognome;
}


public void setCognome(String cognome) {
	this.cognome = cognome;
}


public String getNome() {
	return nome;
}


public void setNome(String nome) {
	this.nome = nome;
}


public String getPassword() {
	return password;
}


public void setPassword(String password) {
	this.password = password;
}


}