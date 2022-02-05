//DATI DEL DATABASE


// CREAZIONE DEI DOMINI
.................................................................................................................................................................................
CREATE DOMAIN risp AS VARCHAR (20)
CHECK (VALUE ='A'OR VALUE= 'B' OR VALUE='C' OR VALUE='D');

CREATE DOMAIN max_lenght AS INT
CHECK (VALUE > 50);

CREATE DOMAIN pass AS VARCHAR (10);



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
    Cod_corso varchar(10) NOT NULL
); 
ALTER TABLE TEST
ADD CONSTRAINT test_pk PRIMARY KEY (Nome_id),
ADD CONSTRAINT test_fk FOREIGN KEY (Cod_corso) REFERENCES CORSO (Cod_corso);



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


//TABELLA TEST_SVOLTO
CREATE TABLE TEST_SVOLTO( 
    Nome_id varchar(30) NOT NULL,
    Id_stud varchar(30) NOT NULL,
    Id_quizM varchar(10),
    Id_quizA varchar(10), 
    Risposta_data varchar(200) NOT NULL,
    Punteggio_quiz_dato real
);
ALTER TABLE TEST_SVOLTO
ADD CONSTRAINT test_svolto_fka FOREIGN KEY(id_stud)
REFERENCES STUDENTE(id_stud) 
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT test_svolto_fkb FOREIGN KEY (Nome_id)
REFERENCES TEST (Nome_id)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT test_svolto_fkc FOREIGN KEY(id_quizA)
REFERENCES QUIZ_RISP_APE(id_quiz)
ON UPDATE CASCADE ON DELETE RESTRICT,
ADD CONSTRAINT test_svolto_fkd FOREIGN KEY(id_quizM)
REFERENCES QUIZ_RISP_MUL(id_quiz)
ON UPDATE CASCADE ON DELETE RESTRICT;


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



// DEFINIZIONE DI VINCOLI PIU COMPLESSI
.................................................................................................................................................................................

//VINCOLI SU STUDENTE
ALTER TABLE STUDENTE
ADD CONSTRAINT login_stud
UNIQUE(login);


//VINCOLI SU INSEGNANTE
ALTER TABLE INSEGNANTE
ADD CONSTRAINT login_ins
UNIQUE(login);


//VINCOLI SUL CORSO
ALTER TABLE CORSO
ADD CONSTRAINT correttezza_data_fine
CHECK (Data_fine > Data_inizio);


//VINCOLI SU TEST
ALTER TABLE TEST
ADD CONSTRAINT numero_quiz
CHECK (n_quiz>=1);


ALTER TABLE TEST
ADD CONSTRAINT correttezza_orario_fine
CHECK (orario_fine>orario_inizio);


//VINCOLI SU TEST_SVOLTO
ALTER TABLE TEST_SVOLTO
ADD CONSTRAINT unica_risposta_correttaM
UNIQUE (Id_stud, Id_quizM, Risposta_data);

ALTER TABLE TEST_SVOLTO
ADD CONSTRAINT unica_risposta_correttaA
UNIQUE (Id_stud, Id_quizA, Risposta_data);

ALTER TABLE TEST_SVOLTO
ADD CONSTRAINT quiz
CHECK (Id_quizM IS NOT NULL AND Id_quizA IS NULL OR(Id_quizM IS NULL AND Id_quizA IS  NOT NULL));




//DEFINIZIONE DI FUNZIONI,PROCEDURE, TRIGGER E ALTRE AUTOMAZIONI 
.................................................................................................................................................................................


//FUNZIONE CHE CALCOLA IL PUNTEGGIO TOTALE DI UN TEST

create or replace FUNCTION punt_tot(
    test TEST.Nome_id%TYPE,
    studente STUDENTE.id_stud%TYPE)
returns text as $$
declare
somma real;
begin
SELECT SUM(Punteggio_quiz_dato) INTO somma
FROM TEST_SVOLTO
WHERE Nome_id=test AND id_stud=studente;

return studente||'->'|| test||'->'||somma;
end; $$ language plpgsql




