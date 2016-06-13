require('dotenv').config();
var net = require('net');
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');
var NetKeepAlive = require('net-keepalive');
var Catraca = require('./catraca');
var RealTime = require('./realtime/server');

var catracasOnline = [];

//WebSocket - Ao Conectar Emite as catracas online
RealTime.on('connection', function(socket) {
    RealTime.sockets.emit('catracas-online', catracasOnline);
});

// TCP Socket
var server = net.createServer(function(socket) {

    console.log('CONECTADO: ' + socket.remoteAddress + ':' + socket.remotePort);
    var indexCatraca = catracasOnline.indexOf(socket.remoteAddress);
    if (indexCatraca == -1) {
        catracasOnline.push(socket.remoteAddress);
    }
    RealTime.sockets.emit('catracas-online', catracasOnline);

    /*
     * Configurações do Socket
     *
     **/
    socket.setNoDelay(true);
    var habilitar = true; // habilita SO_KEEPALIVE
    var duracaoInicial = 1000; // começa a sondar após 1 segundo de inatividade
    socket.setKeepAlive(habilitar, duracaoInicial); // seta SO_KEEPALIVE e TCP_KEEPIDLE

    var intervaloSonda = 1000; // após duracaoInicial envia sondas a cada 1 segundo
    NetKeepAlive.setKeepAliveInterval(socket, intervaloSonda); // seta TCP_KEEPINTVL

    var maxSondasAntesDrop = 10; // Depois de 10 tentativas a conexão será dropada
    NetKeepAlive.setKeepAliveProbes(socket, maxSondasAntesDrop); // seta TCP_KEEPCNT

    /*
     * Tratamento de Erro do Socket
     *
     **/
    socket.on('error', function(err) {
        console.log(err);
    });


    /*
     * Tratar respostas da catraca
     *
     **/
    var resposta = "";
    socket.on('data', function(data) {
        resposta += data.toString();
        if (resposta.length == 60) {
            console.log(resposta);
            Catraca.montaResposta60(resposta.replace(/\0/g, ''), function(infoAcesso){
              console.log(Catraca.infoAcesso);
              Catraca.verificaCartao(Catraca.infoAcesso.abaTrack, function(statusCartao) {
                  if (statusCartao.bloqueado === true) {
                      socket.write("!NN Bloqueado      A000000.......*");
                  } else if (statusCartao.supervisor === true && statusCartao.bloqueado === false) {
                      if (Catraca.infoAcesso.leitor == "1") { // Se Supervisor colocar no leitor 1
                          socket.write("!OK Supervisor     A000000.......*");
                      } else { // Se Supervisor colocar no leitor 2 = Bloqueia
                          socket.write("!NN Bloqueado      A000000.......*");
                      }
                  } else {
                      if (statusCartao.funcionario === true) { // Funcionário
                          if (Catraca.infoAcesso.leitor != "2") { // Se Funcionário colocar no leitor 1
                                  if (statusCartao.sentidoUltAcesso == 'E') { // Último acesso Entrada = Libera Saída
                                      socket.write("!OK Ate logo!      S000000.......*");
                                  } else if (statusCartao.sentidoUltAcesso == 'S') { // Último acesso Saída = Libera entrada
                                      socket.write("!OK Bem vindo      E000000.......*");
                                  } else { // Sem último acesso = Libera Ambos
                                      socket.write("!OK Bem vindo      A000000.......*");
                                  }
                          } else { // Se Funcionário colocar no leitor 2 = Bloqueia
                              socket.write("!NN Bloqueado      A000000.......*");
                          }
                      } else { // Visitante
                          if (Catraca.infoAcesso.leitor == "1") {
                                  if (statusCartao.sentidoUltAcesso == 'E') {
                                      socket.write("!NN Bloqueado      A000000.......*");
                                  } else {
                                      socket.write("!OK Bem vindo      E000000.......*");
                                  }
                          } else {
                              socket.write("!OK Ate logo!      S000000.......*");
                          }
                      }
                      Catraca.limpaInfoAcesso();
                  }
              });
              resposta = "";
            });
        } else if (resposta.length == 58) {
            console.log(resposta);
            Catraca.montaResposta58(resposta.replace(/\0/g, ''), function(infoAcesso){
              Catraca.gravaAcessoCatraca(Catraca.infoAcesso, function(resultado, nome, foto) {
                  Catraca.infoAcesso.nome = nome;
                  Catraca.infoAcesso.foto = foto;
                  console.log(Catraca.infoAcesso);
                  RealTime.sockets.emit('nova-movimentacao', {
                      infoAcesso: Catraca.infoAcesso
                  });
                  Catraca.limpaInfoAcesso();
              });
              resposta = "";
            });
        }
    });

    socket.on('end', function() {
        console.log('DESCONECTADO: ' + socket.remoteAddress + ':' + socket.remotePort);
        var index = catracasOnline.indexOf(socket.remoteAddress);
        if (index > -1) {
            catracasOnline.splice(index, 1);
        }
        RealTime.sockets.emit('catracas-online', catracasOnline);
    });

    socket.on('error', function(err) {
        console.log("Socket error");
    });

});

server.listen(process.env.NS_PORT, process.env.IP, function() {
    console.log('Servidor Online');
});
