 INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)

VALUES ('Jorge','E','Brito','88866555576','1937-11-1','Rua do Horto,35,São Paulo, SP','M',55000,NULL,1),

('Fernando','T','Wong','33344555587','1955-12-08','Rua da Lapa, 34, São Paulo, SP','M',40000,'88866555576',5),

('Jennifer','S','Souza','98765432168','1941-06-20','Av. Arthur de Lina, 54, Santo André, SP','F',43000,'88866555576',4),

('João','B','Silva','12345678966','1965-01-19','Rua das Flores, 751, São Paulo, SP','M',30000,'33344555587',5),

('Alice','J','Zelaya','99988777767','1968-01-19','Rua Souza Lima, 35, Curitiba, PR','F',25000,'98765432168',4),

('Ronaldo','K','Lima','66688444476','1962-09-15','Rua Rebouças, 65, Piracicaba, SP','M',38000,'33344555587',5),

('Joice','A','Leite','45345345376','1972-07-31','Av. Lucas Obes, 74, São Paulo, SP','F', 25000,'33344555587',5),

('André','V','Pereira','98798798733','1969-03-29','Rua Timbira,35, São Paulo, SP','M',25000,'98765432168',4);


 INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco) VALUES
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');


 INSERT INTO departamento (numero_departamento, nome_departamento, data_inicio_gerente, cpf_gerente) VALUES
(1, 'Matriz', '1981-06-19', '88866555576'),
(4, 'Administração', '1995-01-01', '98765432168'),
(5, 'Pesquisa', '1998-05-22', '33344555587');


 INSERT INTO localizacoes_departamento (local, numero_departamento) VALUES
('Itu', 5),
('Mauá', 4),
('Santo André', 5),
('São Paulo', 1),
('São Paulo', 5);


 INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento) VALUES
('ProdutoX', 1, 'Santo André', 5),
('ProdutoY', 2, 'Itu', 5),
('ProdutoZ', 3, 'São Paulo', 5),
('Informatização', 10, 'Mauá', 4),
('Reorganização', 20, 'São Paulo', 1),
('Novosbeneficios', 30, 'Mauá', 4);


 INSERT INTO trabalha_em (numero_projeto, cpf_funcionario, horas) VALUES
(1, '12345678966', '32.5'),
(1, '45345345376', '20.0'),
(2, '12345678966', '7.5'),
(2, '33344555587', '10.0'),
(2, '45345345376', '20.0'),
(3, '33344555587', '10.0'),
(3, '66688444476', '40.0'),
(10, '33344555587', '10.0'),
(10, '98798798733', '35.0'),
(10, '99988777767', '10.0'),
(20, '33344555587', '10.0'),
(20, '88866555576', 0),
(20, '98765432168', '15.0'),
(30, '98765432168', '20.0'),
(30, '98798798733', '5.0'),
(30, '99988777767', '30.0');
