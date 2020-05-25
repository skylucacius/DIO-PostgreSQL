CREATE TABLE IF NOT EXISTS banco(
	numero INTEGER NOT NULL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL ,
	ativo NOT NULL BOOLEAN,
	data_criacao NOT NULL TIMESTAMP default CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS agencia(
	numero INTEGER NOT NULL PRIMARY KEY,
	numero_banco INTEGER NOT NULL FOREIGN KEY()
)