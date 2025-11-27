SELECT * FROM Dependente
SELECT * FROM Funcionario

INSERT INTO Funcionario (CPF, Nome, DataNascimento, Sexo)
VALUES ('12121212121', 'José Teste', '1990-10-10', 'M')


UPDATE Funcionario
SET Nome = 'José Silva'
WHERE Nome = 'José Teste'

SELECT * FROM Funcionario WHERE Nome LIKE '%José%'

DELETE FROM Funcionario
WHERE Nome = 'José Silva'

UPDATE Funcionario
SET Nome = 'José Brasileiro',
    DataNascimento = '1979-11-23'
WHERE FuncionarioID = 60007

SELECT *
FROM Funcionario
WHERE Sexo = 'F'

SELECT *
FROM Funcionario
WHERE Sexo = 'M'

SELECT *
FROM Funcionario
WHERE Nome LIKE 'M%'

SELECT *
FROM Dependente
WHERE Nome LIKE 'P%'

SELECT *
FROM Funcionario
WHERE Nome LIKE '%Cruz%'

SELECT *
FROM Dependente
WHERE Nome LIKE '% Cruz'

/* */

/*14*/
SELECT TOP 1 
    P.ProjetoID,
    P.Nome AS NomeProjeto,
    SUM(T.QtdeHoras) AS TotalHoras
FROM TrabalhaProjeto T
JOIN Projeto P ON P.ProjetoID = T.ProjetoID
GROUP BY P.ProjetoID, P.Nome
ORDER BY TotalHoras ASC;

/*15*/
SELECT 
    P.ProjetoID,
    P.Nome AS NomeProjeto,
    AVG(T.QtdeHoras) AS MediaHoras
FROM TrabalhaProjeto T
JOIN Projeto P ON P.ProjetoID = T.ProjetoID
GROUP BY P.ProjetoID, P.Nome
ORDER BY MediaHoras DESC;

/*16*/
SELECT 
    Sexo,
    COUNT(*) AS Quantidade
FROM Funcionario
GROUP BY Sexo;

/*16*/
SELECT TOP 2 
    Nome,
    DataNascimento
FROM Funcionario
ORDER BY DataNascimento ASC;

/*17*/
SELECT TOP 3 
    Nome,
    Sexo,
    DataNascimento
FROM Funcionario
ORDER BY Sexo ASC, DataNascimento DESC;

/*18*/
SELECT 
    Departamento.DepartamentoID,
    Departamento.Nome,
    Projeto.ProjetoID,
    IIF(Projeto.Nome IS NULL, 'Sem Projeto', Projeto.Nome)
    as Projeto
FROM Departamento
LEFT JOIN Projeto 
on Departamento.DepartamentoID = Projeto.DepartamentoID

/*19*/
SELECT 
    D.DependenteID AS CodigoDependente,
    D.Nome AS NomeDependente,
    F.Nome AS NomeFuncionario
FROM Dependente D
INNER JOIN Funcionario F 
    ON D.FuncionarioID = F.FuncionarioID;

    /*20*/
SELECT 
    F.FuncionarioID,
    F.Nome AS NomeFuncionario,
    F.CPF,
    F.DataNascimento,
    F.Sexo,
    T.ProjetoID
FROM Funcionario F
INNER JOIN TrabalhaProjeto T 
    ON F.FuncionarioID = T.FuncionarioID;

    /*21*/
SELECT 
    P.ProjetoID,
    P.Nome AS NomeProjeto,
    D.Nome AS NomeDepartamento,
    F.FuncionarioID,
    F.Nome AS NomeFuncionario
FROM Projeto P
INNER JOIN Departamento D 
    ON P.DepartamentoID = D.DepartamentoID
INNER JOIN TrabalhaProjeto T 
    ON P.ProjetoID = T.ProjetoID
INNER JOIN Funcionario F 
    ON T.FuncionarioID = F.FuncionarioID
ORDER BY P.ProjetoID, F.Nome;

/*22*/
SELECT 
    F.FuncionarioID,
    F.Nome AS NomeFuncionario,
    F.CPF,
    F.DataNascimento,
    F.Sexo
