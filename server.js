var net = require('net');
var StringDecoder = require('string_decoder').StringDecoder;
var decoder = new StringDecoder('utf8');
var mysql = require('mysql');

var mysql      = require('mysql');
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
        connection.connect();
        connection.query("INSERT INTO teste (catraca) VALUES ('"+resposta.toString().trim()+"')", function(err, rows, fields) {
          if (!err)
            console.log('Inserido no BD');
          else
            console.log('Erro ao inserir.');
        });
        connection.end();
    		resposta = "";
    	}
      //var b = new Buffer("XP");
    	//socket.write(b);
  });

  socket.on('end', function() {
    console.log('DESCONECTADO: ' + socket.remoteAddress +':'+ socket.remotePort);
  });

});

server.listen(5000, '10.5.69.40');
