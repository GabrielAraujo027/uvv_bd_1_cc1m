	CREATE DATABASE uvv 
CHARSET = UTF8 
COLLATE = utf8_general_ci;


use uvv;


	CREATE TABLE funcionario
( 
 cpf CHAR(11) NOT NULL PRIMARY KEY COMMENT 'Cpf do funcionário.',
 primeiro_nome VARCHAR(15) NOT NULL COMMENT 'Primeiro nome do funcionário',
 nome_meio CHAR(1) COMMENT 'Nome do meio do funcionário',
 ultimo_nome VARCHAR(15) NOT NULL COMMENT 'Ultimo nome do funcionário',
 data_nascimento DATE COMMENT 'Data de nascimento do funcionário',
 endereco VARCHAR(70) COMMENT 'Endereço do funcionário',
 sexo CHAR(1) COMMENT 'Sexo do funcionário',
 salario DECIMAL(10,2) COMMENT 'Salário do funcionário',
 cpf_supervisor CHAR(11) COMMENT 'CPF do supervisor do funcionário',
 numero_departamento INT NOT NULL COMMENT 'Número do departamento que o funcionário trabalha',
 FOREIGN KEY (cpf_supervisor) REFERENCES funcionario (cpf)
);


	CREATE TABLE dependente
(
 cpf_funcionario CHAR(11) NOT NULL COMMENT 'CPF do funcionário',
 nome_dependente VARCHAR(15) NOT NULL COMMENT 'Nome do dependente',
 sexo CHAR(1) COMMENT 'Sexo do dependente',
 data_nascimento DATE COMMENT 'Data de nascimento do dependente',
 parentesco VARCHAR(15) COMMENT 'Parentesco entre funcionário e dependente',
 PRIMARY KEY (cpf_funcionario, nome_dependente), 
 FOREIGN KEY (cpf_funcionario) REFERENCES funcionario (cpf) 
);


	CREATE TABLE departamento
(
 numero_departamento INTEGER NOT NULL PRIMARY KEY COMMENT 'Número do departamento do funcionário',
 nome_departamento VARCHAR(15) NOT NULL UNIQUE COMMENT 'Nome do departamento do funcionário', 
 cpf_gerente VARCHAR(11) NOT NULL COMMENT 'CPF do gerente do departamento',
 data_inicio_gerente DATE COMMENT 'Data em que o gerente começou no departamento',
 FOREIGN KEY (cpf_gerente) REFERENCES funcionario (cpf)
);

	CREATE TABLE localizacoes_departamento
(
 numero_departamento INTEGER NOT NULL COMMENT 'Numero do departamento',
 local VARCHAR(15) NOT NULL COMMENT 'Local do departamento',
 PRIMARY KEY (numero_departamento, local),
 FOREIGN KEY (numero_departamento) REFERENCES departamento (numero_departamento)
);

	CREATE TABLE projeto
(
 numero_projeto INTEGER NOT NULL COMMENT 'Número do projeto',
 nome_projeto VARCHAR(15) NOT NULL UNIQUE COMMENT 'Nome do projeto',
 local_projeto VARCHAR(15) COMMENT 'Local do projeto',
 numero_departamento INTEGER NOT NULL COMMENT 'Número do departamento em que o projeto está sendo realizado',
 PRIMARY KEY (numero_projeto),
 FOREIGN KEY (numero_departamento) REFERENCES departamento (numero_departamento)
);

	CREATE TABLE trabalha_em
(
 cpf_funcionario VARCHAR(11) NOT NULL COMMENT 'Cpf do funcionário',
 numero_projeto INTEGER NOT NULL COMMENT 'Número do projet que o funcionário está trabalhando',
 horas DECIMAL(3, 1) NOT NULL COMMENT 'Horas que o funcionário está trabalhando',
 PRIMARY KEY(cpf_funcionario, numero_projeto),
 FOREIGN KEY(cpf_funcionario) REFERENCES funcionario(cpf),
 FOREIGN KEY(numero_projeto) REFERENCES projeto(numero_projeto)
);
