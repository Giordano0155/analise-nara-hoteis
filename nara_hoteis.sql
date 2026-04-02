CREATE DATABASE nara_hoteis;
USE nara_hoteis;


-- hotéis = dimensão
CREATE TABLE hoteis (
    id_hotel 				INT PRIMARY KEY,
    nome_hotel 				VARCHAR(100),
    cidade					VARCHAR(50),
    estado 					VARCHAR(50),
    categoria 				VARCHAR(20),
    n_quartos 				INT
);


-- quartos = dimensão
CREATE TABLE quartos (
    id_quarto 				INT PRIMARY KEY,
    id_hotel 				INT,
    tipo_quarto 			VARCHAR(50),
    capacidade 				INT,
    valor_base 				DECIMAL(10,2),
    andar 					INT,
    vista 					VARCHAR(50),
    
		FOREIGN KEY (id_hotel) REFERENCES hoteis(id_hotel)
);


-- hóspedes = dimensão
CREATE TABLE hospedes (
    id_hospede 				INT PRIMARY KEY,
    nome 					VARCHAR(100),
    email 					VARCHAR(100),
    telefone 				VARCHAR(20),
    cidade_origem 			VARCHAR(50),
    estado 					VARCHAR(50),
    data_nascimento 		DATE,
    genero 					VARCHAR(20)
);


-- reservas = fato
CREATE TABLE reservas (
    id_reserva 				INT PRIMARY KEY,
    id_hospede 				INT,
    id_quarto 				INT,
    id_hotel 				INT,
    data_checkin 			DATE,
    data_checkout 			DATE,
    data_reserva 			DATE,
    canal_reserva 			VARCHAR(50),
    valor_diaria 			DECIMAL(10,2),
    status_reserva		 	VARCHAR(20),

		FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
		FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto),
		FOREIGN KEY (id_hotel) REFERENCES hoteis(id_hotel)
);


-- avalições = fato
CREATE TABLE avaliacoes (
    id_avaliacao		 	INT PRIMARY KEY,
    id_reserva 				INT,
    nota_geral 				DECIMAL(3,2),
    nota_limpeza 			DECIMAL(3,2),
    nota_atendimento 		DECIMAL(3,2),
    nota_custo_beneficio 	DECIMAL(3,2),
    comentario TEXT,
    data_avaliacao DATE,

		FOREIGN KEY (id_reserva) REFERENCES fato_reserva(id_reserva)
);





SET GLOBAL local_infile = 1;


LOAD DATA INFILE 'avaliacoes.csv'
INTO TABLE avaliacao
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_avaliacao, id_reserva, nota_geral, nota_limpeza, nota_atendimento, nota_custo_beneficio, comentario, data_avaliacao);