//DATI DEL DATABASE


// CREAZIONE DEI DOMINI
.................................................................................................................................................................................
CREATE DOMAIN risp AS VARCHAR (20)
CHECK (VALUE ='A'OR VALUE= 'B' OR VALUE='C' OR VALUE='D');
// la risposta può esssere solo una delle opzioni disponibili (es. non può essere Z) 

CREATE DOMAIN max_lenght AS INT
CHECK (VALUE > 50);
// la lunghezza della risposta deve essere lunga più di 50 caratteri

CHECK (VALUE ~ '^.*(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).*$' AND VALUE LIKE '________%');
//La password deve essere composta da più di 8 caratteri, almeno una lettera, almeno un numero e almeno un carattere speciale



//CREAZIONE DELLE TABELLE E DEFINIZIONE DI VINCOLI PIU SEMPLICI
.................................................................................................................................................................................

//TABELLA STUDENTE
CREATE TABLE STUDENTE ( 
    Id_stud varchar (30) NOT NULL, 
    Nome varchar (30) NOT NULL, 
    Cognome varchar (30) NOT NULL, 
    Login varchar (10) NOT NULL, 
    Password pass NOT NULL
);
ALTER TABLE STUDENTE
ADD CONSTRAINT studente_pk PRIMARY KEY (Id_stud);


//TABELLA INSEGNANTE
CREATE TABLE INSEGNANTE( 
    Id_ins varchar(30) NOT NULL, 
    Nome varchar(30) NOT NULL, 
    Cognome varchar(30) NOT NULL, 
    Login varchar(10) NOT NULL, 
    Password pass NOT NULL
);
ALTER TABLE INSEGNANTE
ADD CONSTRAINT insegnante_pk PRIMARY KEY (Id_ins);


//TABELLA CORSO
CREATE TABLE CORSO( 
    Cod_corso varchar(10) NOT NULL, 
    Nome varchar(20) NOT NULL, 
    Id_ins varchar (30) NOT NULL,
    Data_inizio date NOT NULL, 
    Data_fine date NOT NULL
); 
ALTER TABLE CORSO
ADD CONSTRAINT corso_pk PRIMARY KEY (Cod_corso),
ADD CONSTRAINT corso_fkb FOREIGN KEY (Id_ins)
REFERENCES INSEGNANTE (Id_ins)
ON UPDATE CASCADE ON DELETE RESTRICT;


//TABELLA TEST
CREATE TABLE TEST( 
    Nome_id varchar(30) NOT NULL, 
    N_quiz int NOT NULL, 
    Data date NOT NULL,
    Orario_inizio time NOT NULL, 
    Orario_fine time NOT NULL,
    Cod_corso varchar(10) NOT NULL,
    Id_ins varchar(30) NOT NULL
); 
ALTER TABLE TEST
ADD CONSTRAINT test_pk PRIMARY KEY (Nome_id),
ADD CONSTRAINT test_fka FOREIGN KEY (Cod_corso) REFERENCES CORSO (Cod_corso),
ADD CONSTRAINT test_fkb FOREIGN KEY (Id_ins) REFERENCES INSEGNANTE (Id_ins);



//TABELLA QUIZ A RISPOSTA MULTIPLA
CREATE TABLE QUIZ_RISP_MUL( 
    Id_quiz varchar(10) NOT NULL, 
    Domanda varchar(200)  NOT NULL, 
    A varchar(100) NOT NULL, 
    B varchar(100) NOT NULL, 
    C varchar(100) NOT NULL, 
    D varchar(100) NOT NULL, 
    Risposta_c risp NOT NULL, 
    Punt_c int NOT NULL, 
    Punt_e int NOT NULL
); 
ALTER TABLE QUIZ_RISP_MUL
ADD CONSTRAINT quiz_risp_mul_pk PRIMARY KEY (Id_quiz);



//TABELLA QUIZ A RISPOSTA APERTA
CREATE TABLE QUIZ_RISP_APE( 
    Id_quiz varchar (10) NOT NULL, 
    Domanda varchar (200) NOT NULL, 
    Lenght_risp max_lenght NOT NULL, 
    Punt_max real NOT NULL, 
    Punt_min real NOT NULL
); 
ALTER TABLE QUIZ_RISP_APE
ADD CONSTRAINT quiz_risp_ape_pk PRIMARY KEY (Id_quiz);


