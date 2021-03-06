CREATE DOMAIN risp AS VARCHAR (20)
CHECK (VALUE ='A'OR VALUE= 'B' OR VALUE='C' OR VALUE='D');

CREATE DOMAIN max_lenght AS INT
CHECK (VALUE > 50);

CREATE DOMAIN pass AS VARCHAR(130)
CHECK (VALUE ~ '^.*(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).*$' AND VALUE LIKE '________%');

CREATE TABLE STUDENTE ( 
    Id_stud varchar (30) NOT NULL, 
    Nome varchar (30) NOT NULL, 
    Cognome varchar (30) NOT NULL, 
    Login varchar (10) NOT NULL, 
    Password pass NOT NULL
);
ALTER TABLE STUDENTE
ADD CONSTRAINT studente_pk PRIMARY KEY (Id_stud);

CREATE TABLE INSEGNANTE( 
    Id_ins varchar(30) NOT NULL, 
    Nome varchar(30) NOT NULL, 
    Cognome varchar(30) NOT NULL, 
    Login varchar(10) NOT NULL, 
    Password pass NOT NULL
);
ALTER TABLE INSEGNANTE
ADD CONSTRAINT insegnante_pk PRIMARY KEY (Id_ins);

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

CREATE TABLE QUIZ_RISP_MUL( 
    Id_quiz varchar(10) NOT NULL, 
    Domanda varchar(200)  NOT NULL, 
    A varchar(100) NOT NULL, 
    B varchar(100) NOT NULL, 
    C varchar(100) NOT NULL, 
    D varchar(100) NOT NULL, 
    Risposta_c risp NOT NULL, 
    Punt_c int NOT NULL, 
    Punt_e int NOT NULL,
    Nome_id varchar(20) NOT NULL
); 
ALTER TABLE QUIZ_RISP_MUL
ADD CONSTRAINT quiz_risp_mul_pk PRIMARY KEY (Id_quiz),
ADD CONSTRAINT quiz_risp_mul_fk FOREIGN KEY (Nome_id) REFERENCES TEST (Nome_id);


CREATE TABLE QUIZ_RISP_APE( 
    Id_quiz varchar (10) NOT NULL, 
    Domanda varchar (200) NOT NULL, 
    Lenght_risp max_lenght NOT NULL, 
    Punt_max real NOT NULL, 
    Punt_min real NOT NULL,
    Nome_id varchar(20) NOT NULL
); 
ALTER TABLE QUIZ_RISP_APE
ADD CONSTRAINT quiz_risp_ape_pk PRIMARY KEY (Id_quiz),
ADD CONSTRAINT quiz_risp_ape_fk FOREIGN KEY (Nome_id) REFERENCES TEST (Nome_id);

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


ALTER TABLE STUDENTE
ADD CONSTRAINT login_stud
UNIQUE(login);

ALTER TABLE INSEGNANTE
ADD CONSTRAINT login_ins
UNIQUE(login);

ALTER TABLE CORSO
ADD CONSTRAINT correttezza_data_fine
CHECK (Data_fine > Data_inizio);

ALTER TABLE TEST
ADD CONSTRAINT numero_quiz
CHECK (n_quiz>=1);


ALTER TABLE TEST
ADD CONSTRAINT correttezza_orario_fine
CHECK (orario_fine>orario_inizio);

ALTER TABLE QUIZ_SVOLTI
ADD CONSTRAINT unica_risposta_correttaM
UNIQUE (Id_stud, Id_quizM, Risposta_data);

ALTER TABLE QUIZ_SVOLTI
ADD CONSTRAINT unica_risposta_correttaA
UNIQUE (Id_stud, Id_quizA, Risposta_data);

ALTER TABLE QUIZ_SVOLTI
ADD CONSTRAINT quiz
CHECK (Id_quizM IS NOT NULL AND Id_quizA IS NULL OR(Id_quizM IS NULL AND Id_quizA IS  NOT NULL));


create or replace FUNCTION punt_tot(
    test TEST.Nome_id%TYPE,
    studente STUDENTE.id_stud%TYPE)
returns text 
as $$
declare
somma real;
begin
SELECT SUM(Punteggio_quiz_dato) INTO somma
FROM QUIZ_SVOLTI
WHERE Nome_id=test AND id_stud=studente;

return studente||'->'|| test||'->'||somma;
end; $$ language plpgsql;

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
RAISE NOTICE 'Il test non si pu?? svolgere prima della fine del corso';
DELETE
FROM TEST
WHERE Nome_id=NEW.Nome_id;

END IF;

RETURN NEW;
END; $Dataq$ LANGUAGE plpgsql;

CREATE TRIGGER Dataq
AFTER INSERT ON TEST
FOR EACH ROW
EXECUTE FUNCTION data_quiz ();

CREATE OR REPLACE FUNCTION ins_log () RETURNS TRIGGER AS $log_ins$
DECLARE 
stud CURSOR IS(
SELECT login
FROM Studente);
BEGIN

