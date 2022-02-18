package Classes;

import java.util.ArrayList;

public class QuizRispMul {

	private String IdQuizM;
	private String RispostaCorretta;
	private int PuntCorretto;
	private int PuntErrato;
	private String RispostaA;
	private String RispostaB;
	private String RispostaC;
	private String RispostaD;

	
	public ArrayList<QuizSvolti> RisposteMultiple=new ArrayList<QuizSvolti>();
	
	

	public QuizRispMul(String rispostaCorretta, int puntCorretto, int puntErrato, String rispostaA, String rispostaB,
			String rispostaC, String rispostaD, ArrayList<QuizSvolti> risposteMultiple) {
		super();
		RispostaCorretta = rispostaCorretta;
		PuntCorretto = puntCorretto;
		PuntErrato = puntErrato;
		RispostaA = rispostaA;
		RispostaB = rispostaB;
		RispostaC = rispostaC;
		RispostaD = rispostaD;
		RisposteMultiple = risposteMultiple;
	}

	//METODI
	
	  //getter id ìQuiz
	public String getIdQuizM() {
		return IdQuizM;
	}
	
	   //getter RispostaCorretta
	public String getRispostaCorretta() {
		return RispostaCorretta;
	}
	
	   //getter PuntCorretto
	public int getPuntCorretto() {
		return PuntCorretto;
	}
	
	
	   //getter PuntErrato
	public int getPuntErrato() {
		return PuntErrato;
	}
	
	  //getter and setter 
	public String getRispostaA() {
		return RispostaA;
	}
	
	public void setRispostaA(String rispostaA) {
		RispostaA=rispostaA;
	}
	
	public String getRispostaB() {
		return RispostaB;
	}
	
	public void setRispostaB(String rispostaB) {
		RispostaB=rispostaB;
	}
	public String getRispostaC() {
		return RispostaC;
	}
	
	public void setRispostaC(String rispostaC) {
		RispostaA=rispostaC;
	}
	public String getRispostaD() {
		return RispostaD;
	}
	
	public void setRispostaD(String rispostaD) {
		RispostaA=rispostaD;
	}
	
	
}
