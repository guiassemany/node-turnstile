require('dotenv').config();
var net = require('net');

var client = new net.Socket();

client.connect(5000, process.env.LOCAL, function() {
	console.log('Conectado');
  client.write("048104005817202/06/1614:33:45E100000000000000S");
});

client.on('data', function(data) {
	resposta = data.toString();
  console.log(resposta);
});

client.on('close', function() {
	console.log('Conexão fechada');
});
