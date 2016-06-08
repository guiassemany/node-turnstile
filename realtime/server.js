require('dotenv').config();
var http = require('http');
var server = http.createServer();
var io = require('socket.io').listen(server);
server.listen(process.env.WS_PORT, process.env.IP, function(){
  console.log('Módulo Tempo real Online');
});

module.exports = io;
