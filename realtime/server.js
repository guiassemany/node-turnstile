require('dotenv').config();
var http = require('http');
var server = http.createServer();
var io = require('socket.io').listen(server);
server.listen(process.env.WS_PORT, process.env.IP, function(){
  console.log('Módulo Tempo real Online');
});

io.on('connection', function(socket){
  socket.on('conectado', function(data){
    console.log(data);
  });
});

module.exports = io;