FROM Funcionario F
LEFT JOIN Dependente D 
    ON F.FuncionarioID = D.FuncionarioID
WHERE D.DependenteID IS NULL;


/*23*/
SELECT 
    F.Nome AS NomeFuncionario,
    COUNT(D.DependenteID) AS QuantidadeDependentes
FROM Funcionario F
INNER JOIN Dependente D 
    ON F.FuncionarioID = D.FuncionarioID
GROUP BY F.Nome
ORDER BY QuantidadeDependentes DESC;

/*24*/
SELECT 
    F.Nome AS NomeFuncionario,
    COALESCE(SUM(T.QtdeHoras), 0) AS TotalHorasTrabalhadas
FROM Funcionario F
LEFT JOIN TrabalhaProjeto T 
    ON F.FuncionarioID = T.FuncionarioID
GROUP BY F.Nome
ORDER BY TotalHorasTrabalhadas DESC;

/*25*/
SELECT 
    F.FuncionarioID,
    F.Nome AS NomeFuncionario,
    COALESCE(SUM(1), 0) AS QuantidadeDependentes
FROM Funcionario F
LEFT JOIN Dependente D 
    ON F.FuncionarioID = D.FuncionarioID
GROUP BY F.FuncionarioID, F.Nome
ORDER BY QuantidadeDependentes DESC;


/*26*/
SELECT 
    D.DepartamentoID,
    D.Nome AS NomeDepartamento,
    COALESCE(SUM(T.QtdeHoras), 0) AS TotalHoras
FROM Departamento D
LEFT JOIN Projeto P 
    ON D.DepartamentoID = P.DepartamentoID
LEFT JOIN TrabalhaProjeto T 
    ON P.ProjetoID = T.ProjetoID
GROUP BY D.DepartamentoID, D.Nome
ORDER BY TotalHoras DESC;

/*27*/

SELECT 
    D.DepartamentoID,
    D.Nome AS NomeDepartamento
FROM Departamento D
LEFT JOIN Projeto P 
    ON D.DepartamentoID = P.DepartamentoID
WHERE P.ProjetoID IS NULL;

/*28*/

SELECT 
    F.FuncionarioID,
    F.Nome AS NomeFuncionario
FROM Funcionario F
LEFT JOIN Dependente D 
    ON F.FuncionarioID = D.FuncionarioID
WHERE D.DependenteID IS NULL;


/*29*/
SELECT 
    MONTH(F.DataNascimento) AS MesNascimento,
    COUNT(*) AS QuantidadeFuncionarios
FROM Funcionario F
GROUP BY MONTH(F.DataNascimento)
ORDER BY MesNascimento;


/*30*/
SELECT
    YEAR(F.DataNascimento) AS AnoNascimento,
    MONTH(F.DataNascimento) AS MesNascimento,
    COUNT(*) AS QuantidadeFuncionarios
FROM Funcionario F
GROUP BY YEAR(F.DataNascimento), MONTH(F.DataNascimento)
ORDER BY AnoNascimento, MesNascimento;


/*31*/
SELECT 
    F.Nome AS NomeFuncionario,
    DATEDIFF(YEAR, F.DataNascimento, GETDATE()) 
        - CASE 
            WHEN MONTH(GETDATE()) < MONTH(F.DataNascimento)
                OR (MONTH(GETDATE()) = MONTH(F.DataNascimento) AND DAY(GETDATE()) < DAY(F.DataNascimento))
              THEN 1 
              ELSE 0 
          END AS Idade
FROM Funcionario F;


/*32*/
CREATE VIEW vw_FuncionariosBasico AS
SELECT 
    F.FuncionarioID,
    F.Nome,
    F.DataNascimento
FROM Funcionario F;

/*Consulta*/
SELECT * FROM vw_FuncionariosBasico;

/*33*/

CREATE VIEW vw_ProjetosPorFaixaIdade AS
SELECT 
    FaixaIdade,
    COUNT(T.ProjetoID) AS QuantidadeProjetos
