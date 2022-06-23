package GUI;
import Controlller.*;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JTextField;
import java.awt.Color;
import javax.swing.JLabel;
import java.awt.Font;
import java.awt.Canvas;
import javax.swing.JEditorPane;

public class Home extends JFrame {
	public Home(controller contr) {
		controller c=contr;
		JPanel panel = new JPanel();
		getContentPane().add(panel, BorderLayout.CENTER);
		panel.setLayout(null);
		
		JButton btnSignIn = new JButton("Sign In");
		btnSignIn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				SignIn si= new SignIn(c);
				si.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				si.setBounds(100, 100, 450, 300);
				si.show();
				dispose();
			}
		});
		btnSignIn.setToolTipText("Utente gi\u00E0 registrato");
		btnSignIn.setBounds(76, 154, 89, 23);
		panel.add(btnSignIn);
		
		JButton btnSignUp = new JButton("Sign Up");
		btnSignUp.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				SignUp sup= new SignUp(c); 
				sup.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				sup.setBounds(100, 100, 450, 300);
				sup.show();
				dispose();
				
			}
		});
		btnSignUp.setToolTipText("Primo accesso, registrati");
		btnSignUp.setBounds(258, 154, 89, 23);
		panel.add(btnSignUp);
		
		JLabel lblTitolo = new JLabel(" Home");
		lblTitolo.setFont(new Font("Times New Roman", Font.PLAIN, 26));
		lblTitolo.setBounds(0, 0, 89, 46);
		panel.add(lblTitolo);

	}
}
