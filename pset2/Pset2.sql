use uvv;

--Questão 01
SELECT nome_departamento AS departamento, CONCAT('R$ ', CAST(AVG(salario) AS DECIMAL(10,2))) AS média_salarial 
FROM funcionarios f 
INNER JOIN departamento d
WHERE f.numero_departamento = d.numero_departamento 
GROUP BY nome_departamento;


--Questão 02
SELECT CASE WHEN sexo = 'M' THEN 'Masculino' WHEN sexo = 'm' THEN 'Masculino' WHEN sexo = 'F' THEN 'Feminino' WHEN sexo = 'f' THEN 'Feminino' END AS sexo,
CONCAT('R$ ', CAST(AVG(salario) AS DECIMAL(10,2))) AS média_salarial FROM funcionarios 
GROUP BY Sexo;


--Questão 03
SELECT nome_departamento AS departamento, CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo,
data_nascimento AS data_de_nascimento,
FLOOR(DATEDIFF(CURDATE(), data_nascimento)/325.25) AS idade,
CONCAT('R$ ', CAST((salario) AS DECIMAL(10,2))) AS salário 
FROM funcionarios f 
INNER JOIN departamento d 
WHERE f.numero_departamento = d.numero_departamento
ORDER BY nome_departamento;


--Questão 04
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS idade, 
CONCAT('R$ ', CAST((salario) AS DECIMAL(10,2))) AS salário, CONCAT('R$ ', CAST((salario*1.2) AS DECIMAL(10,2))) AS novo_salário 
FROM funcionarios f 
WHERE salario < '35000' 
UNION
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS idade, 
CONCAT('R$ ', CAST((salario) AS DECIMAL(10,2))) AS salário, CONCAT('R$ ', CAST((salario*1.15) AS DECIMAL(10,2))) AS novo_salário 
FROM funcionarios f
WHERE salario >= '35000';


--Questão 05
SELECT nome_departamento AS departamento, g.primeiro_nome AS gerente, f.primeiro_nome AS funcionário, 
CONCAT('R$ ', CAST((salario) AS DECIMAL(10,2))) AS salário 
FROM departamento d 
INNER JOIN funcionarios f, 
( SELECT primeiro_nome, cpf 
  FROM funcionario f
  INNER  JOIN departamento d 
  WHERE f.cpf = d.cpf_gerente) AS g
WHERE d.numero_departamento = f.numero_departamento AND g.cpf = d.cpf_gerente
ORDER BY d.nome_departamento ASC, f.salario DESC;


--QUESTÃO 06
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo, dto.nome_departamento AS departamento,
dpd.nome_dependente AS dependente, FLOOR(DATEDIFF(CURDATE(), dpd.data_nascimento)/365.25) AS idade_dependente,
CASE WHEN dpd.sexo = 'M' THEN 'Masculino' WHEN dpd.sexo = 'm' THEN 'Masculino' WHEN dpd.sexo = 'F' THEN 'Feminino' WHEN dpd.sexo = 'f' THEN 'Feminino'
END AS sexo_dependente
FROM funcionarios f
INNER JOIN departamento dto ON f.numero_departamento = dto.numero_departamento
INNER JOIN dependente dpd ON dpd.cpf_funcionario = f.cpf;


--QUESTÃO 07
SELECT DISTINCT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo, dto.nome_departamento AS departamento,
CONCAT('R$ ', CAST((f.salario) AS DECIMAL(10,2))) AS Salário 
FROM funcionarios f
INNER JOIN departamento dto 
INNER JOIN dependente dpd
WHERE dto.numero_departamento = f.numero_departamento AND f.cpf NOT IN 
( SELECT dpd.cpf_funcionario 
  FROM dependente dpd);


