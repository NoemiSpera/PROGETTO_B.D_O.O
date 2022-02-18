package DAO;

import java.sql.Date;
import java.sql.Time;

public interface TestDAO {
	
	
	
	
	//getter del NoemId
		public String getNomeId();
		public int getNQuiz();
		//public void setNomeId(String nomeID)
		//getter data
		public Date getData();
		//public void setData(Date data);
		//getter and setter OrarioInizio
		public Time getOrarioInizio();
		public void setOrarioInizio(Time orarioInizio);
		//getter and setter OrarioFine
		public Time getOrarioFine();
		public void setOrarioFine(Time orarioFine);

}
