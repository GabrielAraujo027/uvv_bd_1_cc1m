	CREATE DATABASE uvv
 WITH 
 OWNER = gabriel 
 TEMPLATE = template0 
 ENCODING = UTF8 
 LC_COLLATE = 'pt_BR.UTF-8'
 LC_CTYPE = 'pt_BR.UTF-8'
 ALLOW_CONNECTIONS = true;

CREATE SCHEMA elmasri;
ALTER USER gabriel
SET SEARCH_PATH TO elmasri, "$user", public;

	CREATE TABLE funcionario
( 
 cpf CHAR(11) NOT NULL PRIMARY KEY,
 primeiro_nome VARCHAR(15) NOT NULL,
 nome_meio CHAR(1),
 ultimo_nome VARCHAR(15) NOT NULL,
 data_nascimento DATE,
 endereco VARCHAR(70),
 sexo CHAR(1),
 salario DECIMAL(10,2),
 cpf_supervisor CHAR(11),
 numero_departamento INT NOT NULL,
 FOREIGN KEY (cpf_supervisor) REFERENCES funcionario (cpf)
);

COMMENT ON TABLE funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN funcionario.data_nascimento IS 'Data de nascimento do funcionário';
COMMENT ON COLUMN funcionario.endereco IS 'Endereço do funcionário';
COMMENT ON COLUMN funcionario.sexo IS 'Sexo do funcionário';
COMMENT ON COLUMN funcionario.salario IS 'Salário do funcionário';
COMMENT ON COLUMN funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela';
COMMENT ON COLUMN funcionario.numero_departamento IS 'Número do departamento do funcionário.';


	CREATE TABLE dependente
(
 cpf_funcionario CHAR(11) NOT NULL,
 nome_dependente VARCHAR(15) NOT NULL,
 sexo CHAR(1),
 data_nascimento DATE,
 parentesco VARCHAR(15),
 PRIMARY KEY (cpf_funcionario, nome_dependente),
 FOREIGN KEY (cpf_funcionario) REFERENCES funcionario (cpf)
);

COMMENT ON TABLE dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN dependente.cpf_funcionario IS 'CPF do funcionário. Parte da PK desta tabela e uma FK para a tabela funcionário..';
COMMENT ON COLUMN dependente.nome_dependente IS 'Nome do dependente. Parte da PK desta tabela.';
COMMENT ON COLUMN dependente.sexo IS 'Sexo do dependente';
COMMENT ON COLUMN dependente.data_nascimento IS 'Data de nascimento do dependente';
COMMENT ON COLUMN dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';


	CREATE TABLE departamento
(
 numero_departamento INTEGER NOT NULL PRIMARY KEY,
 nome_departamento VARCHAR(15) NOT NULL UNIQUE,
 cpf_gerente VARCHAR(11) NOT NULL,
 data_inicio_gerente DATE,
 FOREIGN KEY (cpf_gerente) REFERENCES funcionario (cpf)
);

COMMENT ON TABLE departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
COMMENT ON COLUMN departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';


	CREATE TABLE localizacoes_departamento
(
 numero_departamento INTEGER NOT NULL,
 local VARCHAR(15) NOT NULL, 
 PRIMARY KEY (numero_departamento, local),
 FOREIGN KEY (numero_departamento) REFERENCES departamento (numero_departamento)
);

COMMENT ON TABLE localizacoes_departamento IS 'Localização dos departamentos';
COMMENT ON COLUMN localizacoes_departamento.numero_departamento IS 'Número do departamento. Parte da PK desta tabela e uma FK para a tabela departamento.';
COMMENT ON COLUMN localizacoes_departamento.local IS 'Localização do departamento. Parte da PK desta tabela.';


	CREATE TABLE projeto
(
 numero_projeto INTEGER NOT NULL,
 nome_projeto VARCHAR(15) NOT NULL UNIQUE,
 local_projeto VARCHAR(15),
 numero_departamento INTEGER NOT NULL, 
 PRIMARY KEY (numero_projeto),
 FOREIGN KEY (numero_departamento) REFERENCES departamento (numero_departamento)
);

COMMENT ON TABLE projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';


	CREATE TABLE trabalha_em
(
 cpf_funcionario VARCHAR(11) NOT NULL,
 numero_projeto INTEGER NOT NULL,
 horas DECIMAL(3, 1) NOT NULL,
 PRIMARY KEY(cpf_funcionario, numero_projeto),
 FOREIGN KEY(cpf_funcionario) REFERENCES funcionario(cpf),
 FOREIGN KEY(numero_projeto) REFERENCES projeto(numero_projeto)
);

COMMENT ON TABLE trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';
