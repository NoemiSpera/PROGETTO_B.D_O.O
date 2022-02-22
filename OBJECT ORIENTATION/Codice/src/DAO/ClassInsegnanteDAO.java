package DAO;

import java.sql.Date;
import java.sql.Time;
import Model.Test; 
import Model.QuizRispApe;
import Model.QuizRispMul;
import Model.QuizSvolti;



public interface InsegnanteDAO extends UtenteDAO{
	
	
	
	public int CreazioneTest(String nomeId, int NQuiz, Date Data,Time OrarioInizio,Time OrarioFine);
	public int ValutazioneTest(QuizRispApe IdQuizA,QuizRispMul IdQuizM, float punteggio_quiz);
	
	
	public String getIdInsegnante();

}
