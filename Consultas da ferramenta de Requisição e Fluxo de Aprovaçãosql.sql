-- Consulta em todas as tabelas: 
SELECT * FROM [USUARIO];
SELECT * FROM [REQUISICAO];
SELECT * FROM [STATUS_REQUISICAO];
SELECT * FROM [CATEGORIA];
SELECT * FROM [ITEM_TIPO];
SELECT * FROM [REQUISICAO_APROVADORES];
SELECT * FROM [SOLICITANTE_APROVADORES];
SELECT * FROM [ITEM];

-- Consulta em colunas específicas: 
SELECT [Nome], [Email] FROM [USUARIO];
SELECT [Descricao], [Justificativa] FROM [REQUISICAO];
SELECT [Status_Requisicao] FROM [STATUS_REQUISICAO];
SELECT [Nome] FROM [CATEGORIA];
SELECT [Item_Tipo] FROM [ITEM_TIPO];
SELECT [Solicitante], [Aprovador] FROM [SOLICITANTE_APROVADORES];
SELECT [Nome], [Preco] FROM [ITEM];

-- Mudando a ordem dos campos: 
SELECT [Nome], [Usuario], [Email] FROM [USUARIO]; 

-- Consulta apelidando colunas: 
SELECT [Nome] AS [Nome_Usuario], [Email] AS [Email_Usuario] FROM [USUARIO];
SELECT [Descricao] AS [Tipo_Requisicao], [Justificativa] AS [Razao] FROM [REQUISICAO];
SELECT [Status_Requisicao] AS [Status] FROM [STATUS_REQUISICAO];
SELECT [Nome] AS [Categoria] FROM [CATEGORIA];
SELECT [Item_Tipo] AS [Tipo_Item] FROM [ITEM_TIPO];
SELECT [Solicitante] AS [Solicitante_ID], [Aprovador] AS [Aprovador_ID] FROM [SOLICITANTE_APROVADORES];
SELECT [Nome] AS [Nome_Item], [Preco] AS [Preco_Unitario] FROM [ITEM];

-- Consulta com seleção distinta: 
SELECT DISTINCT [Estado] FROM [REQUISICAO];
SELECT DISTINCT [ItemTipo] FROM [REQUISICAO];
SELECT DISTINCT [StatusRequisicao] FROM [REQUISICAO];
SELECT DISTINCT [Nome] FROM [CATEGORIA];
SELECT DISTINCT [ItemTipo] FROM [ITEM];

-- Consulta com filtros: 
SELECT * FROM [USUARIO] WHERE [Usuario] = 1;
SELECT * FROM [REQUISICAO] WHERE [StatusRequisicao] = 1;
SELECT * FROM [CATEGORIA] WHERE [Nome] = 'Estudo';
SELECT * FROM [ITEM] WHERE [Preco] > 200;
SELECT * FROM [ITEM] WHERE [Categoria] = 1;
SELECT * FROM [ITEM] WHERE [Item] = 1;
SELECT * FROM [ITEM] WHERE 1=1;
SELECT I.*FROM ITEM I WHERE I.Preco < 100;


-- Consulta com filtros compostos: 
SELECT * FROM [REQUISICAO] WHERE [StatusRequisicao] = 1 AND [UsuarioID] = 5;
SELECT * FROM [REQUISICAO] WHERE [StatusRequisicao] IN (2, 3);
SELECT * FROM [REQUISICAO] WHERE [StatusRequisicao] IN (1, 2, 3);
SELECT * FROM [ITEM] WHERE [Categoria] = 2 AND [Preco] > 100;
SELECT * FROM ITEM WHERE ItemTipo = (SELECT ItemTipo FROM ITEM_TIPO WHERE Item_Tipo = 'Produto');

-- Visualizando campos específicos de uma tabela: 
SELECT [Nome], [Email] FROM [USUARIO]; 

-- Consultas com expressões lógicas em itens: 
SELECT * FROM [USUARIO] WHERE [Nome] = 'Mirella Germano' AND [Email] = 'mgermano@websupply.com.br';
SELECT * FROM [USUARIO] WHERE [Email] = 'mgermano@websupply.com.br' OR [Email] = 'pherculano@websupply.com.br'; 
SELECT * FROM [USUARIO] WHERE NOT ([Nome] = 'Mirella Germano' AND [Email] = 'mgermano@websupply.com.br');
SELECT * FROM [USUARIO] WHERE NOT ( [Email] = 'mgermano@websupply.com.br' OR [Email] = 'pherculano@websupply.com.br'); 

-- Consultas com LIKE: 
SELECT * FROM [ITEM] WHERE [Nome] LIKE '%Capacete%'; 
SELECT * FROM [ITEM] WHERE [Nome] LIKE 'Capacete%' AND [Categoria] = 2; 
SELECT * FROM [REQUISICAO] WHERE [Descricao] LIKE 'S%';
SELECT * FROM [REQUISICAO] WHERE [Descricao] LIKE '%A';