//FUNZIONE CHE CONTROLLA CHE LA DATA DEL TEST SIA SUCCESSIVA ALLA DATA DI FINE CORSO

CREATE OR REPLACE FUNCTION data_quiz () RETURNS TRIGGER AS $Dataq$
DECLARE 
data_fine_corso CORSO.Data_fine % TYPE;
BEGIN

SELECT Data_fine INTO data_fine_corso
FROM CORSO
WHERE Cod_corso=NEW.Cod_corso;

IF NEW.Data > data_fine_corso THEN
RETURN NEW;

ELSE 
RAISE NOTICE 'Il test non si può svolgere prima della fine del corso';
DELETE
FROM TEST
WHERE Nome_id=NEW.Nome_id;

END IF;

RETURN NEW;
END; $Dataq$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER Dataq
AFTER INSERT ON TEST
FOR EACH ROW
EXECUTE FUNCTION data_quiz ();




//FUNZIONE CHE CONTROLLA L'UNICITA DEL LOGIN DELL'INSEGNANTE

CREATE OR REPLACE FUNCTION ins_log () RETURNS TRIGGER AS $log_ins$
DECLARE 
stud CURSOR IS(
SELECT login
FROM Studente);
BEGIN

FOR el IN stud
LOOP
IF NEW.Login=el.login THEN
RAISE NOTICE 'Questo login è già esistente';
DELETE 
FROM INSEGNANTE
WHERE Id_ins=NEW.Id_ins;

ELSE
END IF;
END LOOP;

RETURN NEW;
END; $log_ins$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER log_ins
AFTER INSERT ON INSEGNANTE
FOR EACH ROW
EXECUTE FUNCTION ins_log ();




//FUNZIONE CHE CONTROLLA L UNICITA DEL LOGIN DELLO STUDENTE

CREATE OR REPLACE FUNCTION stud_log () RETURNS TRIGGER AS $log_stud$
DECLARE 
ins CURSOR IS(
SELECT login
FROM INSEGNANTE);
BEGIN

FOR el IN ins
LOOP
IF NEW.login=el.login THEN
RAISE NOTICE 'Questo login è già esistente';
DELETE 
FROM STUDENTE
WHERE Id_stud=NEW.Id_stud;

ELSE
END IF;
END LOOP;

RETURN NEW;
END; $log_stud$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER log_stud
AFTER INSERT ON STUDENTE
FOR EACH ROW
EXECUTE FUNCTION stud_log ();




//FUNZIONE CHE CONTROLLA IL PUNTEGGIO ASSEGNATATO AD UN QUIZ A RISPOSTA APERTA

CREATE OR REPLACE FUNCTION punteggio_assegnato () RETURNS TRIGGER AS $punteggio$
DECLARE 
punteggio_max QUIZ_RISP_APE.punt_max% TYPE;
punteggio_min QUIZ_RISP_APE.punt_min% TYPE;
BEGIN

SELECT punt_max INTO punteggio_max
FROM QUIZ_RISP_APE
WHERE Id_quiz=NEW.Id_quizA;

SELECT punt_min INTO punteggio_min
FROM QUIZ_RISP_APE
WHERE Id_quiz=NEW.Id_quizA;


IF NEW.Id_quizA IS NOT NULL AND (NEW.Punteggio_quiz_dato BETWEEN punteggio_min AND punteggio_max) THEN
RETURN NEW;
END IF;

IF NEW.Id_quizA IS NOT NULL AND (NEW.Punteggio_quiz_dato  NOT BETWEEN punteggio_min AND punteggio_max) THEN
DELETE 
FROM TEST_SVOLTO
WHERE Nome_id=NEW.Nome_id;
RAISE NOTICE 'ERRORE, il punteggio non riesntra nel range consentito';
END IF;

RETURN NEW;
END; $punteggio$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER punteggio
AFTER INSERT ON TEST_SVOLTO
FOR EACH ROW
EXECUTE FUNCTION punteggio_assegnato ();



//FUNZIONE CHE CORREGGE AUTOMATICAMENTE IL QUIZ A RISPOSTA MULTIPLA

