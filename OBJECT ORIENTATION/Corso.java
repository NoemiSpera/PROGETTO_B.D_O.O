package Model;

import java.sql.Date;

public class Corso {

	private String nome;
	private String data_inizio;
	private String data_fine;
	private String cod_corso;
	private String id_ins;
	

 public Corso (String cod_corso, String nome, String id_ins, String data_inizio, String data_fine) {
		this.setCod_corso(cod_corso);
		this.setNome(nome);
		this.setId_ins(id_ins);
		this.setData_inizio(data_inizio);
		this.setData_fine(data_fine);
	}


public String getId_ins() {
	return id_ins;
}


public void setId_ins(String id_ins) {
	this.id_ins = id_ins;
}


public String getData_fine() {
	return data_fine;
}


public void setData_fine(String data_fine) {
	this.data_fine = data_fine;
}


public String getData_inizio() {
	return data_inizio;
}


public void setData_inizio(String data_inizio) {
	this.data_inizio = data_inizio;
}


public String getNome() {
	return nome;
}


public void setNome(String nome) {
	this.nome = nome;
}


public String getCod_corso() {
	return cod_corso;
}


public void setCod_corso(String cod_corso) {
	this.cod_corso = cod_corso;
}
		
	
	
}
