package Model;


public class Quiz_risp_mul extends Quiz{

	private String risposte [];
	private String risposta_corretta;
	private int punt_corretto;
	private int punt_errato;

	

 public Quiz_risp_mul (String domanda, String id_quiz, String risposte [], String risposta_corretta, int punt_corretto, int punt_errato) {
		this.domanda = domanda;
		this.id_quiz=id_quiz;
		this.risposte=risposte;
		this.risposta_corretta=risposta_corretta;
		this.punt_corretto=punt_corretto;
		this.punt_errato=punt_errato;
		
	}
		
}