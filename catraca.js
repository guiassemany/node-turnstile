'use strict';

var moment = require('moment');
var mysql = require('mysql');

var connection = mysql.createConnection({
  host     : process.env.DB_HOST,
  user     : process.env.DB_USER,
  password : process.env.DB_PASS,
  database : process.env.DB_DATABASE
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
  this.infoAcesso.leitora           = str.substring(32, 33);
  this.infoAcesso.cartaoSupervisor  = str.substring(33, 49);
  this.infoAcesso.dataHora          = moment(this.infoAcesso.dataAcesso + ' ' + this.infoAcesso.hora, "DD/MM/YY HH:mm:ss").format("YYYY-MM-DD HH:mm:ss");
}

Catraca.prototype.montaResposta58 = function(resposta){
  var str = resposta.toString().trim();
  this.infoAcesso.abaTrack          = "0" + str.substring(0, 13);
  this.infoAcesso.dataAcesso        = str.substring(13, 21);
  this.infoAcesso.hora              = str.substring(21, 29);
  this.infoAcesso.sentido           = str.substring(29, 30);
  this.infoAcesso.leitora           = str.substring(30, 31);
  this.infoAcesso.cartaoSupervisor  = str.substring(31, 47);
  this.infoAcesso.dataHora          = moment(this.infoAcesso.dataAcesso + ' ' + this.infoAcesso.hora, "DD/MM/YY HH:mm:ss").format("YYYY-MM-DD HH:mm:ss");
}

Catraca.prototype.verificaCartao = function(abaTrack, callback){
  var statusCartao = {
    bloqueado: null,
    funcionario: null
  };
  var query = "SELECT situacao, codigoTipoCartao FROM tbl_cartao WHERE abaTrack = ?";
  connection.query(query, abaTrack, function(err, rows, fields) {
    if (!err){
      if(rows[0].situacao == 'I'){
        statusCartao.bloqueado = true;
      }else{
        statusCartao.bloqueado = false;
      }
      if(rows[0].codigoTipoCartao == '1'){
        statusCartao.funcionario = true;
      }else{
        statusCartao.funcionario = false;
      }
    }else{
      statusCartao.bloqueado = null;
      statusCartao.funcionario = null;
    }
    callback(statusCartao);
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
