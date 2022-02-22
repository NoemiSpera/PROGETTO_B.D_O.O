package Model;

import java.sql.Date;
import java.util.ArrayList;

public class Corso {

private String NomeCorso;	
private Date DataInizio;
private Date DataFine;

public Studente StudenteCorso;
public ArrayList <Studente> StudentiSeguono=new ArrayList <Studente>();
public ArrayList <Test> UnTest=new ArrayList <Test>();

public Corso(String nomeCorso, Date dataInizio, Date dataFine) {
	super();
	NomeCorso = nomeCorso;
	DataInizio = dataInizio;
	DataFine = dataFine;
}
  

//METODI 
 
    //getter and setter NomeCorso
public String getNomeCorso() {
	return NomeCorso;
}

public void setNomeCorso(String nomeCorso) {        
	NomeCorso=nomeCorso;
	}

public Date getDataInizio() {
	return DataInizio;
}

/*public void setDataInzio(String dataInizio) {        
	DataInizio=dataInizio;
	}
*/

public Date getDataFine() {
	return DataFine;
}

/*public void setDataFine(String dataFine) {        
	DataFine=dataFine;
	}*/
	
	
}