CREATE OR REPLACE FUNCTION Auto_correzione () RETURNS TRIGGER AS $Correzione$
DECLARE 
risp QUIZ_RISP_MUL.Risposta_c % TYPE;
BEGIN

IF NEW.Id_quizA IS NULL THEN

SELECT Risposta_c INTO risp
FROM QUIZ_RISP_MUL
WHERE Id_quiz=NEW.Id_quizM;

IF NEW.Risposta_data=risp THEN
UPDATE TEST_SVOLTO
SET Punteggio_quiz_dato =(SELECT punt_c
                          FROM QUIZ_RISP_MUL
                          WHERE Id_quiz= NEW.Id_quizM)
WHERE Nome_id=NEW.Nome_id AND Id_quizM=NEW.Id_quizM AND Id_Stud=NEW.Id_stud;

ELSE

UPDATE TEST_SVOLTO
SET Punteggio_quiz_dato =(SELECT punt_e
                          FROM QUIZ_RISP_MUL
                          WHERE Id_quiz= NEW.Id_quizM)
WHERE Nome_id=NEW.Nome_id AND Id_quizM=NEW.Id_quizM AND Id_Stud=NEW.Id_stud;

END IF;

END IF;
RETURN NEW ;
END; $Correzione$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER Correzione
AFTER INSERT ON TEST_SVOLTO
FOR EACH ROW
EXECUTE FUNCTION Auto_Correzione ();



//PROCEDURA CHE DA LE CORREZIONI DELLE RISPOSTE APERTE

CREATE OR REPLACE PROCEDURE correzione_risp_ape(
    test TEST.Nome_id%TYPE,
    studente STUDENTE.id_stud%TYPE,
    quiz TEST_SVOLTO.id_quizA%TYPE,
    voto TEST_SVOLTO.punteggio_quiz_dato%TYPE)
as $$
declare

BEGIN
UPDATE TEST_SVOLTO
SET Punteggio_quiz_dato=voto
WHERE Nome_id=test AND Id_quizA=quiz AND id_stud=studente;

end; $$ language plpgsql


// FUNZIONE PER CONTROLLARE L APPARTENENZA DEL QUIZ AL TEST
CREATE OR REPLACE FUNCTION quiz_test () RETURNS TRIGGER AS $test_quiz$
DECLARE 

BEGIN

IF NEW.Id_quizA IS NOT NULL THEN

IF (NEW.Id_quizA NOT IN (SELECT Id_quizA
    FROM COMPOSIZIONEA
    WHERE Nome_id=NEW.Nome_id) )THEN
RAISE NOTICE 'ERRORE,il quiz non appartiene al test';
DELETE 
FROM TEST_SVOLTO
WHERE Nome_id=NEW.Nome_id AND Id_quizA=NEW.Id_quizA AND Id_stud=NEW.Id_stud;
END IF;

ELSE 
    IF( NEW.Id_quizM NOT IN (SELECT Id_quizM
                        FROM COMPOSIZIONEM
                        WHERE Nome_id=NEW.Nome_id) )THEN 
RAISE NOTICE 'ERRORE,il quiz non appartiene al test';
DELETE 
FROM TEST_SVOLTO
WHERE Nome_id=NEW.Nome_id AND Id_quizM=NEW.Id_quizM AND Id_stud=NEW.Id_stud;
END IF;
END IF;

RETURN NEW ;
END; $test_quiz$ LANGUAGE plpgsql;

CREATE TRIGGER test_quiz
AFTER INSERT ON TEST_SVOLTO
FOR EACH ROW
EXECUTE FUNCTION quiz_test ();


