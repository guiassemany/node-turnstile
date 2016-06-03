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
