package Classes;

import java.util.ArrayList;

public class QuizRispApe extends Quiz {
	
	private int MaxLength;
	private float PuntMax;
	private float PuntMin;
	
	
	public ArrayList<QuizSvolti> RisposteAperte =new ArrayList<QuizSvolti>();
	
	public QuizRispApe(String domanda, String idQuiz, int maxLength, float puntMax, float puntMin) {
		super(domanda, idQuiz);
		MaxLength = maxLength;
		PuntMax = puntMax;
		PuntMin = puntMin;
	}
	
	
		//METODI
	
	
	    //getter and setter MaxLenght
	public int getMaxlength() {
		return MaxLength;
	}
	
	public void setMaxLength(int maxLength) {        
		MaxLength=maxLength;
		}
	
	     //getter and setter PuntMax
	public float getPuntMax() {
		return PuntMax;
	}
	
	public void setPuntMax(float puntMax) {        
		PuntMax=puntMax;
		}
	
	     //getter and settere PuntMin
	public float getPuntMin() {
		return PuntMin;
	}
	
	public void setPuntMin(float puntMin) {        
		PuntMin=puntMin;
		}
	

}
