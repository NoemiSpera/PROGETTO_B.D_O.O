package GUI;

import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.*;
import java.awt.event.ActionEvent;
import javax.swing.JTextField;
import java.awt.Color;
import javax.swing.JComboBox;
import javax.swing.JPasswordField;
import java.awt.TextField;
import java.awt.Font;
import javax.swing.JLabel;
import com.jgoodies.forms.factories.DefaultComponentFactory;
import com.toedter.calendar.JCalendar;

import Controlller.controller;
import DAO.CorsoDAO;
import DAO.TestDAO;

import javax.swing.JCheckBox;
import java.awt.Checkbox;
import java.awt.Choice;
import javax.swing.DefaultComboBoxModel;
import javax.swing.SwingConstants;
import javax.swing.JList;
import javax.swing.AbstractListModel;
import javax.swing.ListSelectionModel;


public class SignInS extends JFrame implements ActionListener {
	private JPasswordField passwordField;
	private JPanel panel2 = new JPanel();
	List<String> cose = new ArrayList<String>();
	List<String> te = new ArrayList<String>();
	private JComboBox comboBox;	
 

	public SignInS(controller contr, String login) {
		getContentPane().setLayout(null);
		
		CorsoDAO cors= new CorsoDAO();
		cose=cors.riempiCboxS(login, cose);
		comboBox = new JComboBox(cose.toArray());
		
		
		TestDAO test=new TestDAO();
		

		JLabel lblTitolo = DefaultComponentFactory.getInstance().createTitle(" Area Studenti");
		lblTitolo.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblTitolo.setBounds(0, 0, 156, 19);
		getContentPane().add(lblTitolo);
		
		panel2.setBounds(252, 85, 146, 111);
		getContentPane().add(panel2);
		panel2.setLayout(null);
		
		panel2.setVisible(false);
		
		JLabel lblTest = new JLabel("Test");
		lblTest.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblTest.setBounds(10, 11, 49, 14);
		panel2.add(lblTest);
		
		JButton btnIndietro = new JButton("Cambia corso");
		btnIndietro.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				panel2.setVisible(false);
			}
		});
		btnIndietro.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnIndietro.setBounds(10, 75, 136, 23);
		panel2.add(btnIndietro);
		
				
		comboBox.addActionListener(this);
		comboBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
					if(e.getSource()==comboBox) {
					panel2.setVisible(true);
					te=test.riempiCBoxTest(comboBox.getSelectedItem().toString(), te);
					JComboBox comboBox_2 = new JComboBox(te.toArray());
					comboBox_2.setBounds(10, 34, 126, 22);
					panel2.add(comboBox_2);
					
		}
	}
			
		});
		
		
			
		comboBox.setMaximumRowCount(100);
		comboBox.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		comboBox.setBounds(260, 30, 138, 22);
		getContentPane().add(comboBox);
		
		
		
		JButton btnHome = new JButton("Home");
		btnHome.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Home ho=new Home(contr);
				ho.setBounds(100, 100, 450, 300);
				ho.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				ho.show();
				dispose();
			}
		});
		btnHome.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnHome.setBounds(309, 229, 89, 23);
		getContentPane().add(btnHome);
		
		


}


	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		
	}
}


//si seleziona un test, si controlla se è stato svolto o no. se è stato svolto si apre la correzione, se no si apre la pagina per svolgerlo