-- Consultas com NOT LIKE: 
SELECT * FROM [ITEM] WHERE [Nome] NOT LIKE '%Capacete%';  
SELECT * FROM [REQUISICAO] WHERE [Descricao] NOT LIKE 'S%';
SELECT * FROM [REQUISICAO] WHERE [Descricao] NOT LIKE '%A';

-- Consulta com GROUP BY SUM: 
SELECT Categoria.Nome AS Categoria, SUM(Item.Preco) AS PrecoTotal
FROM ITEM, CATEGORIA
WHERE Item.Categoria = CATEGORIA.Categoria
GROUP BY Categoria.Nome;

-- Consulta com GROUP BY AVG: 
SELECT ITEM_TIPO.Item_Tipo, AVG(ITEM.Preco) AS PrecoMedio
FROM ITEM, ITEM_TIPO
WHERE ITEM.ItemTipo = ITEM_TIPO.ItemTipo
GROUP BY ITEM_TIPO.Item_Tipo;

-- Consulta com GROUP BY MIN: 
SELECT UsuarioID, MIN(Data_Criacao) AS DataMinima
FROM REQUISICAO
GROUP BY UsuarioID;

-- Consulta com COUNT WHERE E GROUP BY: 
SELECT USUARIO.Nome AS Usuario, COUNT(*) AS RequisicoesAprovadas
FROM REQUISICAO, USUARIO, STATUS_REQUISICAO
WHERE REQUISICAO.UsuarioID = USUARIO.Usuario
AND REQUISICAO.StatusRequisicao = STATUS_REQUISICAO.StatusRequisicao
AND STATUS_REQUISICAO.Status_Requisicao = 'Aprovado'
GROUP BY USUARIO.Nome;

-- Consulta com COUNT WHERE:
SELECT COUNT(*) AS NUMERO_ANALISE FROM REQUISICAO WHERE StatusRequisicao = (SELECT StatusRequisicao FROM STATUS_REQUISICAO WHERE Status_Requisicao = 'Em_analise');

-- Consulta com INNER JOIN:
SELECT R.*, U.Nome AS Solicitante
FROM REQUISICAO R
INNER JOIN USUARIO U ON R.UsuarioID = U.Usuario
WHERE R.StatusRequisicao = (SELECT StatusRequisicao FROM STATUS_REQUISICAO WHERE Status_Requisicao = 'Aprovado');

SELECT R.*, U.Nome AS Solicitante
FROM REQUISICAO R
INNER JOIN USUARIO U ON R.UsuarioID = U.Usuario
WHERE R.StatusRequisicao = (SELECT StatusRequisicao FROM STATUS_REQUISICAO WHERE Status_Requisicao = 'Reprovado');

SELECT R.*, U.Nome AS Solicitante
FROM REQUISICAO R
INNER JOIN USUARIO U ON R.UsuarioID = U.Usuario
WHERE R.StatusRequisicao = (SELECT StatusRequisicao FROM STATUS_REQUISICAO WHERE Status_Requisicao = 'Em_analise');

-- Um único select com todas as tabelas relacionadas a requisição (INNER JOIN):
SELECT 
    REQUISICAO.Requisicao,
    REQUISICAO.Data_Criacao,
    REQUISICAO.Descricao,
    REQUISICAO.Justificativa,
    REQUISICAO.Data_Entrega,
    REQUISICAO.Cidade,
    REQUISICAO.CEP,
    REQUISICAO.Estado,
    REQUISICAO.Endereco,
    REQUISICAO.Numero,
    REQUISICAO.Bairro,
    REQUISICAO.Complemento,
    ITEM_TIPO.Item_Tipo,
    STATUS_REQUISICAO.Status_Requisicao,
    USUARIO.Nome,
    USUARIO_1.Nome,
    USUARIO_2.Nome
FROM 
    REQUISICAO
    INNER JOIN ITEM_TIPO 
		ON REQUISICAO.ItemTipo = ITEM_TIPO.ItemTipo
    INNER JOIN STATUS_REQUISICAO 
		ON REQUISICAO.StatusRequisicao = STATUS_REQUISICAO.StatusRequisicao
    INNER JOIN USUARIO 
		ON REQUISICAO.UsuarioID = USUARIO.Usuario
	INNER JOIN USUARIO USUARIO_1 
		ON REQUISICAO.UsuarioID = USUARIO_1.Usuario
	LEFT JOIN SOLICITANTE_APROVADORES 
		ON USUARIO_1.Usuario = SOLICITANTE_APROVADORES.Solicitante
	LEFT JOIN USUARIO USUARIO_2 
		ON SOLICITANTE_APROVADORES.Aprovador = USUARIO_2.Usuario

-- Função de Data:
SELECT * FROM REQUISICAO WHERE Data_Criacao > '2024-05-01';

SELECT ISDATE('2020-02-29');

-- Função de Texto:
SELECT * FROM REQUISICAO WHERE Descricao LIKE '%segurança%';

SELECT [Nome], LOWER([Nome]) AS NOME_MINUSCULO FROM [USUARIO];



