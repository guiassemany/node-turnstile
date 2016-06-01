var net = require('net');
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');
var mysql = require('mysql');
var moment = require('moment');

var connection = mysql.createConnection({
  host     : '10.5.70.129',
  user     : 'root',
  password : 'grk1957',
  database : 'cap'
});

var server = net.createServer(function(socket) {

  console.log('CONECTADO: ' + socket.remoteAddress +':'+ socket.remotePort);

  //socket.write("XP");
	//socket.pipe(socket);

  socket.on('error', function(err) {
    console.log(err);
  });

  var resposta = "";
  socket.on('data', function(data) {
    	resposta += data.toString();
    	if(resposta.length == 60 ){
    		console.log(resposta.toString().trim());

        //Pega todos os dados da resposta da catraca
        var str = resposta.toString().trim();
        var abaTrack = str.substring(1, 15);
        var dataAcesso = str.substring(15, 23);
        var hora = str.substring(23, 31);
        var sentido = str.substring(31, 32);
        var leitora = str.substring(33, 34);
        var cartaoSupervisor = str.substring(34, 49);

        //Formata data e hora
        var dataHora = moment(data + ' ' + hora, "DD/MM/YY HH:mm:ss").format("YYYY-MM-DD HH:mm:ss");

        connection.connect();
        connection.query("INSERT INTO tbl_acessocatraca (abaTrack, sentido, catraca, dataHora ) VALUES ('"+abaTrack+"', '"+sentido+"', '4', '"+dataHora+"')", function(err, rows, fields) {
          if (!err)
            console.log('Inserido no BD');
          else
            console.log('Erro ao inserir.');
        });
        connection.end();
    		resposta = "";
    	}

    	//socket.write("OK---ENTRADA OK---E000000");
      socket.write("!OK Bem vindo      A000000.......*");

  });

  socket.on('end', function() {
    console.log('DESCONECTADO: ' + socket.remoteAddress +':'+ socket.remotePort);
  });

});

server.listen(5000, '10.5.68.250');
