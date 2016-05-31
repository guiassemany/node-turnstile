var net = require('net');

var client = new net.Socket();
//client.connect(1337, '10.5.69.40', function() {
client.connect(2101, '10.5.71.234', function() {
	console.log('Conectado');
});
var resposta = "";
client.on('data', function(data) {

	resposta += data.toString();

	if(resposta.length == 60 ){
		console.log(resposta.toString().trim());
		resposta = "";
		client.destroy();
	}

});

client.on('end', function() {
	console.log('Conexao terminando');
	//var b = new Buffer("XP");
	//client.write(b);
});

client.on('close', function() {
	console.log('Conexão fechada');
});
