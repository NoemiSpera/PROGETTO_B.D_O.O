package Model;

public class Utente {

	protected String Nome;
	protected String Cognome;
	protected String Login;
	protected String Password;
	
	
	public Utente(String nome, String cognome, String login, String password) {
		super();
		Nome = nome;
		Cognome = cognome;
		Login = login;
		Password = password;
	}


	//METODI 
	
	       //getter and setter nome
	public String getNome() {
		return Nome;
	}
	
	public void setNome(String nome) {        
		Nome=nome;
		}
	
	      //getter and setter cognome
	public String getCognome() {
		return Cognome;
	}
	
	public void setCognome(String cognome) {        
		Cognome=cognome;
		}


         //getter and setter login
	public String getLogin() {
		return Login;
	}
	
	public void setLogin(String login) {        
		Login=login;
		}
	
	     //getter and setter password
	public String getPassword() {
		return Password;
	}
	
	public void setPassword(String password) {        
		Password=password;
		}


}

