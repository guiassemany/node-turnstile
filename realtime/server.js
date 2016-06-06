require('dotenv').config();
var http = require('http');
var server = http.createServer();
var io = require('socket.io').listen(server);
server.listen(process.env.WS_PORT, process.env.IP, function(){
  console.log('Online');
});

var teste = 99;

io.on('connection', function(socket){
  socket.emit('hello', teste);
  socket.on('ola', function(data){
    var gg = data;
    socket.emit('binga', 'teste');
  });
});
