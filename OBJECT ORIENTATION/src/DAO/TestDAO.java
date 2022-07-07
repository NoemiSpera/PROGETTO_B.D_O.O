package DAO;
import Model.*;
import database_connection.*;
import java.sql.*;
import java.util.*;

import javax.swing.JComboBox;

public interface TestDAO {
	
public List<String> riempiCBoxTest(String nome, List<String> te);
public void InserisciTest(Test t);

}