FROM (
    SELECT 
        F.FuncionarioID,
        CASE 
            WHEN DATEDIFF(YEAR, F.DataNascimento, GETDATE()) 
                 - CASE WHEN MONTH(GETDATE()) < MONTH(F.DataNascimento)
                        OR (MONTH(GETDATE()) = MONTH(F.DataNascimento) AND DAY(GETDATE()) < DAY(F.DataNascimento))
                   THEN 1 ELSE 0 END < 25 THEN '< 25'
            WHEN DATEDIFF(YEAR, F.DataNascimento, GETDATE()) 
                 - CASE WHEN MONTH(GETDATE()) < MONTH(F.DataNascimento)
                        OR (MONTH(GETDATE()) = MONTH(F.DataNascimento) AND DAY(GETDATE()) < DAY(F.DataNascimento))
                   THEN 1 ELSE 0 END BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, F.DataNascimento, GETDATE()) 
                 - CASE WHEN MONTH(GETDATE()) < MONTH(F.DataNascimento)
                        OR (MONTH(GETDATE()) = MONTH(F.DataNascimento) AND DAY(GETDATE()) < DAY(F.DataNascimento))
                   THEN 1 ELSE 0 END BETWEEN 36 AND 50 THEN '36-50'
            ELSE '> 50'
        END AS FaixaIdade
    FROM Funcionario F
) X
LEFT JOIN TrabalhaProjeto T ON X.FuncionarioID = T.FuncionarioID
GROUP BY FaixaIdade;

/*Consulta*/
SELECT * FROM vw_ProjetosPorFaixaIdade;


/*34*/
SELECT 
    F.Nome AS NomeFuncionario,
    D.Nome AS NomeDepartamento
FROM Funcionario F
INNER JOIN Departamento D 
    ON F.DepartamentoID = D.DepartamentoID;


/*35*/
SELECT 
    F.Nome AS NomeFuncionario,
    COUNT(T.ProjetoID) AS QuantidadeProjetos
FROM Funcionario F
INNER JOIN TrabalhaProjeto T 
    ON F.FuncionarioID = T.FuncionarioID
GROUP BY F.Nome
HAVING COUNT(T.ProjetoID) > 1;


/*36*/
SELECT 
    P.ProjetoID,
    P.Nome AS NomeProjeto,
    SUM(T.QtdeHoras) AS TotalHoras
FROM Projeto P
INNER JOIN TrabalhaProjeto T 
    ON P.ProjetoID = T.ProjetoID
GROUP BY P.ProjetoID, P.Nome
HAVING SUM(T.QtdeHoras) > 200;


/*37*/
SELECT 
    F.FuncionarioID,
    F.Nome AS NomeFuncionario
FROM Funcionario F
LEFT JOIN TrabalhaProjeto T 
    ON F.FuncionarioID = T.FuncionarioID
WHERE T.ProjetoID IS NULL;


/*38*/
SELECT 
    F.Nome AS NomeFuncionario,
    COUNT(D.DependenteID) AS QuantidadeDependentes,
    COALESCE(SUM(T.QtdeHoras), 0) AS TotalHoras
FROM Funcionario F
LEFT JOIN Dependente D 
    ON F.FuncionarioID = D.FuncionarioID
LEFT JOIN TrabalhaProjeto T 
    ON F.FuncionarioID = T.FuncionarioID
GROUP BY F.Nome;


/*39*/
CREATE VIEW vw_FuncionariosProjetos AS
SELECT 
    F.Nome AS NomeFuncionario,
    D.Nome AS NomeDepartamento,
    COALESCE(SUM(T.QtdeHoras), 0) AS TotalHoras
FROM Funcionario F
INNER JOIN Departamento D 
    ON F.DepartamentoID = D.DepartamentoID
LEFT JOIN TrabalhaProjeto T 
    ON F.FuncionarioID = T.FuncionarioID
GROUP BY F.Nome, D.Nome;


/*40*/
CREATE PROCEDURE sp_BuscarFuncionarioPorNome
    @NomeParcial VARCHAR(100)
AS
BEGIN
    SELECT 
        *
    FROM Funcionario
    WHERE Nome LIKE '%' + @NomeParcial + '%';
END;


EXEC sp_BuscarFuncionarioPorNome 'ana';

