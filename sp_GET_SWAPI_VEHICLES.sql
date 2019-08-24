DECLARE @CURL_CMD		    VARCHAR	(8000)
DECLARE @OPENROWSET_CMD NVARCHAR(4000)
DECLARE @FILE_PATH		  VARCHAR	(8000)
DECLARE @FILENAME		    VARCHAR	(8000)
DECLARE @JSON			      NVARCHAR(MAX)


/****************
SP_NAME:		                      sp_GET_SWAPI_VEHICLES
CREATION DATE:	                  13:39 PM 8/24/2019

OBJECTIVE:								        Recupera todos os veículos disponibilizados na API https://swapi.co/api/vehicles/
										              cria a tabela SWAPI_VEHICLES caso esta já não exista e insere os valores retornados
										              pela API, caso estes já não existam na tabela.

DEPENDENCIES:	CURL, parseJSON

MORE INFO:
CURL		- https://curl.haxx.se/ -	Software livre útil para recuperar informações de URLs, 
										              também pode ser usado para chamadas de API e envio de 
										              mensagens em outros protocolos

parseJSON	-					              Procedure criada para versões anteriores do SQL Server 2014
										              a procedure permite que o usuário recupere dados de um JSON
										              em uma tabela para leitura.

										              Para SQL 2014 em diante, recomenda-se a utilização das funções
										              JSON nativas: 
										              https://docs.microsoft.com/en-us/sql/relational-databases/json/json-data-sql-server?view=sql-server-2017
****************/

SET @FILE_PATH	= 'E:\Shared\RAWDATA\'
SET @FILENAME	= 'veichles.json'

SET @CURL_CMD	= 'curl "https://swapi.co/api/vehicles/" -H "accept: application/json" --output '+@FILE_PATH + @FILENAME+''
EXEC MASTER..xp_cmdshell @CURL_CMD, no_output

SET @OPENROWSET_CMD = 'SELECT * FROM OPENROWSET(BULK '''+@FILE_PATH + @FILENAME+''', SINGLE_CLOB) AS j'

CREATE TABLE	#TEMP (data nvarchar(MAX))
INSERT INTO		#TEMP EXEC MASTER..sp_executesql @OPENROWSET_CMD
SET				    @JSON =(SELECT * FROM #TEMP)
DROP TABLE		#TEMP

IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='SWAPI_VEHICLES' AND XTYPE='U')
    CREATE TABLE SWAPI_VEHICLES (
     NAME					          VARCHAR(100) NOT NULL
		,MODEL					        VARCHAR(200) NOT NULL
		,cost_in_credits		    VARCHAR(100) NOT NULL
		,length					        VARCHAR(20) NOT NULL
		,max_atmosphering_speed VARCHAR(100) NOT NULL
		,crew					          VARCHAR(3) NOT NULL
		,passengers				      VARCHAR(3) NOT NULL
		,cargo_capacity			    VARCHAR(50) NOT NULL
		,consumables			      VARCHAR(200) NOT NULL
		,vehicle_class			    VARCHAR(200) NOT NULL
		,url					          VARCHAR(100) NOT NULL
    )

INSERT INTO SWAPI_VEHICLES

SELECT
      MAX(CASE WHEN NAME='NAME'					          THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS [NAME]
     ,MAX(CASE WHEN NAME='MODEL'					        THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS [MODEL]
	   ,MAX(CASE WHEN NAME='cost_in_credits'		    THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS cost_in_credits
	   ,MAX(CASE WHEN NAME='length'					        THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS length
	   ,MAX(CASE WHEN NAME='max_atmosphering_speed' THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS max_atmosphering_speed
	   ,MAX(CASE WHEN NAME='crew'					          THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS crew
	   ,MAX(CASE WHEN NAME='passengers'				      THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS passengers
	   ,MAX(CASE WHEN NAME='cargo_capacity'			    THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS cargo_capacity
	   ,MAX(CASE WHEN NAME='consumables'			      THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS consumables
	   ,MAX(CASE WHEN NAME='vehicle_class'			    THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS vehicle_class
	   ,MAX(CASE WHEN NAME='url'					          THEN CONVERT(VARCHAR(50),STRINGVALUE) ELSE '' END) AS url

	   FROM parseJSON 
(
       @JSON
)
WHERE ValueType = 'string' AND NAME <> '' AND NOT EXISTS (select * from SWAPI_VEHICLES)
GROUP BY parent_ID HAVING COUNT(parent_ID) > 1

SELECT * FROM SWAPI_VEHICLES 
