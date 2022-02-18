package Classes;

import java.util.ArrayList;

public class QuizSvolti {
	
	private String RispostaData;
	private float PunteggioQuiz;
	

	public Studente StudSvolgeQuiz;
	public QuizRispApe RispAperte;
	public QuizRispMul RispMul;
	public ArrayList<Test> TestDaSvolgere=new ArrayList<Test>();
	
	
	//METODI
	
	     //getter RispostaData
	public String getRispostaData() {
		return RispostaData;
	}
	
	     //getter and setter PunteggioQuiz
	public float getPunteggioQuiz() {
		return PunteggioQuiz;
	}
	
	public void setPunteggioQuiz(float punteggioQuiz) {
		PunteggioQuiz=punteggioQuiz;
	}
	
}
