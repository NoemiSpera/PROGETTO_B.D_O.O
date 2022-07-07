package GUI;

import javax.swing.JFrame;
import Model.*;
import implementazioneDao.impInsegnanteDao;
import implementazioneDao.impStudenteDao;
import DAO.*;
import Controlller.*;
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
import javax.swing.JCheckBox;
import java.awt.Checkbox;
import java.awt.Choice;
import javax.swing.DefaultComboBoxModel;
import javax.swing.SwingConstants;
import javax.swing.JList;
import javax.swing.AbstractListModel;
import javax.swing.ListSelectionModel;

public class SignIn extends JFrame {
	private JTextField textFieldLogin;
	private JPasswordField passwordField;
	public SignIn(controller contr) {
		controller c=contr;
		getContentPane().setLayout(null);
		
		JLabel lblLogin = new JLabel("Login");
		lblLogin.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblLogin.setBounds(63, 56, 83, 20);
		getContentPane().add(lblLogin);
		
		JLabel lblPassword = new JLabel("Password");
		lblPassword.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		lblPassword.setBounds(63, 109, 101, 22);
		getContentPane().add(lblPassword);
		
		textFieldLogin = new JTextField();
		textFieldLogin.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		textFieldLogin.setBounds(174, 56, 207, 20);
		getContentPane().add(textFieldLogin);
		textFieldLogin.setColumns(10);
		
		passwordField = new JPasswordField();
		passwordField.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		passwordField.setBounds(174, 109, 207, 20);
		getContentPane().add(passwordField);
		
		JButton btnLogin = new JButton("Login");
		btnLogin.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {

				String pas= new String (passwordField.getText());
				String pas1=new String(c.contrLog(textFieldLogin.getText(), "no"));
				String pas2=new String(c.contrLogI(textFieldLogin.getText(), "no"));
				if(pas1.equals(pas)) {
					SignInS sis=new SignInS(c, textFieldLogin.getText());
					sis.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
					sis.setBounds(100, 100, 450, 300);
					sis.show();
					dispose();
				}
				else if (pas2.equals(pas)) {
				SignInI sii=new SignInI(c,textFieldLogin.getText());
				sii.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				sii.setBounds(100, 100, 450, 300);
				sii.show();
				dispose();

			}
				else {
					System.out.println("utente non registrato");
				}
		}
});	

		btnLogin.setToolTipText("Procedi");
		btnLogin.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnLogin.setBounds(207, 214, 89, 23);
		getContentPane().add(btnLogin);
		
		JButton btnAnnulla = new JButton("Annulla");
		btnAnnulla.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Home ho= new Home(c); 
				ho.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				ho.setBounds(100, 100, 450, 300);
				ho.show();
				dispose();
			}
		});
		btnAnnulla.setToolTipText("Torni a home\r\n");
		btnAnnulla.setFont(new Font("Times New Roman", Font.PLAIN, 17));
		btnAnnulla.setBounds(319, 214, 89, 23);
		getContentPane().add(btnAnnulla);


}
}