//TABELLA QUIZ_SVOLTI
CREATE TABLE QUIZ_SVOLTI( 
    Nome_id varchar(30) NOT NULL,
    Id_stud varchar(30) NOT NULL,
    Id_quizM varchar(10),
    Id_quizA varchar(10), 
    Risposta_data varchar(200) NOT NULL,
    Punteggio_quiz_dato real
);
ALTER TABLE QUIZ_SVOLTI
ADD CONSTRAINT QUIZ_SVOLTI_fka FOREIGN KEY(Id_stud)
REFERENCES STUDENTE(Id_stud) 
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT QUIZ_SVOLTI_fkb FOREIGN KEY (Nome_id)
REFERENCES TEST (Nome_id)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT QUIZ_SVOLTI_fkc FOREIGN KEY(Id_quizA)
REFERENCES QUIZ_RISP_APE(Id_quiz)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT QUIZ_SVOLTI_fkd FOREIGN KEY(Id_quizM)
REFERENCES QUIZ_RISP_MUL(Id_quiz)
ON UPDATE CASCADE ON DELETE RESTRICT;

// se id_quizA è NULL id_quizM è NOT NULL e viceversa (implementato con vincolo)


//TABELLA FREQUENTA 
CREATE TABLE FREQUENTA( 
    Id_stud varchar(30) NOT NULL, 
    Cod_corso varchar(10) NOT NULL
); 
ALTER TABLE FREQUENTA
ADD CONSTRAINT frequenta_fka FOREIGN KEY(Id_stud)
REFERENCES STUDENTE (Id_stud) 
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT frequenta_fkb FOREIGN KEY(Cod_corso)
REFERENCES CORSO (Cod_corso)
ON UPDATE CASCADE ON DELETE RESTRICT;



//TABELLA COMPOSIZIONE A 
CREATE TABLE COMPOSIZIONEA( 
    Id_quizA varchar (10) NOT NULL,
    Nome_id varchar (30) NOT NULL
); 
ALTER TABLE COMPOSIZIONEA
ADD CONSTRAINT compa_fka FOREIGN KEY(Id_quizA)
REFERENCES QUIZ_RISP_APE (Id_quiz) 
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT compa_fkb FOREIGN KEY(Nome_id)
REFERENCES TEST (Nome_id) 
ON UPDATE CASCADE ON DELETE RESTRICT;



//TABELLA COMPOSIZIONE M
CREATE TABLE COMPOSIZIONEM( 
    Id_quizM varchar(10) NOT NULL, 
    Nome_id varchar(30) NOT NULL
);
ALTER TABLE COMPOSIZIONEM
ADD CONSTRAINT compm_fka FOREIGN KEY(Id_quizM)
REFERENCES QUIZ_RISP_MUL (Id_quiz) 
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT compm_fkb FOREIGN KEY(Nome_id)
REFERENCES TEST (Nome_id)  
ON UPDATE CASCADE ON DELETE RESTRICT;



// DEFINIZIONE DI ALTRI VINCOLI
.................................................................................................................................................................................

//VINCOLI SU STUDENTE
ALTER TABLE STUDENTE
ADD CONSTRAINT login_stud
UNIQUE(login);
// nella tabella studente non ci possono essere due studenti con lo stesso login

//VINCOLI SU INSEGNANTE
ALTER TABLE INSEGNANTE
ADD CONSTRAINT login_ins
UNIQUE(login);
// nella tabella insegnante non ci possono essere due insegnanti con lo stesso login

//VINCOLI SUL CORSO
ALTER TABLE CORSO
ADD CONSTRAINT correttezza_data_fine
CHECK (Data_fine > Data_inizio);
// la data di fine del corso deve essere successiva alla data di inizio


//VINCOLI SU TEST
ALTER TABLE TEST
ADD CONSTRAINT numero_quiz
CHECK (n_quiz>=1);
// un test deve contenere almeno un quiz

ALTER TABLE TEST
ADD CONSTRAINT correttezza_orario_fine
CHECK (orario_fine>orario_inizio);
// l orario di fine di un quiz deve essere successivo all orario di inizio


//VINCOLI SU QUIZ_SVOLTI
ALTER TABLE QUIZ_SVOLTI
ADD CONSTRAINT unica_risposta_correttaM
UNIQUE (Id_stud, Id_quizM, Risposta_data);
// per ogni quiz a risposta multipla lo studente può dare una sola risposta

