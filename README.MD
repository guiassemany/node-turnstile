## Controle de catraca com NodeJS

### Em Desenvolvimento! Nada par ver aqui ainda :)

#### String enviada pela catraca ao passar cartão
* !00448104005986101/06/1614:11:06T100000000000000S*
* !0048104005986101/06/1614:11:06T100000000000000S*

#### String enviada pela catraca após o giro
* 048104005986101/06/1614:11:06A100000000000000S

#### Algumas coisinhas importantes
* Liberar Acesso: socket.write("!OK Bem vindo      A000000.......\*");
* Bloquear Acesso: socket.write("!NN Bloqueado      A000000.......\*");
* Transformar o buffer em string: data.toString();
* Tamanho da string: data.toString().length;
* Modo Remoto: socket.write("XP");
* Pipe: socket.pipe(socket);
* KeepAlive: socket.setKeepAlive(true, 1000);
* Trim para capturar resposta corretamente: resposta.toString().trim();
* Destruir o client: client.destroy();

#### Comandos Servidor
* forever start server.js
* forever -o out.log -e err.log server.js
* tail -f /root/.forever/arquivo.log
* forever list
* forever restart server.js
* forever stop server.js

#### Passo-a-passo desenvolvimento Windows
* Clonar o projeto `git clone http://ubuntu-srv-gitlab.gsaa.saa.sp.gov.br/gstic/node-turnstile.git`
* Acessar o diretório do projeto `cd node-turnstile`
* Remover do package.json a depedência "net-keepalive"
* Executar o comando `npm install`
* Readicionar no package.json a dependência "net-keepalive"
* Se for subir o servidor, comentar as linhas do "Net Keepalive"
* Criar o arquivo `.env` a partir do .env.example
* Editar os parâmetros do arquivo `.env`
* Para subir o servidor, execute o comando `node server.js`
* Na interface da catraca, apontar para o IP do novo servidor (Serial Ports -> Port 1-> Ip Address)
* Após a execução do item acima, clicar em `Reboot` na mesma interface
* Ao terminar os trabalhos, não esquecer de descomentar o "net keepalive" e dar um push para o servidor

#### Onde comentar o net-keepalive
```javascript
require('dotenv').config();
var net = require('net');
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');
//var NetKeepAlive = require('net-keepalive');
var Catraca = require('./catraca');
var RealTime = require('./realtime/server');
var Cartao = require('./cartao');
...
  /*
   * Configurações do Socket
   *
   **/
  socket.setNoDelay(true);
  var habilitar = true; // habilita SO_KEEPALIVE
  var duracaoInicial = 1000; // começa a sondar após 1 segundo de inatividade
  socket.setKeepAlive(habilitar, duracaoInicial); // seta SO_KEEPALIVE e TCP_KEEPIDLE

  var intervaloSonda = 1000; // após duracaoInicial envia sondas a cada 1 segundo
  //NetKeepAlive.setKeepAliveInterval(socket, intervaloSonda); // seta TCP_KEEPINTVL

  var maxSondasAntesDrop = 10; // Depois de 10 tentativas a conexão será dropada
  //NetKeepAlive.setKeepAliveProbes(socket, maxSondasAntesDrop); // seta TCP_KEEPCNT

```
