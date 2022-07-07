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

public class SignInIi extends JFrame implements ActionListener {
	private JPasswordField passwordField;
	private JTextField textFieldCodice;
	private JTextField textField;
	private JTextField textField_1;
	private JPanel panel_1 = new JPanel();
	//private JCalendar calendar = new JCalendar();
	//private JCalendar calendar2 = new JCalendar();
	private JPanel panel_2;
	private JPanel panel3= new JPanel();
	List<String> cose = new ArrayList<String>();
	List<String> te = new ArrayList<String>();
	private JComboBox comboBox;	
	private JComboBox comboBox_1;
	private JTextField textFieldCorsi;
	private JTextField textFieldTest;
	
 
	

	public SignInIi(controller contr, String login) {
		getContentPane().setLayout(null);
		
		JLabel lblTitolo = new JLabel("Area Isegnanti");
		lblTitolo.setFont(new Font("Times New Roman", Font.PLAIN, 21));
		lblTitolo.setBounds(0, 0, 121, 14);
		getContentPane().add(lblTitolo);
		
		//JPanel panel_1 = new JPanel();
		panel_1.setBounds(255, 11, 171, 98);
		getContentPane().add(panel_1);
		panel_1.setLayout(null);
		
		JComboBox comboBox_2 = new JComboBox();
		comboBox_2.setBounds(10, 28, 151, 22);
		panel_1.add(comboBox_2);
		
		textFieldCorsi = new JTextField();
		textFieldCorsi.setText("Scegli corso");
		textFieldCorsi.setBounds(10, 0, 96, 20);
		panel_1.add(textFieldCorsi);
		textFieldCorsi.setColumns(10);
		
		JPanel panel_2 = new JPanel();
		panel_2.setBounds(255, 147, 171, 105);
		getContentPane().add(panel_2);
		panel_2.setLayout(null);
		panel_2.setVisible(false);
		
		JComboBox comboBox_3 = new JComboBox();
		comboBox_3.setBounds(10, 36, 151, 22);
		panel_2.add(comboBox_3);
		
		textFieldTest = new JTextField();
		textFieldTest.setText("Scegli test");
		textFieldTest.setBounds(10, 5, 96, 20);
		panel_2.add(textFieldTest);
		textFieldTest.setColumns(10);
		
		JButton btncngCorso = new JButton("Cambia Corso");
		btncngCorso.setBounds(60, 71, 101, 23);
		panel_2.add(btncngCorso);

		comboBox.addActionListener(this);
		comboBox.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
					if(e.getSource()==comboBox){
						panel_2.setBounds(282, 108, 146, 110);
						panel_2.setLayout(null);
					panel_2.setVisible(true);
					
					te.clear();
					
					if(comboBox_1!=null)
						comboBox_1.removeAllItems();
					
					System.out.println((String)comboBox.getSelectedItem());

					te=contr.riempiCBoxTest(comboBox.getSelectedItem().toString(), te);
					String[] arr1=new String[te.size()];
					arr1 = te.toArray(arr1);
					
					comboBox_1 = new JComboBox<String>(arr1);
					comboBox_1.setBounds(10, 34, 126, 22);
					panel2.add(comboBox_1);
					
		}
	}
			
	
		});
		
	
}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		
	}
}
