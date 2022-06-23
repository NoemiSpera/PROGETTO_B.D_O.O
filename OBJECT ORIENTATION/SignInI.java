package GUI;

import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.*;
import java.util.Properties;
import java.awt.event.ActionEvent;
import javax.swing.JTextField;
import java.awt.Color;
import java.awt.Component;

import javax.swing.JComboBox;
import javax.swing.JPasswordField;
import java.awt.TextField;
import java.awt.Font;
import javax.swing.JLabel;
import com.jgoodies.forms.factories.DefaultComponentFactory;
import com.toedter.calendar.JCalendar;

import java.awt.Container;

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
import java.awt.Panel;
import javax.swing.JSpinner;
import javax.swing.SpinnerDateModel;
import javax.swing.SpinnerListModel;
import javax.swing.SpinnerModel;
import javax.swing.SpinnerNumberModel;

import java.util.Date;
import java.util.Calendar;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JTextPane;

public class SignInI extends JFrame implements ActionListener {
	private JPasswordField passwordField;
	private JTextField textFieldCodice;
	private JTextField textField;
	private JTextField textField_1;
	private JPanel panel = new JPanel();
	private JCalendar calendar = new JCalendar();
	private JCalendar calendar2 = new JCalendar();
	private JPanel panel2 = new JPanel();
	private JPanel panel3= new JPanel();
	List<String> cose = new ArrayList<String>();
	List<String> te = new ArrayList<String>();
	private JComboBox comboBox;	
	private JComboBox comboBox_1;
	private TestDAO test=new TestDAO();
 
	

	public SignInI(controller contr, String login) {
		getContentPane().setLayout(null);
		te.clear();
		CorsoDAO cors= new CorsoDAO();
		//String [] arr=(String[]) cose.toArray(new String[cose.size()]);
		cose=cors.riempiCbox(login, cose);
		comboBox = new JComboBox(cose.toArray());
		
		

		

		
		JLabel lblTitolo = DefaultComponentFactory.getInstance().createTitle(" Area Insegnanti");
		lblTitolo.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblTitolo.setBounds(0, 0, 156, 19);
		getContentPane().add(lblTitolo);
		
		panel2.setBounds(282, 108, 146, 110);
		getContentPane().add(panel2);
		panel2.setLayout(null);
		panel2.setVisible(false);
		
		panel3.setBounds(282, 108, 146, 110);
		getContentPane().add(panel2);
		panel3.setLayout(null);
		panel3.setVisible(false);
		
		
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
		
		
		
		
		te.clear();
		comboBox.addActionListener(this);
		comboBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
					if(e.getSource()==comboBox){
					panel2.setVisible(true);
					te.clear();
					comboBox_1 = new JComboBox();
					comboBox_1.removeAllItems();
					te=test.riempiCBoxTest(comboBox.getSelectedItem().toString(), te);
					//String [] arr1=(String[]) te.toArray(new String[te.size()]);
					comboBox_1 = new JComboBox(te.toArray());
					comboBox_1.setBounds(10, 34, 126, 22);
					panel2.add(comboBox_1);
					
		}
	}
			
	
		});
		
		
		
			
		comboBox.setMaximumRowCount(100);
		comboBox.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		comboBox.setBounds(282, 41, 138, 22);
		getContentPane().add(comboBox);


		
		panel.setBounds(10, 21, 262, 399);
		panel.setLayout(null);
		getContentPane().add(panel);
		panel.setVisible(false);
		
		
		JLabel lblCodiceCorso = new JLabel("Codice del corso");
		lblCodiceCorso.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblCodiceCorso.setBounds(0, 2, 125, 21);
		panel.add(lblCodiceCorso);
		
		textFieldCodice = new JTextField();
		textFieldCodice.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		textFieldCodice.setBounds(149, 2, 96, 20);
		textFieldCodice.setColumns(10);
		panel.add(textFieldCodice);
		
		JLabel lblNewLabelNomeCorso = new JLabel("Nome del corso");
		lblNewLabelNomeCorso.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblNewLabelNomeCorso.setBounds(0, 40, 125, 14);
		panel.add(lblNewLabelNomeCorso);
		
		textField = new JTextField();
		textField.setBounds(149, 40, 96, 20);
		textField.setColumns(10);
		panel.add(textField);
		
		
		JLabel lblNewLabelIns = new JLabel("Matricola insegnante");
		lblNewLabelIns.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblNewLabelIns.setBounds(0, 79, 145, 14);
		panel.add(lblNewLabelIns);
		
		textField_1 = new JTextField();
		textField_1.setBounds(149, 78, 96, 20);
		textField_1.setColumns(10);
		panel.add(textField_1);

		
		JLabel lblNewLabelDatai = new JLabel("Data inizio");
		lblNewLabelDatai.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblNewLabelDatai.setBounds(0, 130, 101, 14);
		panel.add(lblNewLabelDatai);
		
		JLabel lblNewLabelDataFine = new JLabel("Data fine");
		lblNewLabelDataFine.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblNewLabelDataFine.setBounds(0, 253, 84, 14);
		panel.add(lblNewLabelDataFine);
		
		JButton btnConferma = new JButton("Conferma");
		btnConferma.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				contr.registraCorso(textFieldCodice.getText(), textField.getText(), textField_1.getText(), calendar.getDate().toString(), calendar2.getDate().toString());
				 System.out.println("corso inserito");
			}
		});
		btnConferma.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnConferma.setBounds(0, 376, 111, 23);
		panel.add(btnConferma);
		
		JButton btnAnnulla = new JButton("Indietro");
		btnAnnulla.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				panel.setVisible(false);
			}
		});
		btnAnnulla.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnAnnulla.setBounds(143, 376, 119, 23);
		panel.add(btnAnnulla);
		
		

		JButton btnAdd = new JButton("Aggiungi corso");
		btnAdd.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				panel.setVisible(true);
			}
		});

		btnAdd.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnAdd.setBounds(290, 74, 138, 23);
		getContentPane().add(btnAdd);
		

		btnIndietro.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnIndietro.setBounds(10, 75, 136, 23);
		panel2.add(btnIndietro);
		
		

		JLabel lblCodiceTest = new JLabel("Codice del test");
		lblCodiceTest.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblCodiceTest.setBounds(0, 2, 125, 21);
		panel3.add(lblCodiceTest);
		
		
		
		
		JButton btnAggiungiTest = new JButton("Aggiungi test");
		btnAdd.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				panel3.setVisible(true);
			}
		});

		btnAggiungiTest.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnAggiungiTest.setBounds(290, 74, 138, 23);
		getContentPane().add(btnAggiungiTest);

		calendar.setSize(171, 112);
		calendar.setLocation(79, 130);
		panel.add(calendar);
		
		calendar2.setSize(171, 112);
		calendar2.setLocation(79, 255);
		panel.add(calendar2);
		
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
		btnHome.setBounds(339, 229, 89, 23);
		getContentPane().add(btnHome);
		
		

		

}



	
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		
		te=test.riempiCBoxTest(comboBox.getSelectedItem().toString(), te);
		
	}
}
