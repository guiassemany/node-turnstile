'use strict';

var moment = require('moment');
var mysql = require('mysql');

var connection = mysql.createConnection({
  host     : '10.5.70.129',
  user     : 'root',
  password : 'grk1957',
  database : 'cap'
});

// Catraca
// ====================

var Catraca = function() {}

Catraca.prototype.infoAcesso = {
  abaTrack: null,
  dataAcesso: null,
  hora: null,
  sentido: null,
  leitora: null,
  cartaoSupervisor: null,
  dataHora: null,
};

Catraca.prototype.montaResposta60 = function(resposta){
  var str = resposta.toString().trim();
  this.infoAcesso.abaTrack          = str.substring(1, 15);
  this.infoAcesso.dataAcesso        = str.substring(15, 23);
  this.infoAcesso.hora              = str.substring(23, 31);
  this.infoAcesso.sentido           = str.substring(31, 32);
  this.infoAcesso.leitora           = str.substring(33, 34);
  this.infoAcesso.cartaoSupervisor  = str.substring(34, 49);
  this.infoAcesso.dataHora          = moment(this.infoAcesso.dataAcesso + ' ' + this.infoAcesso.hora, "DD/MM/YY HH:mm:ss").format("YYYY-MM-DD HH:mm:ss");
}

Catraca.prototype.cartaoDesbloqueado = function(abaTrack, callback){
  var query = "SELECT situacao FROM tbl_cartao WHERE abaTrack = ?";
  connection.query(query, abaTrack, function(err, rows, fields) {
    if (!err){
      if(rows[0].situacao == 'I'){
        callback(false);
      }else{
        callback(true);
      }
    }else{
      callback('Error ao Consultar');
    }
  });
}

Catraca.prototype.gravaAcessoCatraca = function(infoAcesso, callback){
  var query = "INSERT INTO tbl_acessocatraca (abaTrack, sentido, catraca, dataHora ) VALUES (?, ?, ?, ?)";
  connection.query(query,[infoAcesso.abaTrack, infoAcesso.sentido, '4', infoAcesso.dataHora],function(err, rows, fields) {
    if (!err){
      console.log('Inserido no BD');
      callback(true);
    }
    else {
      console.log('Erro ao inserir.');
      callback(false);
    }
  });
}

Catraca.prototype.limpaInfoAcesso = function(){
  this.infoAcesso = {
    abaTrack: null,
    dataAcesso: null,
    hora: null,
    sentido: null,
    leitora: null,
    cartaoSupervisor: null,
    dataHora: null,
  };
}

module.exports = new Catraca();