--Questão 08
SELECT d.nome_departamento AS departamento, p.nome_projeto AS projeto,
CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo, t.horas AS horas
FROM funcionarios f 
INNER JOIN departamento d 
INNER JOIN projeto p 
INNER JOIN trabalha_em t 
WHERE d.numero_departamento = f.numero_departamento
AND p.numero_projeto = t.numero_projeto AND f.cpf = t.cpf_funcionario
ORDER BY p.numero_projeto;


--Questão 09
SELECT d.nome_departamento AS departamento, p.nome_projeto AS projeto, SUM(t.horas) AS total_de_horas 
FROM departamento d 
INNER JOIN projeto p 
INNER JOIN trabalha_em t 
WHERE d.numero_departamento = p.numero_departamento
AND p.numero_projeto = t.numero_projeto
GROUP BY p.nome_projeto;


--Questão 10
SELECT d.nome_departamento AS departamento, CONCAT('R$ ', CAST(AVG(f.salario) AS DECIMAL(10,2))) AS média_salarial
FROM departamento d 
INNER JOIN funcionarios f 
WHERE d.numero_departamento = f.numero_departamento
GROUP BY d.nome_departamento;


--Questão 11
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo, p.nome_projeto AS projeto,
CONCAT('R$ ', CAST((t.horas*50) AS DECIMAL (10,2))) AS Recebimento 
FROM funcionarios f 
INNER JOIN projeto p 
INNER JOIN trabalha_em t
WHERE f.cpf = t.cpf_funcionario AND p.numero_projeto = t.numero_projeto 
GROUP BY f.primeiro_nome;


--QUESTÃO 12
SELECT d.nome_departamento AS departamento, p.nome_projeto AS projeto,
CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo, t.horas AS Horas
FROM funcionarios f 
INNER JOIN departamento d 
INNER JOIN projeto p 
INNER JOIN trabalha_em t
WHERE f.cpf = t.cpf_funcionario AND p.numero_projeto = t.numero_projeto AND (t.horas = 0 OR t.horas = NULL) 
GROUP BY f.primeiro_nome;


--QUESTÃO 13
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome,
CASE WHEN sexo = 'M' THEN 'Masculino' WHEN sexo = 'm' THEN 'Masculino'
WHEN sexo = 'F' THEN 'Feminino' WHEN sexo = 'f' THEN 'Feminino' END AS sexo,
FLOOR(DATEDIFF(CURDATE(), f.data_nascimento)/365.25) AS idade
FROM funcionarios f
UNION
SELECT d.nome_dependente AS nome,
CASE WHEN sexo = 'M' THEN 'Masculino' WHEN sexo = 'm' THEN 'Masculino'
WHEN sexo = 'F' THEN 'Feminino' WHEN sexo = 'f' THEN 'Feminino' END AS sexo,
FLOOR(DATEDIFF(CURDATE(), d.data_nascimento)/365.25) AS idade
FROM dependente d
ORDER BY idade;


--QUESTÃO 14
SELECT d.nome_departamento AS departamento, 
COUNT(f.numero_departamento) AS número_funcionários 
FROM funcionarios f 
INNER JOIN departamento d
WHERE f.numero_departamento = d.numero_departamento 
GROUP BY d.nome_departamento;


--Questão 15
SELECT DISTINCT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome_completo,
d.nome_departamento AS departamento, 
p.nome_projeto AS Projeto 
FROM departamento d 
INNER JOIN projeto p 
INNER JOIN trabalha_em t 
INNER JOIN funcionarios f 
WHERE d.numero_departamento = f.numero_departamento AND p.numero_projeto = t.numero_projeto AND t.cpf_funcionario = f.cpf
UNION
SELECT DISTINCT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_completo,
d.nome_departamento AS departamento, 
'Sem projeto' AS projeto 
FROM departamento d 
INNER JOIN projeto p 
INNER JOIN trabalha_em t 
INNER JOIN funcionarios f 
WHERE d.numero_departamento = f.numero_departamento AND p.numero_projeto = t.numero_projeto AND 
(f.cpf NOT IN (SELECT t.cpf_funcionario FROM trabalha_em t));
