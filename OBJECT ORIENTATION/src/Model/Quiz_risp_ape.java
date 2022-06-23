package Model;


public class Quiz_risp_ape extends Quiz{

	private int max_lenght;
	private float punt_max;
	private float punt_min;

	

 public Quiz_risp_ape (String domanda, String id_quiz, int max_lenght, float punt_max, float punt_min) {
		this.domanda = domanda;
		this.id_quiz=id_quiz;
		this.max_lenght=max_lenght;
		this.punt_max=punt_max;
		this.punt_min=punt_min;
		
	}
		
}
