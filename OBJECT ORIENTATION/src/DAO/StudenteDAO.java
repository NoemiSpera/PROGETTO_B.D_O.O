package dao;
import database_connection.*;
import model.*;

import java.sql.*;

public interface StudenteDAO {

   public void InserisciStud(Studente s);
   public String contrLog(String login, String pass);
}
