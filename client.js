var net = require('net');
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');
var mysql = require('mysql');
var moment = require('moment');
var NetKeepAlive = require('net-keepalive');

var connection = mysql.createConnection({
  host     : '10.5.70.129',
  user     : 'root',
  password : 'grk1957',
  database : 'cap'
});

var client = new net.Socket();
client.connect(2101, '10.5.71.231', function() {
	console.log('Conectado');
});

//IMPORTANT: KeepAlive must be enabled for this to work
  client.setKeepAlive(true, 1000)

  // Set TCP_KEEPINTVL for this specific socket
  NetKeepAlive.setKeepAliveInterval(client, 1000)

  // and TCP_KEEPCNT
  NetKeepAlive.setKeepAliveProbes(client, 1)

var resposta = "";

client.on('data', function(data) {

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
		var dataHora = moment(dataAcesso + ' ' + hora, "DD/MM/YY HH:mm:ss").format("YYYY-MM-DD HH:mm:ss");

		//Verifica se o cartão está desbloqueado
		var queryBlock = "SELECT situacao FROM tbl_cartao WHERE abaTrack = '"+abaTrack+"'";
		connection.query(queryBlock, function(err, rows, fields) {
			if (!err){
				if(rows[0].situacao != 'I'){
					var query = "INSERT INTO tbl_acessocatraca (abaTrack, sentido, catraca, dataHora ) VALUES ('"+abaTrack+"', '"+sentido+"', '4', '"+dataHora+"')";
					connection.query(query, function(err, rows, fields) {
						if (!err){
							console.log('Inserido no BD');
						}
						else {
							console.log('Erro ao inserir.');
						}
					});
					console.log('bemvindo');
					client.write("!OK Bem vindo      A000000.......*");
					client.end();
				}else{
					console.log('block');
					client.write("!NN Bloqueado      A000000.......*");
					client.end();
				}
			}
			else{
				console.log('Erro ao consultar.');

			}
		});

		resposta = "";
		//client.destroy();
	}

});

client.on('close', function() {
	console.log('Conexão fechada');
});