/*41*/
SELECT 
    F.Nome AS NomeFuncionario,
    CASE
        WHEN Idade <= 25 THEN 'Jovem'
        WHEN Idade BETWEEN 26 AND 45 THEN 'Adulto'
        ELSE 'Sênior'
    END AS FaixaEtaria
FROM (
    SELECT 
        Nome,
        DATEDIFF(YEAR, DataNascimento, GETDATE()) 
            - CASE 
                WHEN MONTH(GETDATE()) < MONTH(DataNascimento)
                  OR (MONTH(GETDATE()) = MONTH(DataNascimento) AND DAY(GETDATE()) < DAY(DataNascimento))
                    THEN 1 ELSE 0 
              END AS Idade
    FROM Funcionario
) F;


/*42*/

SELECT 
    F.Nome AS NomeFuncionario,
    COUNT(D.DependenteID) AS QuantidadeDependentes,
    AVG(T.QtdeHoras) AS MediaHorasPorProjeto
FROM Funcionario F
LEFT JOIN Dependente D 
    ON F.FuncionarioID = D.FuncionarioID
LEFT JOIN TrabalhaProjeto T 
    ON F.FuncionarioID = T.FuncionarioID
GROUP BY F.Nome;


/*43*/

CREATE VIEW vw_HorasFuncionarioDepartamento AS
SELECT 
    F.Nome AS NomeFuncionario,
    D.Nome AS NomeDepartamento,
    COALESCE(SUM(T.QtdeHoras), 0) AS TotalHoras
FROM Funcionario F
LEFT JOIN TrabalhaProjeto T 
    ON F.FuncionarioID = T.FuncionarioID
LEFT JOIN Projeto P
    ON T.ProjetoID = P.ProjetoID
LEFT JOIN Departamento D
    ON P.DepartamentoID = D.DepartamentoID
GROUP BY 
    F.Nome, 
    D.Nome;

SELECT *
FROM vw_HorasFuncionarioDepartamento
ORDER BY TotalHoras DESC;


/*44*/
CREATE PROCEDURE sp_ProjetosDoFuncionario
    @FuncionarioID INT
AS
BEGIN
    SELECT 
        P.ProjetoID,
        P.Nome AS NomeProjeto,
        T.QtdeHoras
    FROM TrabalhaProjeto T
    INNER JOIN Projeto P
        ON T.ProjetoID = P.ProjetoID
    WHERE T.FuncionarioID = @FuncionarioID;
END;

/*Execução de exemplo*/
-- EXEC sp_ProjetosDoFuncionario 1;

/*45*/
CREATE PROCEDURE sp_FuncionariosDoProjeto
    @ProjetoID INT
AS
BEGIN
    SELECT 
        F.FuncionarioID,
        F.Nome AS NomeFuncionario,
        T.QtdeHoras
    FROM TrabalhaProjeto T
    INNER JOIN Funcionario F
        ON T.FuncionarioID = F.FuncionarioID
    WHERE T.ProjetoID = @ProjetoID;
END;

/*Execução de exemplo*/
-- EXEC sp_FuncionariosDoProjeto 1;

/*46*/
CREATE PROCEDURE sp_FuncionariosNascidosApos
    @DataNascimento DATE
AS
BEGIN
    SELECT 
        FuncionarioID,
        Nome,
        DataNascimento
    FROM Funcionario
    WHERE DataNascimento > @DataNascimento;
END;

/*Execução de exemplo*/
-- EXEC sp_FuncionariosNascidosApos '1990-01-01';

/*47*/
CREATE PROCEDURE sp_AtualizarDataNascimento
    @FuncionarioID INT,
    @NovaDataNascimento DATE
AS
BEGIN
    UPDATE Funcionario
    SET DataNascimento = @NovaDataNascimento
    WHERE FuncionarioID = @FuncionarioID;

    SELECT FuncionarioID, Nome, DataNascimento
    FROM Funcionario
    WHERE FuncionarioID = @FuncionarioID;
END;

/*Execução de exemplo*/
-- EXEC sp_AtualizarDataNascimento 1, '1992-05-15';
