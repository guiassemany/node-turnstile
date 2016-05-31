var net = require('net');
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');

var server = net.createServer(function(socket) {

  console.log('CONECTADO: ' + socket.remoteAddress +':'+ socket.remotePort);

  socket.write("Entrou!");
	//socket.pipe(socket);

  socket.on('error', function(err) {
    console.log(err);
  });

  socket.on('data', function(data) {

    a = data.toString('ascii');
    b = decoder.write(data);
    c = data.toString('utf8');
    console.log("Dados: " + a);
    console.log("Dados: " + b);
    console.log("Dados: " + c);

    socket.write("Envio de volta");

  });

  socket.on('end', function() {
    console.log('DESCONECTADO: ' + socket.remoteAddress +':'+ socket.remotePort);
  });

});

server.listen(1337, '10.5.69.40');
