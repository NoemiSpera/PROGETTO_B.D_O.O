package GUI;

import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JTextField;
import java.awt.Color;
import javax.swing.JComboBox;
import javax.swing.JPasswordField;
import java.awt.TextField;
import java.awt.Font;
import javax.swing.JLabel;
import com.jgoodies.forms.factories.DefaultComponentFactory;

import Controlller.controller;

import javax.swing.JCheckBox;
import java.awt.Checkbox;
import java.awt.Choice;
import javax.swing.DefaultComboBoxModel;
import javax.swing.SwingConstants;

public class SignUp extends JFrame {
	private JPasswordField passwordField;
	private JTextField textFieldMatricola;
	public SignUp(controller contr) {
		controller c=contr;
		getContentPane().setFont(new Font("Times New Roman", Font.PLAIN, 11));
		getContentPane().setLayout(null);
		
		passwordField = new JPasswordField();
		passwordField.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		passwordField.setBounds(160, 114, 201, 20);
		getContentPane().add(passwordField);
		
		TextField textField_cognome = new TextField();
		textField_cognome.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		textField_cognome.setBounds(160, 60, 201, 21);
		getContentPane().add(textField_cognome);
		
		TextField textField_nome = new TextField();
		textField_nome.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		textField_nome.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		textField_nome.setBounds(160, 33, 201, 21);
		getContentPane().add(textField_nome);
		
		TextField textField_login = new TextField();
		textField_login.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		textField_login.setBounds(160, 87, 201, 21);
		getContentPane().add(textField_login);
		
		JLabel lblNome = new JLabel("Nome");
		lblNome.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblNome.setBounds(26, 33, 97, 21);
		getContentPane().add(lblNome);
		
		JLabel lblCognome = new JLabel("Cognome");
		lblCognome.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblCognome.setBounds(26, 60, 97, 21);
		getContentPane().add(lblCognome);
		
		JLabel lblLogin = new JLabel("Login");
		lblLogin.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblLogin.setBounds(26, 87, 97, 21);
		getContentPane().add(lblLogin);
		
		JLabel lblPassword = new JLabel("Password");
		lblPassword.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblPassword.setBounds(26, 112, 97, 20);
		getContentPane().add(lblPassword);
		
		JLabel lblTitolo = DefaultComponentFactory.getInstance().createTitle(" Sign Up");
		lblTitolo.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblTitolo.setBounds(0, 0, 107, 30);
		getContentPane().add(lblTitolo);
		
		JComboBox comboBoxStudIns = new JComboBox();
		comboBoxStudIns.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		comboBoxStudIns.setModel(new DefaultComboBoxModel(new String[] {"Studente", "Insegnante"}));
		comboBoxStudIns.setBounds(160, 170, 201, 22);
		getContentPane().add(comboBoxStudIns);
		
		JButton btnConferma = new JButton("Conferma");
		btnConferma.setToolTipText("Attenzione, verrai ricondotto alla home per poter fare il login con le tue credenziali");
		btnConferma.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String studins= new String (comboBoxStudIns.getSelectedItem().toString());
				if(studins.equals("Studente")) {
				
				c.registraStud(textField_nome.getText(), textField_cognome.getText(), textField_login.getText(), passwordField.getText(), textFieldMatricola.getText());
				Home ho=new Home(c);
				ho.setBounds(100, 100, 450, 300);
				ho.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				ho.show();
				dispose();
				} else if (studins.equals("Insegnante")) {
					c.registraInsegnante (textField_nome.getText(), textField_cognome.getText(), textField_login.getText(), passwordField.getText(), textFieldMatricola.getText());
					Home ho=new Home(c);
					ho.setBounds(100, 100, 450, 300);
					ho.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
					ho.show();
					dispose();
				}
			}
		});
		btnConferma.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnConferma.setBounds(203, 195, 105, 23);
		getContentPane().add(btnConferma);
		
		JButton btnAnnulla = new JButton("Annulla");
		btnAnnulla.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Home ho=new Home(c);
				ho.setBounds(100, 100, 450, 300);
				ho.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				ho.show();
				dispose();
			}
		});
		btnAnnulla.setToolTipText("Ritorni alla home");
		btnAnnulla.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnAnnulla.setBounds(318, 195, 89, 23);
		getContentPane().add(btnAnnulla);
		
		
		JLabel lblSeleziona = new JLabel("Sono un/uno");
		lblSeleziona.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblSeleziona.setBounds(26, 172, 97, 18);
		getContentPane().add(lblSeleziona);
		
		JLabel lblMatricola = new JLabel("Matricola");
		lblMatricola.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblMatricola.setBounds(26, 143, 97, 18);
		getContentPane().add(lblMatricola);
		
		textFieldMatricola = new JTextField();
		textFieldMatricola.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		textFieldMatricola.setBounds(160, 139, 201, 20);
		getContentPane().add(textFieldMatricola);
		textFieldMatricola.setColumns(10);
	}
}