FOR el IN stud
LOOP
IF NEW.Login=el.login THEN
RAISE NOTICE 'Questo login ?? gi?? esistente';
DELETE 
FROM INSEGNANTE
WHERE Id_ins=NEW.Id_ins;

ELSE
END IF;
END LOOP;

RETURN NEW;
END; $log_ins$ LANGUAGE plpgsql;

CREATE TRIGGER log_ins
AFTER INSERT ON INSEGNANTE
FOR EACH ROW
EXECUTE FUNCTION ins_log ();

CREATE OR REPLACE FUNCTION stud_log () RETURNS TRIGGER AS $log_stud$
DECLARE 
ins CURSOR IS(
SELECT login
FROM INSEGNANTE);
BEGIN

FOR el IN ins
LOOP
IF NEW.login=el.login THEN
RAISE NOTICE 'Questo login ?? gi?? esistente';
DELETE 
FROM STUDENTE
WHERE Id_stud=NEW.Id_stud;

ELSE
END IF;
END LOOP;

RETURN NEW;
END; $log_stud$ LANGUAGE plpgsql;

CREATE TRIGGER log_stud
AFTER INSERT ON STUDENTE
FOR EACH ROW
EXECUTE FUNCTION stud_log ();

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
FROM QUIZ_SVOLTI
WHERE Nome_id=NEW.Nome_id;
RAISE NOTICE 'ERRORE, il punteggio non riesntra nel range consentito';
END IF;

RETURN NEW;
END; $punteggio$ LANGUAGE plpgsql;

CREATE TRIGGER punteggio
AFTER INSERT ON QUIZ_SVOLTI
FOR EACH ROW
EXECUTE FUNCTION punteggio_assegnato ();

CREATE TRIGGER punteggio_1
AFTER UPDATE ON QUIZ_SVOLTI
FOR EACH ROW
EXECUTE FUNCTION punteggio_assegnato ();

CREATE OR REPLACE FUNCTION Auto_correzione () RETURNS TRIGGER AS $Correzione$
DECLARE 
risp QUIZ_RISP_MUL.Risposta_c % TYPE;
BEGIN

IF NEW.Id_quizA IS NULL THEN

SELECT Risposta_c INTO risp
FROM QUIZ_RISP_MUL
WHERE Id_quiz=NEW.Id_quizM;

IF NEW.Risposta_data=risp THEN
UPDATE QUIZ_SVOLTI
SET Punteggio_quiz_dato =(SELECT punt_c
                          FROM QUIZ_RISP_MUL
                          WHERE Id_quiz= NEW.Id_quizM)
WHERE Nome_id=NEW.Nome_id AND Id_quizM=NEW.Id_quizM AND Id_Stud=NEW.Id_stud;

ELSE

UPDATE QUIZ_SVOLTI
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
EXECUTE FUNCTION Auto_Correzione ();


CREATE OR REPLACE PROCEDURE correzione_risp_ape(
    test TEST.Nome_id%TYPE,
    studente STUDENTE.id_stud%TYPE,
    quiz QUIZ_SVOLTI.id_quizA%TYPE,
    voto QUIZ_SVOLTI.punteggio_quiz_dato%TYPE)
as $$
declare

BEGIN
UPDATE QUIZ_SVOLTI
SET Punteggio_quiz_dato=voto
WHERE Nome_id=test AND Id_quizA=quiz AND id_stud=studente;

end; $$ language plpgsql;

CREATE OR REPLACE FUNCTION quiz_test () RETURNS TRIGGER AS $test_quiz$
DECLARE 

BEGIN

IF NEW.Id_quizA IS NOT NULL THEN

IF (NEW.Id_quizA NOT IN (SELECT Id_quiz
    FROM QUIZ_RISP_APE
    WHERE Nome_id=NEW.Nome_id) )THEN
RAISE NOTICE 'ERRORE,il quiz non appartiene al test';
DELETE 
FROM QUIZ_SVOLTI
WHERE Nome_id=NEW.Nome_id AND Id_quizA=NEW.Id_quizA AND Id_stud=NEW.Id_stud;
END IF;

ELSE 
    IF( NEW.Id_quizM NOT IN (SELECT Id_quiz
                        FROM QUIZ_RISP_MUL
                        WHERE Nome_id=NEW.Nome_id) )THEN 
RAISE NOTICE 'ERRORE,il quiz non appartiene al test';
DELETE 
FROM QUIZ_SVOLTI
WHERE Nome_id=NEW.Nome_id AND Id_quizM=NEW.Id_quizM AND Id_stud=NEW.Id_stud;
END IF;
END IF;

RETURN NEW ;
END; $test_quiz$ LANGUAGE plpgsql;

CREATE TRIGGER test_quiz
AFTER INSERT ON QUIZ_SVOLTI
FOR EACH ROW
EXECUTE FUNCTION quiz_test ();

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