ALTER TABLE QUIZ_SVOLTI
ADD CONSTRAINT unica_risposta_correttaA
UNIQUE (Id_stud, Id_quizA, Risposta_data);
// per ogni quiz a risposta aperta lo studente può dare una sola risposta

ALTER TABLE QUIZ_SVOLTI
ADD CONSTRAINT quiz
CHECK (Id_quizM IS NOT NULL AND Id_quizA IS NULL OR(Id_quizM IS NULL AND Id_quizA IS  NOT NULL));
// se id_quizA è NULL id_quizM è NOT NULL e viceversa 





//DEFINIZIONE DI FUNZIONI,PROCEDURE, TRIGGER E ALTRE AUTOMAZIONI 
.................................................................................................................................................................................


//FUNZIONE CHE CALCOLA IL PUNTEGGIO TOTALE DI UN TEST

create or replace FUNCTION punt_tot(
    test TEST.Nome_id%TYPE,
    studente STUDENTE.id_stud%TYPE)
returns text 
language plpgsql
as $$
declare
somma real;
begin

SELECT SUM(Punteggio_quiz_dato) INTO somma  //somma i punteggi ottenuti dallo studente dato in input in ogni quiz del test dato in input
FROM QUIZ_SVOLTI
WHERE Nome_id=test AND id_stud=studente;

return studente||'->'|| test||'->'||somma;
end; $$

