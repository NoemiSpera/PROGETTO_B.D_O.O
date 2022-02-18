package DAO;



public interface UtenteDAO {

	public String RegistrazioneUtente(String Nome, String Cognome, String Login, String Password);
	public String Login(String Login, String Password);
	

	
    //getter and setter nome
public String getNome();
public void setNome(String nome);

   //getter and setter cognome
public String getCognome();
public void setCognome(String cognome);

   //getter and setter login
public String getLogin();
public void setLogin(String login);

  //getter and setter password
public String getPassword();
public void setPassword(String password);




}
