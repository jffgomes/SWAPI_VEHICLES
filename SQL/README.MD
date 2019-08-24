### Importante

Para melhor indentação e análise do código, recomenda-se copiar o conteúdo (raw) do arquivo sp_GET_SWAPI_VEHICLES.sql e colar numa nova janela do Microsoft SQL Server Management Studio, Notepad++ ou semelhante.

### Dependências

[CURL](https://curl.haxx.se/) - Software livre do tipo 'command line' para executar chamadas em URLs.

[parseJSON](https://github.com/khanhmai/Parse-JSON-String-by-SQL-script/blob/master/ParseJSON-FUNCTION.sql) - Procedure que permite recuperar dados de um JSON em versões anteriores ao SQL 2014.

## Importante
> Antes de executar o código disponibilizado em sql sp_GET_SWAPI_VEHICLES.sql, certifique-se de que os passos abaixo foram concluídos


  - Instale o [CURL](https://curl.haxx.se/)
 Caso a instalação e configuração esteja de acordo, o comando abaixo deverá retornar o seguinte resultado
   ```dos
C:\Users\A-23H3SA>curl --version
curl 7.55.1 (Windows) libcurl/7.55.1 WinSSL
```
  - Crie a procedure [parseJSON](https://github.com/khanhmai/Parse-JSON-String-by-SQL-script/blob/master/ParseJSON-FUNCTION.sql)
  - Em sp_GET_SWAPI_VEHICLES.sql, altere o valor da variável @FILE_PATH (linha 31) para um caminho que esteja de acordo com o seu ambiente de testes. O valor atual é "E:\Shared\RAWDATA\".
  

## Resultado esperado
>Após seguir os passos acima, a execução do código disponibilizado em sp_GET_SWAPI_VEHICLES.sql resulta na criação de uma tabela (SWAPI_VEHICLES) e, posteriormente no preenchimento desta tabela com os valores recuperados de [swapi.co/vehicles](https://swapi.co/api/vehicles/)



#### Exemplo do resultado esperado
![swapi](https://raw.githubusercontent.com/jffgomes/SWAPI_VEHICLES/master/SQL/swapi_sql.png "Resultado da procedure sp_GET_SWAPI_VEHICLES.sql")
