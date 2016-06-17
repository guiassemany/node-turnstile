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

module.exports = new Cartao();
