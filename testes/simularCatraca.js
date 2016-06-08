require('dotenv').config();
var net = require('net');

var client = new net.Socket();

client.connect(process.env.NS_PORT, process.env.IP, function() {
  console.log('Conectado');
  client.write("048104004399002/06/1614:53:45E100000000000000S");
});

client.on('data', function(data) {
  resposta = data.toString();
  console.log(resposta);
});

client.on('close', function() {
  console.log('Conexão fechada');
});