INSERT INTO QUIZ_RISP_APE VALUES('11','Parlami dell Impero Romano',100,10,0,'FAG56455');
INSERT INTO QUIZ_RISP_APE VALUES('12','Descrivimi l apparato digerente',100,12,0,'GSTR6473');
INSERT INTO QUIZ_RISP_APE VALUES('13','Che cos ?? il PIL, argomenta',60,6,0,'KDHE7384');
INSERT INTO QUIZ_RISP_APE VALUES('14','Cosa sono le interfacce, e a cosa servono?',150,7,0,'GDOW8920');
INSERT INTO QUIZ_RISP_APE VALUES('15','Descrizione dettagliata degli alberi AVL',200,14,0,'YEOA8394');
INSERT INTO QUIZ_RISP_APE VALUES('16','Che cos ?? una matrice associata e come pu?? essere usata?',100,8,0,'KAOS2930');
INSERT INTO QUIZ_RISP_APE VALUES('17','Le cellule eucariote e procarite.Argomenta',200,10,0,'JAOE0293');
INSERT INTO QUIZ_RISP_APE VALUES('18','Dimostrazione del Numero di Nepero',200,12,0,'JDW02845');
INSERT INTO QUIZ_RISP_APE VALUES('19','Enuncia il teorema degli zeri',200,9,0,'HSOW0384');
INSERT INTO QUIZ_RISP_APE VALUES('20','Enuncia il teorema dei valori intermedi',150,9,0,'JAOD8479');

INSERT INTO QUIZ_RISP_MUL VALUES ('1', 'Quanti piedi ha un millepiedi?','10', '100', '1000', 'non ne ha','C', 10, 0,'FAG56455');
INSERT INTO QUIZ_RISP_MUL VALUES ('2', 'Quanti lati ha un triangolo?','3', '2', '10', 'non ne ha','A', 10, 0,'GSTR6473');
INSERT INTO QUIZ_RISP_MUL VALUES ('3', 'Di che colore ?? il cielo?','blu', 'rosso', 'verde', 'giallo','A', 10, 0,'KDHE7384');
INSERT INTO QUIZ_RISP_MUL VALUES ('4', 'Quante "a" nella frase "Amo studiare basi di dati"?','5', '100', '3', '4','D', 10, 0,'GDOW8920');
INSERT INTO QUIZ_RISP_MUL VALUES ('5', 'Chi ?? kira di death note?','light yagami', 'L', 'Il prof Barra', 'io','A', 10, 0,'YEOA8394');
INSERT INTO QUIZ_RISP_MUL VALUES ('6', 'Quante sono le dita di una mano?','10', '100', '1000', '5','D', 10, 0,'KAOS2930');
INSERT INTO QUIZ_RISP_MUL VALUES ('7', 'Quale di questi NON ?? un colore primario?','rosso', 'verde', 'giallo', 'blu','B', 10, 0,'JAOE0293');
INSERT INTO QUIZ_RISP_MUL VALUES ('8', 'Quant anni per laurearsi alla triennale?','3', '5', '10', 'non ci si laurea','D', 10, 0,'JDW02845');
INSERT INTO QUIZ_RISP_MUL VALUES ('9', 'Che voto prenderanno Marzia e Noemi a questo esame?','18', '30', '30 cum laude', 'bocciate','C', 10, 0,'HSOW0384');
INSERT INTO QUIZ_RISP_MUL VALUES ('10','Cosa si mette nel caff???','sale', 'zucchero', 'pepe', 'zenzero','B', 10, 0,'JAOD8479');


INSERT INTO QUIZ_SVOLTI VALUES('FAG56455','N86006565',1,NULL, 'A',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('GSTR6473','N86003717',2,NULL,'B',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('KAOS2930','N86003444',6,NULL,'C',NULL);
INSERT INTO QUIZ_SVOLTI VALUES('YEOA8394','N86009998',NULL,15, 'GLI ALBERI AVL SONO:',3);
INSERT INTO QUIZ_SVOLTI VALUES('FAG56455','N86006565',NULL,11, 'IFUYGFU',6);
INSERT INTO QUIZ_SVOLTI VALUES('GSTR6473','N86001111',NULL,'12','L APPARATO DIGERENTE ?? COMPOSTO DA',10);
INSERT INTO QUIZ_SVOLTI VALUES('KDHE7384','N86005566',NULL,'13','IL PIL...',3);
INSERT INTO QUIZ_SVOLTI VALUES('GDOW8920','N86006889',NULL,'14','LE INTERFACCE SONO',5);
INSERT INTO QUIZ_SVOLTI VALUES('KAOS2930','N86009998',NULL,'16','UNA MATRICE ASSOCIATA...',7);
INSERT INTO QUIZ_SVOLTI VALUES('GSTR6473','N86009998',NULL,'12','L APPARATO ??',8);
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


CREATE USER professore PASSWORD 'silviobarra';
GRANT ALL ON INSEGNANTE TO professore;
GRANT ALL ON STUDENTE TO professore;
GRANT ALL ON CORSO TO professore;
GRANT ALL ON TEST TO professore;
GRANT ALL ON QUIZ_RISP_APE TO professore;
GRANT ALL ON QUIZ_RISP_MUL professore;
GRANT ALL ON QUIZ_SVOLTI TO professore;