//POPOLAZIONE DEL DATABASE  
.................................................................................................................................................................................
INSERT INTO STUDENTE VALUES('N86003545', 'Marzia', 'Pirozzi', 'marz.pir', 'M2121@');
INSERT INTO STUDENTE VALUES('N86006565', 'Giuseppe', 'Rossi', 'giu.rossi', 'G7722#');
INSERT INTO STUDENTE VALUES('N86003717', 'Noemi', 'Spera', 'no.spera', 'N6556!');
INSERT INTO STUDENTE VALUES('N86006363', 'Salvatore', 'Bianchi', 'sal.bian', 'Y8787?');
INSERT INTO STUDENTE VALUES('N86006889', 'Serena', 'Esposito', 'ser.espos', 'S5523$');
INSERT INTO STUDENTE VALUES('N86003444', 'Giorgia', 'Caruso', 'jiu.caruso', 'G0606@');
INSERT INTO STUDENTE VALUES('N86009998', 'Chiara', 'Palma', 'chia.palma', 'C2121_');
INSERT INTO STUDENTE VALUES('N86001111', 'Martina', 'Esposito', 'mar.esp', 'M7323/');
INSERT INTO STUDENTE VALUES('N86002121', 'Alessia', 'Bianchi', 'ale.bia', 'A6262@');
INSERT INTO STUDENTE VALUES('N86005566', 'Federica', 'Pirozzi', 'fede.pir', 'F1111+');

INSERT INTO INSEGNANTE VALUES ('HJGDJ678','Raffaele','Bonaiuto','R.Bona','Wsx098.');
INSERT INTO INSEGNANTE VALUES ('ASDV6745','Giorgia','Armani','G.Arma','Plm090?');
INSERT INTO INSEGNANTE VALUES ('LKJH6543','Alessia','Parenti','AL.Pare','Okm765!');
INSERT INTO INSEGNANTE VALUES ('FGHJ6549','Roberta','Paganini','R.Paga','Ijn654”');
INSERT INTO INSEGNANTE VALUES ('GDOA9876','Giulio','Riga','G.Riga','Uhb293_');
INSERT INTO INSEGNANTE VALUES ('DCSX2314','Roberto','Speranza','R.Spera','Tfx564?');
INSERT INTO INSEGNANTE VALUES ('HAJS7362','Mario','Ruggiero','M.Rugg','n546#');
INSERT INTO INSEGNANTE VALUES ('DAFS9204','Beniamino','Esposito','B.Esp','Rgn733?');
INSERT INTO INSEGNANTE VALUES ('GTEY6378','Barbara','Delia','B.Deli','Thm837.');
INSERT INTO INSEGNANTE VALUES ('DGHF7347','Vincenzo','Ferrara','V.Ferr','Qaz167-');

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

INSERT INTO TEST VALUES('FAG56455',2,'2022-12-28','14:00:00','16:00:00','U2535');
INSERT INTO TEST VALUES('GSTR6473',2,'2023-01-11','08:00:00','09:30:00','U6362');
INSERT INTO TEST VALUES('KDHE7384',2,'2022-12-11','09:30:00','12:00:00','U3827');
INSERT INTO TEST VALUES('GDOW8920',2,'2022-12-21','11:00:00','13:00:00','U8763');
INSERT INTO TEST VALUES('YEOA8394',2,'2022-12-22','12:00:00','14:00:00','U3657');
INSERT INTO TEST VALUES('KAOS2930',2,'2022-06-02','10:30:00','13:00:00','U4457');
INSERT INTO TEST VALUES('JAOE0293',2,'2022-06-06','15:00:00','18:00:00','U6868');
INSERT INTO TEST VALUES('JDW02845',2,'2022-06-02','12:30:00','15:00:00','U111');
INSERT INTO TEST VALUES('HSOW0384',2,'2022-06-11','10:00:00','12:30:00','U7932');
INSERT INTO TEST VALUES('JAOD8479',2,'2022-12-30','09:00:00','11:00:00','U9821');

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


INSERT INTO TEST_SVOLTO VALUES('FAG56455','N86006565',1,NULL, 'A',NULL);
INSERT INTO TEST_SVOLTO VALUES('GSTR6473','N86003717',2,NULL,'B',NULL);
INSERT INTO TEST_SVOLTO VALUES('KAOS2930','N86003444',6,NULL,'C',NULL);
INSERT INTO TEST_SVOLTO VALUES('YEOA8394','N86009998',NULL,15, 'GLI ALBERI AVL SONO:',3);
INSERT INTO TEST_SVOLTO VALUES('FAG56455','N86006565',NULL,11, 'IFUYGFU',6);
