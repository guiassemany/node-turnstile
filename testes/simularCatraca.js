var net = require('net');

var client = new net.Socket();

client.connect(5000, '10.5.69.59', function() {
	console.log('Conectado');
  client.write("!0048104005986131/05/1616:41:10T100000000000000S");
});

client.on('data', function(data) {
	resposta = data.toString();
  console.log(resposta);
});

client.on('close', function() {
	console.log('Conexão fechada');
});
