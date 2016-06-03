require('dotenv').config();
var net = require('net');
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');
var NetKeepAlive = require('net-keepalive');
var Catraca = require('./catraca');

var server = net.createServer(function(socket) {

  console.log('CONECTADO: ' + socket.remoteAddress +':'+ socket.remotePort);

  /*
  * Configurações do Socket
  *
  **/
  socket.setNoDelay(true);
  var habilitar = true;                           // habilita SO_KEEPALIVE
  var duracaoInicial = 1000;                      // começa a sondar após 1 segundo de inatividade
  socket.setKeepAlive(habilitar, duracaoInicial); // seta SO_KEEPALIVE e TCP_KEEPIDLE

  var intervaloSonda = 1000;  // após duracaoInicial envia sondas a cada 1 segundo
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
    	if(resposta.length == 60 ){
        console.log(resposta);
        Catraca.montaResposta60(resposta.replace(/\0/g, ''));
        console.log(Catraca.infoAcesso);
        Catraca.verificaCartao(Catraca.infoAcesso.abaTrack, function(statusCartao){
          if(statusCartao.bloqueado === true){
            socket.write("!NN Bloqueado      A000000.......*");
          }else{
            if(statusCartao.funcionario === true){
              socket.write("!OK Bem vindo      A000000.......*");
            }else{
              if(Catraca.infoAcesso.leitor == "1"){
                  socket.write("!OK Bem vindo      E000000.......*");
              }else{
                  socket.write("!OK Bem vindo      S000000.......*");
              }
            }
            Catraca.limpaInfoAcesso();
          }
        });
        resposta = "";
    	}else if (resposta.length == 58) {
        console.log(resposta);
        Catraca.montaResposta58(resposta.replace(/\0/g, ''));
        console.log(Catraca.infoAcesso);
        Catraca.gravaAcessoCatraca(Catraca.infoAcesso, function(resultado){
          Catraca.limpaInfoAcesso();
        });
        resposta = "";
    	}
  });

  socket.on('end', function() {
    console.log('DESCONECTADO: ' + socket.remoteAddress +':'+ socket.remotePort);
  });

});

server.listen(process.env.PORT, process.env.IP, function(){
  console.log('Servidor Online');
});
