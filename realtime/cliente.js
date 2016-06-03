/*
* Client to socket.io
*
*/
var cliente = require('socket.io-client')('http://'+process.env.IP+':'+process.env.WS_PORT);

 cliente.on('connect', function(){
   console.log('Conectado');
 });

 cliente.on('event', function(data){
   console.log('evento');
 });

 cliente.on('disconnect', function(){
   console.log('Desconectado');
 });

 module.exports = cliente;
