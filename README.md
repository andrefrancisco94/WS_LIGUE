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
• 'Retorno de ocorrencia(s)' - Comando: http://localhost:8400/rest/WSLIGUE/ocurrences/
• 'Retorno de ocorrencia(s) com RECNO' - Comando: http://localhost:8400/rest/WSLIGUE/ocurrences/"Digite o número do RECNO aqui"

Obs: Para pesquisar e retornar a ocorrência com base no RECNO, apenas digitar o número do RECNO após { /ocurrences/ }, por exemplo:
     http://localhost:8400/rest/WSLIGUE/ocurrences/11481, onde o RECNO é o "11481"

O sistema irá retornar nesse modelo:
    [
      {
          "Chave": 03,
          "Ocorrencia":OCORRENCIA 03,
          "RECNO": 11480
      }
    ]
```
