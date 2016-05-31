var net = require('net');

var client = new net.Socket();
client.connect(1337, '10.5.69.40', function() {
//client.connect(2101, '10.5.71.234', function() {
	console.log('Conectado');

	var b = new Buffer('some string or other');
	client.write(b);
});

client.on('data', function(data) {
	console.log('Recebido: ' + data);
	//client.destroy();
});

client.on('close', function() {
	console.log('Conexão fechada');
});
