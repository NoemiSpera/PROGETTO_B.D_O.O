	package DAO;
	import Model.*;
	import database_connection.*;
	import java.sql.*;
   import java.util.*;

import javax.swing.JComboBox;
	
	public interface CorsoDAO {
	
		

		
		
		
public List<String> riempiCbox(String login, List<String> cose);
	
public List<String> riempiCboxS(String login, List<String> cose);
		
public void InserisciCorso(Corso c);
		
	
}

	