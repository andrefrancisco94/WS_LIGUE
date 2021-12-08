# WS_LIGUE
### LIGUE ADVPL Developer Test (WEBSERVICE REST)

---
Esse projeto foi desenvolvido com o objetivo de participar do processo seletivo da LIGUE!

---
### Desenvolvedor:
+55 (44) 9.9879-0822 - André Francisco (Desenvolvedor Oficial)

---
### Modelos de chamadas do WEBSERVICE REST

## Method "GET"

```bash
• 'Retorno de ocorrencia(s)' - Comando: http://localhost:8400/rest/WSLIGUE/ocurrences/ (Não precisa adicionar nenhuma outra informação)
• 'Retorno de ocorrencia(s) com RECNO' - Comando: http://localhost:8400/rest/WSLIGUE/ocurrences/"Digite o número do RECNO aqui"

Obs: Para pesquisar e retornar a ocorrência com base no RECNO, apenas digitar o número do RECNO após { /ocurrences/ }, por exemplo:
     http://localhost:8400/rest/WSLIGUE/ocurrences/11481, onde o RECNO é o "11481"

O sistema irá retornar nesse modelo em JSON:

    [
      {
          "Chave": 03,
          "Ocorrencia":OCORRENCIA 03,
          "RECNO": 11480
      }
    ]
    
```


## Method "POST"
```bash

• 'Adiciona uma nova ocorrencia' - Comando: http://localhost:8400/rest/WSLIGUE/ocurrences/

Obs: Para adicionar uma nova ocorrencia, necessita o preenchimento das KEY's (variáveis) abaixo:
     -> CHAVE            "Representa a X5_CHAVE"
     -> OCORRENPTB       "Representa o campo X5_DESCRI"
     -> OCORRENSPA       "Representa o campo X5_DESCRISPA"
     -> OCORRENENG       "Representa o campo X5_DESCRIENG"

O sistema irá retornar nesse modelo em JSON:
    [{"Chave":02,"Ocorrencia":DESCRICAO,"RECNO":11490}]
    
```


## Method "PUT"
```bash

• 'Atualiza os dados de ocorrencia(s)' - Comando: http://localhost:8400/rest/WSLIGUE/ocurrences/"Digite o número do RECNO aqui"

Obs: Para atualizar uma ocorrência já existente, necessita o preenchimento do nuúmero de recno no comando e também das KEY's (variáveis) abaixo:
     -> CHAVE            "Representa a X5_CHAVE"
     -> OCORRENPTB       "Representa o campo X5_DESCRI"
     -> OCORRENSPA       "Representa o campo X5_DESCRISPA"
     -> OCORRENENG       "Representa o campo X5_DESCRIENG"

O sistema irá retornar nesse modelo em JSON:

    [{"Chave":02,"Ocorrencia":DESCRICAO,"RECNO":11480}]
    
```


## Method "DELETE"
```bash

• 'Delela o registro de uma ocorrencia' - Comando: http://localhost:8400/rest/WSLIGUE/ocurrences/"Digite o número do RECNO aqui"

Obs: Para atualizar uma ocorrência já existente, necessita o preenchimento do nuúmero de recno no comando e também das KEY's (variáveis) abaixo:
     -> CHAVE            "Representa a X5_CHAVE"
     -> OCORRENPTB       "Representa o campo X5_DESCRI"
     -> OCORRENSPA       "Representa o campo X5_DESCRISPA"
     -> OCORRENENG       "Representa o campo X5_DESCRIENG"

O sistema irá retornar nesse modelo em JSON:

    [{"Chave":02,"Ocorrencia":DESCRICAO,"RECNO":11480,"Situacao":REGISTRO DELETADO COM SUCESSO!}]
    
```


