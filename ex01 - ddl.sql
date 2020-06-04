CREATE TABLE IF NOT EXISTS banco (
	numero INTEGER NOT NULL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL default CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS agencia(
	banco_numero INTEGER NOT NULL REFERENCES banco(numero),
	numero INTEGER NOT NULL,
	nome VARCHAR(80) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL default CURRENT_TIMESTAMP,	
	PRIMARY KEY (numero, banco_numero)
);

CREATE TABLE IF NOT EXISTS cliente(
	numero BIGSERIAL PRIMARY KEY,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(250) NOT NULL, 
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL default CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS conta_corrente(
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	cliente_numero BIGINT,
	numero BIGINT NOT NULL,
	digito SMALLINT NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL default CURRENT_TIMESTAMP,
	PRIMARY KEY (banco_numero, agencia_numero, cliente_numero, numero, digito),
	FOREIGN KEY (banco_numero, agencia_numero) REFERENCES agencia(banco_numero, numero),
	FOREIGN KEY (cliente_numero) REFERENCES cliente(numero)
);

CREATE TABLE IF NOT EXISTS tipo_transacao(
	id SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50),
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL default CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cliente_transacoes(
	id BIGSERIAL PRIMARY KEY,
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	cliente_numero BIGINT NOT NULL,
	conta_corrente_numero BIGINT NOT NULL,
	conta_corrente_digito SMALLINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL REFERENCES tipo_transacao(id),
	data_criacao TIMESTAMP NOT NULL default CURRENT_TIMESTAMP,
	valor NUMERIC(15,2) NOT NULL,
	FOREIGN KEY (banco_numero, agencia_numero, cliente_numero, conta_corrente_numero, conta_corrente_digito)
		REFERENCES conta_corrente(banco_numero, agencia_numero, cliente_numero, numero, digito)
);