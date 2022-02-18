package DAO;

import Classes.Test;
import Classes.QuizSvolti;

public interface StudenteDAO extends UtenteDAO{

	public int/*?*/ SvolgimentoTest(Test test);
	public QuizSvolti VisualizzaRisultatiTest(QuizSvolti quizSvolti);
	
	public String getIdStudente();
		
}
