CREATE DATABASE ans_dados

CREATE TABLE operadoras (
    Registro_ANS VARCHAR(20) PRIMARY KEY,
    CNPJ VARCHAR(20),
    Razao_Social VARCHAR(255),
    Nome_Fantasia VARCHAR(255),
    Modalidade VARCHAR(100),
    Logradouro VARCHAR(255),
    Numero VARCHAR(20),
    Complemento VARCHAR(255),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    UF CHAR(2),
    CEP VARCHAR(15),
    DDD VARCHAR(5),
    Telefone VARCHAR(20),
    Fax VARCHAR(20),
    Endereco_eletronico VARCHAR(255),
    Representante VARCHAR(255),
    Cargo_Representante VARCHAR(100),
    Regiao_de_Comercializacao VARCHAR(255),
    Data_Registro_ANS DATE NOT NULL
);

CREATE TABLE demonstracoes_contabeis (
    DATA DATE NOT NULL,
    Registro_ANS VARCHAR(20) NOT NULL,
    CD_CONTA_CONTABIL VARCHAR(50),
    DESCRICAO VARCHAR(255),
    VL_SALDO_INICIAL DECIMAL(18,2),
    VL_SALDO_FINAL DECIMAL(18,2),
);

COPY nome_da_tabela FROM 'caminho/do/arquivo'
DELIMITER ',' 
CSV HEADER 
ENCODING 'UTF8';

--para a primeira query: 

SELECT 
    o.Razao_Social,
    SUM(dc.VL_SALDO_INICIAL + dc.VL_SALDO_FINAL) AS total_despesas
FROM 
    operadoras o
JOIN 
    demonstracoes_contabeis dc
    ON o.registro_ans = dc.registro_ans
WHERE 
    dc.DESCRICAO = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
    AND dc.data = '2024-10-01' 
GROUP BY 
    o.Razao_Social
ORDER BY 
    total_despesas DESC
LIMIT 10;

--para a segunda query:

SELECT 
    o.Razao_Social,
    SUM(dc.VL_SALDO_INICIAL + dc.VL_SALDO_FINAL) AS total_despesas
FROM 
    operadoras o
JOIN 
    demonstracoes_contabeis dc
    ON o.registro_ans = dc.registro_ans
WHERE 
    dc.DESCRICAO = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
    AND dc.data BETWEEN CURRENT_DATE - INTERVAL '1 year' AND CURRENT_DATE -- Últimos 12 meses
GROUP BY 
    o.Razao_Social
ORDER BY 
    total_despesas DESC
LIMIT 10;
