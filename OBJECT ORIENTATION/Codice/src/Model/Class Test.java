package Classes;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;

public class Test {
	
	private String NomeId;
	private int NQuiz;
	private Date Data;
	private Time OrarioInizio;
	private Time OrarioFine;
	
	private Quiz Quesito;
	public ArrayList <Corso> UnCorso=new ArrayList <Corso>();
	public ArrayList <Quiz> Componenti=new ArrayList <Quiz>();
	public QuizSvolti TestTerminato;
	public Insegnante Professore;
	

	
	//METODI
	
	   //getter del NoemId
	public String getNomeId() {
		return NomeId;
	}
	
	
	
	public int getNQuiz() {
		return NQuiz;
	}
	
	/*public void setNomeId(String nomeID) {        
		NomeId=nomeID;
		}*/
	
	
	     //getter data
	public Date getData() {
		return Data;
	}
	
	/*public void setData(Date data) {        
		Data=data;
		}*/     
	
	
	    //getter and setter OrarioInizio
	public Time getOrarioInizio() {
		return OrarioInizio;
	}
	
	public void setOrarioInizio(Time orarioInizio) {        
		OrarioInizio=orarioInizio;
		}
	
	
	     //getter and setter OrarioFine
	public Time getOrarioFine() {
		return OrarioFine;
	}
	
	public void setOrarioFine(Time orarioFine) {        
		OrarioFine=orarioFine;
		}	
	
	
}