//prova di correttezza
INSERT INTO QUIZ_SVOLTI VALUES('FAG56455','N86003717',1,NULL,'A',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('FAG56455','N86003717',NULL,11,'L IMPERO ROMANO...',9);
SELECT punt_tot ('FAG56455','N86003717');
// output: N86003717->FAG56455->9




//FUNZIONE CHE CONTROLLA CHE LA DATA DEL TEST SIA SUCCESSIVA ALLA DATA DI FINE CORSO

CREATE OR REPLACE FUNCTION data_quiz () RETURNS TRIGGER AS $Dataq$
DECLARE 
data_fine_corso CORSO.Data_fine % TYPE;
BEGIN

SELECT Data_fine INTO data_fine_corso // prende la data di fine del corso che viene inserito 
FROM CORSO
WHERE Cod_corso=NEW.Cod_corso;

IF NEW.Data > data_fine_corso THEN // se la data di svolgimento del test è successiva alla fine del corso inserisce la tupla nella tabella test
RETURN NEW;

ELSE 
RAISE NOTICE 'Il test non si può svolgere prima della fine del corso';
DELETE
FROM TEST
WHERE Nome_id=NEW.Nome_id; //altrimenti stampa il messaggio e elimina la tupla dalla tabella test

END IF;

RETURN NEW;
END; $Dataq$ LANGUAGE plpgsql;

CREATE TRIGGER Dataq
AFTER INSERT ON TEST
FOR EACH ROW
EXECUTE FUNCTION data_quiz (); // trigger esegue la funzione dopo ogni insert su test

// prova di correttezza
INSERT INTO CORSO VALUES ('HFOEU1','Basi di dati','ASDV6745','2022-10-08','2022-12-27');
INSERT INTO TEST VALUES('BKSKSNKFI',2,'2022-10-07','14:00:00','16:00:00','HFOEU1');
// output: Il test non si può svolgere prima della fine del corso
// il corso viene inserito correttamente mentre il test non risulta inserito


//FUNZIONE CHE CONTROLLA L UNICITA DEL LOGIN DELL INSEGNANTE

CREATE OR REPLACE FUNCTION ins_log () RETURNS TRIGGER AS $log_ins$
DECLARE 
stud CURSOR IS(
SELECT login
FROM Studente); //scorre i login di tutti gli studenti
BEGIN

FOR el IN stud
LOOP
IF NEW.Login=el.login THEN     // il login dell insegante viene confrontato con il login di tutti gli studenti
RAISE NOTICE 'Questo login è già esistente'; // se coincide viene stampato il messaggio e la tupla va eliminata da insegnante
DELETE 
FROM INSEGNANTE
WHERE Id_ins=NEW.Id_ins;

ELSE           //altrimenti la tupla viene inserita correttamente
END IF;
END LOOP;

RETURN NEW;
END; $log_ins$ LANGUAGE plpgsql;

CREATE TRIGGER log_ins
AFTER INSERT ON INSEGNANTE
FOR EACH ROW
EXECUTE FUNCTION ins_log (); //la funzione viene eseguita dopo ogni insert su insegnante




//FUNZIONE CHE CONTROLLA L UNICITA DEL LOGIN DELLO STUDENTE

CREATE OR REPLACE FUNCTION stud_log () RETURNS TRIGGER AS $log_stud$
DECLARE 
ins CURSOR IS(
SELECT login
FROM INSEGNANTE); //scorre i login di tutti gli insegnanti
BEGIN

FOR el IN ins
LOOP
IF NEW.login=el.login THEN   // il login dello studnete viene confrontato con il login di tutti gli insegnanti
RAISE NOTICE 'Questo login è già esistente'; // se coincide viene stampato il messaggio e la tupla va eliminata da insegnante
DELETE 
FROM STUDENTE
WHERE Id_stud=NEW.Id_stud; 

ELSE 
END IF;   //altrimenti la tupla viene inserita correttamente
END LOOP;

RETURN NEW;
END; $log_stud$ LANGUAGE plpgsql;

CREATE TRIGGER log_stud
AFTER INSERT ON STUDENTE
FOR EACH ROW
EXECUTE FUNCTION stud_log (); //la funzione viene eseguita dopo ogni insert su studente


//prova di correttezza
INSERT INTO STUDENTE VALUES('N86006574', 'Roberta', 'Bonapasta', 'R.Bona', 'Robe2121@');
INSERT INTO INSEGNANTE VALUES ('HDLMEON','Raffaele','Bonaiuto','R.Bona','Raffa098!');
//output: Questo login è già esistente
//lo studente viene inserito correttamente, l insegnante non risulta inserito

//per fare la prova opposta eleminare le precedenti insert e ripeterele al contrario
INSERT INTO INSEGNANTE VALUES ('HDLMEON','Raffaele','Bonaiuto','R.Bona','Raffa098!');
INSERT INTO STUDENTE VALUES('N86006574', 'Roberta', 'Bonapasta', 'R.Bona', 'Robe2121@');
//output: Questo login è già esistente
//l insegnante viene inserito correttamente, lo studente non risulta inserito


//FUNZIONE CHE CONTROLLA IL PUNTEGGIO ASSEGNATATO AD UN QUIZ A RISPOSTA APERTA

CREATE OR REPLACE FUNCTION punteggio_assegnato () RETURNS TRIGGER AS $punteggio$
DECLARE 
punteggio_max QUIZ_RISP_APE.punt_max% TYPE;
punteggio_min QUIZ_RISP_APE.punt_min% TYPE;
BEGIN

SELECT punt_max INTO punteggio_max  // si prende il punteggio massimo assegnabile al quiz inserito
FROM QUIZ_RISP_APE
WHERE Id_quiz=NEW.Id_quizA;

SELECT punt_min INTO punteggio_min  // si prende il punteggio minimo assegnabile al quiz inserito
FROM QUIZ_RISP_APE
WHERE Id_quiz=NEW.Id_quizA;


IF NEW.Id_quizA IS NOT NULL AND (NEW.Punteggio_quiz_dato BETWEEN punteggio_min AND punteggio_max) THEN //se il punteggio assegnato dall insegnante è compreso tra il max e il min la tupla viene inserita correttamente
RETURN NEW;
END IF;

IF NEW.Id_quizA IS NOT NULL AND (NEW.Punteggio_quiz_dato  NOT BETWEEN punteggio_min AND punteggio_max) THEN //altrimenti la tupla viene cancellata e si stampa il messaggio
DELETE 
FROM QUIZ_SVOLTI
WHERE Nome_id=NEW.Nome_id;
RAISE NOTICE 'ERRORE, il punteggio non riesntra nel range consentito';
END IF;

RETURN NEW;
END; $punteggio$ LANGUAGE plpgsql;

CREATE TRIGGER punteggio
AFTER INSERT ON QUIZ_SVOLTI
FOR EACH ROW
EXECUTE FUNCTION punteggio_assegnato (); //la funzione viene svolta dopo ogni insert su QUIZ_SVOLTI

//prova di correttezza
INSERT INTO QUIZ_SVOLTI VALUES('FAG56455','N86006565',NULL,11, 'IFUYGFU',100);
//output: ERRORE, il punteggio non riesntra nel range consentito
// la tupla non risulta inserita


//FUNZIONE CHE CORREGGE AUTOMATICAMENTE IL QUIZ A RISPOSTA MULTIPLA

CREATE OR REPLACE FUNCTION Auto_correzione () RETURNS TRIGGER AS $Correzione$
DECLARE 
risp QUIZ_RISP_MUL.Risposta_c % TYPE;
BEGIN

IF NEW.Id_quizA IS NULL THEN         // vanno corrette automaticamente solo le risposte dei quiz a risposta multipla, cioè dove id_quizA è NULL e quindi id_quizM è NOT NULL

SELECT Risposta_c INTO risp          //si prende la risposta corretta al quiz a risposta multipla
FROM QUIZ_RISP_MUL
WHERE Id_quiz=NEW.Id_quizM;

IF NEW.Risposta_data=risp THEN       //se la risposta data è corretta si aggiorna il punteggio assegnato (precedentemente NULL in quanto non corretto) con il punteggio max per quel quiz
UPDATE QUIZ_SVOLTI
SET Punteggio_quiz_dato =(SELECT punt_c
                          FROM QUIZ_RISP_MUL
                          WHERE Id_quiz= NEW.Id_quizM)
WHERE Nome_id=NEW.Nome_id AND Id_quizM=NEW.Id_quizM AND Id_Stud=NEW.Id_stud;

ELSE

UPDATE QUIZ_SVOLTI                             //se la risposta data è errata si aggiorna il punteggio assegnato (precedentemente NULL in quanto non corretto) con il punteggio min per quel quiz
SET Punteggio_quiz_dato =(SELECT punt_e
                          FROM QUIZ_RISP_MUL
                          WHERE Id_quiz= NEW.Id_quizM)
WHERE Nome_id=NEW.Nome_id AND Id_quizM=NEW.Id_quizM AND Id_Stud=NEW.Id_stud;

END IF;

END IF;
RETURN NEW ;
END; $Correzione$ LANGUAGE plpgsql;

CREATE TRIGGER Correzione
AFTER INSERT ON QUIZ_SVOLTI
FOR EACH ROW
EXECUTE FUNCTION Auto_Correzione (); //la funzione viene eseguita dopo ogni insert su QUIZ_SVOLTI



//PROCEDURA PER ASSEGNARE UN VOTO ALLE RISPOSTE APERTE

CREATE OR REPLACE PROCEDURE correzione_risp_ape(
    test TEST.Nome_id%TYPE,
    studente STUDENTE.id_stud%TYPE,
    quiz QUIZ_SVOLTI.id_quizA%TYPE,
    voto QUIZ_SVOLTI.punteggio_quiz_dato%TYPE) //prende in input il test, lo studente, il quiz e il voto che si vuole assegnare
language plpgsql
as $$
declare

BEGIN
UPDATE QUIZ_SVOLTI
SET Punteggio_quiz_dato=voto
WHERE Nome_id=test AND Id_quizA=quiz AND id_stud=studente; //si aggiorna il punteggio assegnato (precedentemente NULL in quanto non corretto) con il punteggio dato dall insegnante

end; $$ 


// FUNZIONE PER CONTROLLARE L APPARTENENZA DEL QUIZ AL TEST
CREATE OR REPLACE FUNCTION quiz_test () RETURNS TRIGGER AS $test_quiz$
DECLARE 

BEGIN

IF NEW.Id_quizA IS NOT NULL THEN                   //controllo se il quiz è a risposta aperta

IF (NEW.Id_quizA NOT IN (SELECT Id_quizA           // se a quel test non è associato quel quiz
    FROM COMPOSIZIONEA
    WHERE Nome_id=NEW.Nome_id) )THEN
RAISE NOTICE 'ERRORE,il quiz non appartiene al test'; //stampa il messaggio e elimina la tupla da test svolto
DELETE 
FROM QUIZ_SVOLTI
WHERE Nome_id=NEW.Nome_id AND Id_quizA=NEW.Id_quizA AND Id_stud=NEW.Id_stud;
END IF;

ELSE                                              //controllo se il quiz è a risposta chiusa
    IF( NEW.Id_quizM NOT IN (SELECT Id_quizM       //se a quel test non è associato quel quiz
                        FROM COMPOSIZIONEM
                        WHERE Nome_id=NEW.Nome_id) )THEN 
RAISE NOTICE 'ERRORE,il quiz non appartiene al test';  //stampa il messaggio e elimina la tupla da test svolto
DELETE 
FROM QUIZ_SVOLTI
WHERE Nome_id=NEW.Nome_id AND Id_quizM=NEW.Id_quizM AND Id_stud=NEW.Id_stud;
END IF;
END IF;                                                 //sia per i quiz a risposta aperta che multipla, se sono associati a quel test vengono inseriti normalmente

RETURN NEW ;
END; $test_quiz$ LANGUAGE plpgsql;

CREATE TRIGGER test_quiz
AFTER INSERT ON QUIZ_SVOLTI
FOR EACH ROW
EXECUTE FUNCTION quiz_test ();  //la funzione viene svolta dopo ogni insert su test svolto

//prova di correttezza
INSERT INTO QUIZ_SVOLTI VALUES('FAG56455','N86006565',2,NULL, 'A',NULL);
//output: ERRORE,il quiz non appartiene al test
// la tupla non risulta inserita


//POPOLAZIONE DEL DATABASE  
.................................................................................................................................................................................
INSERT INTO STUDENTE VALUES('N86003545', 'Marzia', 'Pirozzi', 'marz.pir', 'Marz2121@');
INSERT INTO STUDENTE VALUES('N86006565', 'Giuseppe', 'Rossi', 'giu.rossi', 'Gius7722#');
INSERT INTO STUDENTE VALUES('N86003717', 'Noemi', 'Spera', 'no.spera', 'Noem6556!');
INSERT INTO STUDENTE VALUES('N86006363', 'Salvatore', 'Bianchi', 'sal.bian', 'Salva8787^');
INSERT INTO STUDENTE VALUES('N86006889', 'Serena', 'Esposito', 'ser.espos', 'Sere5523$*');
INSERT INTO STUDENTE VALUES('N86003444', 'Giorgia', 'Caruso', 'jiu.caruso', 'Giorg0606@');
INSERT INTO STUDENTE VALUES('N86009998', 'Chiara', 'Palma', 'chia.palma', 'Chiar2121@');
INSERT INTO STUDENTE VALUES('N86001111', 'Martina', 'Esposito', 'mar.esp', 'Mart7323!');
INSERT INTO STUDENTE VALUES('N86002121', 'Alessia', 'Bianchi', 'ale.bia', 'Aless6262@');
INSERT INTO STUDENTE VALUES('N86005566', 'Federica', 'Pirozzi', 'fede.pir', 'Feder1111&');

INSERT INTO INSEGNANTE VALUES ('HJGDJ678','Raffaele','Bonaiuto','R.Bona','Raffa0983!');
INSERT INTO INSEGNANTE VALUES ('ASDV6745','Giorgia','Armani','G.Arma','Giorg0909@');
INSERT INTO INSEGNANTE VALUES ('LKJH6543','Alessia','Parenti','AL.Pare','Aless7657#');
INSERT INTO INSEGNANTE VALUES ('FGHJ6549','Roberta','Paganini','R.Paga','Robe6546&');
INSERT INTO INSEGNANTE VALUES ('GDOA9876','Giulio','Riga','G.Riga','Giul2934%');
INSERT INTO INSEGNANTE VALUES ('DCSX2314','Roberto','Speranza','R.Spera','Robe5643^');
INSERT INTO INSEGNANTE VALUES ('HAJS7362','Mario','Ruggiero','M.Rugg','Mari5462&');
INSERT INTO INSEGNANTE VALUES ('DAFS9204','Beniamino','Esposito','B.Esp','Benia7336*');
INSERT INTO INSEGNANTE VALUES ('GTEY6378','Barbara','Delia','B.Deli','Barb8378!');
INSERT INTO INSEGNANTE VALUES ('DGHF7347','Vincenzo','Ferrara','V.Ferr','Vince1679@');

INSERT INTO CORSO VALUES ('U2535','Basi di dati','ASDV6745','2022-10-08','2022-12-27');
INSERT INTO CORSO VALUES ('U6362','Logica','DAFS9204','2022-10-06','2023-01-10');
INSERT INTO CORSO VALUES ('U3827','Algoritmi','DCSX2314','2022-10-05','2022-12-10');
INSERT INTO CORSO VALUES ('U8763','Analisi','DGHF7347','2022-10-09','2022-12-20');
INSERT INTO CORSO VALUES ('U3657','Geometria','FGHJ6549','2022-10-07','2022-12-21');
INSERT INTO CORSO VALUES ('U4457','Algebra','GDOA9876','2022-03-06','2022-06-01');
INSERT INTO CORSO VALUES ('U6868','Musica','GTEY6378','2022-03-08','2022-06-05');
INSERT INTO CORSO VALUES ('U111','Elementi','HAJS7362','2022-03-21','2022-06-01');
INSERT INTO CORSO VALUES ('U7932','Fisica','HJGDJ678','2022-03-21','2022-06-10');
INSERT INTO CORSO VALUES ('U9821','Programmazione','LKJH6543','2022-10-08','2022-12-29');

INSERT INTO TEST VALUES('FAG56455',2,'2022-12-28','14:00:00','16:00:00','U2535','HJGDJ678');
INSERT INTO TEST VALUES('GSTR6473',2,'2023-01-11','08:00:00','09:30:00','U6362','ASDV6745');
INSERT INTO TEST VALUES('KDHE7384',2,'2022-12-11','09:30:00','12:00:00','U3827','ASDV6745');
INSERT INTO TEST VALUES('GDOW8920',2,'2022-12-21','11:00:00','13:00:00','U8763','LKJH6543');
INSERT INTO TEST VALUES('YEOA8394',2,'2022-12-22','12:00:00','14:00:00','U3657','GDOA9876');
INSERT INTO TEST VALUES('KAOS2930',2,'2022-06-02','10:30:00','13:00:00','U4457','GTEY6378');
INSERT INTO TEST VALUES('JAOE0293',2,'2022-06-06','15:00:00','18:00:00','U6868','DAFS9204');
INSERT INTO TEST VALUES('JDW02845',2,'2022-06-02','12:30:00','15:00:00','U111','DGHF7347');
INSERT INTO TEST VALUES('HSOW0384',2,'2022-06-11','10:00:00','12:30:00','U7932','DGHF7347');
INSERT INTO TEST VALUES('JAOD8479',2,'2022-12-30','09:00:00','11:00:00','U9821','DCSX2314');

INSERT INTO QUIZ_RISP_APE VALUES('11','Parlami dell Impero Romano',100,10,0);
INSERT INTO QUIZ_RISP_APE VALUES('12','Descrivimi l apparato digerente',100,12,0);
INSERT INTO QUIZ_RISP_APE VALUES('13','Che cos è il PIL, argomenta',60,6,0);
INSERT INTO QUIZ_RISP_APE VALUES('14','Cosa sono le interfacce, e a cosa servono?',150,7,0);
INSERT INTO QUIZ_RISP_APE VALUES('15','Descrizione dettagliata degli alberi AVL',200,14,0);
INSERT INTO QUIZ_RISP_APE VALUES('16','Che cos è una matrice associata e come può essere usata?',100,8,0);
INSERT INTO QUIZ_RISP_APE VALUES('17','Le cellule eucariote e procarite.Argomenta',200,10,0);
INSERT INTO QUIZ_RISP_APE VALUES('18','Dimostrazione del Numero di Nepero',200,12,0);
INSERT INTO QUIZ_RISP_APE VALUES('19','Enuncia il teorema degli zeri',200,9,0);
INSERT INTO QUIZ_RISP_APE VALUES('20','Enuncia il teorema dei valori intermedi',150,9,0);

INSERT INTO QUIZ_RISP_MUL VALUES ('1', 'Quanti piedi ha un millepiedi?','10', '100', '1000', 'non ne ha','C', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('2', 'Quanti lati ha un triangolo?','3', '2', '10', 'non ne ha','A', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('3', 'Di che colore è il cielo?','blu', 'rosso', 'verde', 'giallo','A', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('4', 'Quante "a" nella frase "Amo studiare basi di dati"?','5', '100', '3', '4','D', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('5', 'Chi è kira di death note?','light yagami', 'L', 'Il prof Barra', 'io','A', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('6', 'Quante sono le dita di una mano?','10', '100', '1000', '5','D', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('7', 'Quale di questi NON è un colore primario?','rosso', 'verde', 'giallo', 'blu','B', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('8', 'Quant anni per laurearsi alla triennale?','3', '5', '10', 'non ci si laurea','D', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('9', 'Che voto prenderanno Marzia e Noemi a questo esame?','18', '30', '30 cum laude', 'bocciate','C', 10, 0);
INSERT INTO QUIZ_RISP_MUL VALUES ('10','Cosa si mette nel caffè?','sale', 'zucchero', 'pepe', 'zenzero','B', 10, 0);

INSERT INTO COMPOSIZIONEA VALUES ('11','FAG56455');
INSERT INTO COMPOSIZIONEA VALUES ('12','GSTR6473');
INSERT INTO COMPOSIZIONEA VALUES ('13','KDHE7384');
INSERT INTO COMPOSIZIONEA VALUES ('14','GDOW8920');
INSERT INTO COMPOSIZIONEA VALUES ('15','YEOA8394');
INSERT INTO COMPOSIZIONEA VALUES ('16','KAOS2930');
INSERT INTO COMPOSIZIONEA VALUES ('17','JAOE0293');
INSERT INTO COMPOSIZIONEA VALUES ('18','JDW02845');
INSERT INTO COMPOSIZIONEA VALUES ('19','HSOW0384');
INSERT INTO COMPOSIZIONEA VALUES ('20','JAOD8479');

INSERT INTO COMPOSIZIONEM VALUES ('1','FAG56455');
INSERT INTO COMPOSIZIONEM VALUES ('2','GSTR6473');
INSERT INTO COMPOSIZIONEM VALUES ('3','KDHE7384');
INSERT INTO COMPOSIZIONEM VALUES ('4','GDOW8920');
INSERT INTO COMPOSIZIONEM VALUES ('5','YEOA8394');
INSERT INTO COMPOSIZIONEM VALUES ('6','KAOS2930');
INSERT INTO COMPOSIZIONEM VALUES ('7','JAOE0293');
INSERT INTO COMPOSIZIONEM VALUES ('8','JDW02845');
INSERT INTO COMPOSIZIONEM VALUES ('9','HSOW0384');
INSERT INTO COMPOSIZIONEM VALUES ('10','JAOD8479');


INSERT INTO QUIZ_SVOLTI VALUES('FAG56455','N86006565',1,NULL, 'A',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('GSTR6473','N86003717',2,NULL,'B',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('KAOS2930','N86003444',6,NULL,'C',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('YEOA8394','N86009998',NULL,15, 'GLI ALBERI AVL SONO:',3);
INSERT INTO QUIZ_SVOLTI VALUES('FAG56455','N86006565',NULL,11, 'IFUYGFU',6);
INSERT INTO QUIZ_SVOLTI VALUES('GSTR6473','N86001111',NULL,'12','L APPARATO DIGERENTE È COMPOSTO DA',10);
INSERT INTO QUIZ_SVOLTI VALUES('KDHE7384','N86005566',NULL,'13','IL PIL...',3);
INSERT INTO QUIZ_SVOLTI VALUES('GDOW8920','N86006889',NULL,'14','LE INTERFACCE SONO',5);
INSERT INTO QUIZ_SVOLTI VALUES('KAOS2930','N86009998',NULL,'16','UNA MATRICE ASSOCIATA...',7);
INSERT INTO QUIZ_SVOLTI VALUES('GSTR6473','N86009998',NULL,'12','L APPARATO è',8);
INSERT INTO QUIZ_SVOLTI VALUES('KDHE7384','N86006889',NULL,'13','PRODOTTO INTERNO LORDO',5);
INSERT INTO QUIZ_SVOLTI VALUES('GDOW8920','N86009998',NULL,'14','ABBIAMO DIVERSI TIPI DI',3);
INSERT INTO QUIZ_SVOLTI VALUES('GDOW8920','N86001111',NULL,'14','ESISTONO VARI...',4);
INSERT INTO QUIZ_SVOLTI VALUES('JAOE0293','N86003444',NULL,'17','LE CELLULE...',10);
INSERT INTO QUIZ_SVOLTI VALUES('JDW02845','N86003717',NULL,'18','IL NUMERO DI NEPERO...',10);
INSERT INTO QUIZ_SVOLTI VALUES('JAOD8479','N86005566',NULL,'20','LENUNCIATO DICE...',8);
INSERT INTO QUIZ_SVOLTI VALUES('KDHE7384','N86003545','3',NULL,'A',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('GDOW8920','N86006565','4',NULL,'B',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('YEOA8394','N86006363','5',NULL,'C',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('JAOE0293','N86001111','7',NULL,'D',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('JDW02845','N86005566','8',NULL,'D',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('HSOW0384','N86006889','9',NULL,'C',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('JAOD8479','N86009998','10',NULL,'B',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('JAOE0293','N86005566','7',NULL,'A',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('YEOA8394','N86003545','5',NULL,'D',NULL);
