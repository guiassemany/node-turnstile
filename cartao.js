require('dotenv').config();
var moment = require('moment');
var mysql = require('mysql');

var connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_DATABASE
});

var Cartao = function() {};

Cartao.prototype.relacionaNumero = function(infoAcesso) {
  connection.query("SELECT max(numero) + 1 as numero FROM tbl_cartao", function(err, rows, fields){
    if (!err) {
      var proximoNum = rows[0].numero;
      var query = "UPDATE tbl_cartao SET numero = ? WHERE abaTrack = ?";
      connection.query(query, [proximoNum, infoAcesso.abaTrack], function(err, rows, fields) {
        if (!err) {
          console.log('Cartão de número '+proximoNum+' associado.');
        } else {
          console.log(err);
          console.log('Cartão não associado.');
        }
      });
    }
  });
};

Cartao.prototype.insereCartao = function(infoAcesso, callback) {
  connection.query("INSERT INTO cap.tbl_cartao (codigoTipoCartao, situacao, abaTrack) VALUES (1, 'I', ?)", infoAcesso.abaTrack, function(err, rows, fields) {
    if(!err) {
      console.log('Cartão cadastrado.');
      callback(true);
    }
    else {
      console.log(err);
      console.log('Cartão não cadastrado.');
      callback(true);
    }
  });
};

Cartao.prototype.relacionaCartaoSEM = function(infoAcesso, callback) {
  connection.query("SELECT codigoCartao FROM cap.tbl_cartao WHERE abaTrack = ?", infoAcesso.abaTrack, function(err, rows, fields) {
    if(!err) {
      connection.query("UPDATE cap.tbl_pessoa SET codigoCartaoOficial = ? WHERE codigoCartaoOficial IS NULL AND codigoUnidadePessoa = 2079 ORDER BY nome ASC LIMIT 1", rows[0].codigoCartao, function(err, rows, fields) {
        if(err) { console.log("UPDATE falhou."); callback(false); }
        console.log("Cartão relacionado");
        callback(true);
      });
    }
    else {
      console.log(err);
      console.log('Cartão SEM não relacionado');
      callback(true);
    }
  });
};

Cartao.prototype.relacionaCartaoSAA = function(infoAcesso, callback) {
  connection.query("SELECT codigoCartao FROM cap.tbl_cartao WHERE abaTrack = ?", infoAcesso.abaTrack, function(err, rows, fields) {
    if(!err) {
      connection.query("UPDATE cap.tbl_pessoa SET codigoCartaoOficial = ? WHERE foto IS NOT NULL AND codigoTipoPessoa NOT IN(2, 5) AND codigoUnidadePessoa <> 2079 ORDER BY nome ASC LIMIT 1", rows[0].codigoCartao, function(err, rows, fields) {
        if(err) { console.log("UPDATE falhou."); callback(false); }
        console.log("Cartão relacionado");
        callback(true);
      });
    }
    else {
      console.log(err);
      console.log('Cartão SAA não relacionado');
      callback(true);
    }
  });
};

module.exports = new Cartao();
