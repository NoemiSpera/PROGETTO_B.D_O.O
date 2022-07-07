package dao;
import database_connection.*;
import model.*;

import java.sql.*;

public interface InsegnanteDAO {


	
	
	
	public void InserisciIns(Insegnante i);
	public String contrLogI(String login, String pass);
	
}
