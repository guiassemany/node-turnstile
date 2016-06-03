/*
* Client to socket.io
*
*/
var cliente = require('socket.io-client')('http://10.5.69.45:5001');

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
