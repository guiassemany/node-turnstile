'use strict';

var moment = require('moment');
var mysql = require('mysql');

var connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_DATABASE
});

var queues = require('mysql-queues');
queues(connection, true);
var q = connection.createQueue();

// Catraca
// ====================

var Catraca = function() {}

Catraca.prototype.infoAcesso = {
    abaTrack: null,
    dataAcesso: null,
    hora: null,
    sentido: null,
    leitor: null,
    cartaoSupervisor: null,
    dataHora: null,
    nome: null,
    foto: null,
};

Catraca.prototype.montaResposta60 = function(resposta) {
    var str = resposta.toString().trim();
    this.infoAcesso.abaTrack = str.substring(1, 15);
    this.infoAcesso.dataAcesso = str.substring(15, 23);
    this.infoAcesso.hora = str.substring(23, 31);
    this.infoAcesso.sentido = str.substring(31, 32);
    this.infoAcesso.leitor = str.substring(32, 33);
    this.infoAcesso.cartaoSupervisor = str.substring(33, 49);
    this.infoAcesso.dataHora = moment(this.infoAcesso.dataAcesso + ' ' + this.infoAcesso.hora, "DD/MM/YY HH:mm:ss").format("YYYY-MM-DD HH:mm:ss");
}

Catraca.prototype.montaResposta58 = function(resposta) {
    var str = resposta.toString().trim();
    this.infoAcesso.abaTrack = "0" + str.substring(0, 13);
    this.infoAcesso.dataAcesso = str.substring(13, 21);
    this.infoAcesso.hora = str.substring(21, 29);
    this.infoAcesso.sentido = str.substring(29, 30);
    this.infoAcesso.leitor = str.substring(30, 31);
    this.infoAcesso.cartaoSupervisor = str.substring(31, 47);
    this.infoAcesso.dataHora = moment(this.infoAcesso.dataAcesso + ' ' + this.infoAcesso.hora, "DD/MM/YY HH:mm:ss").format("YYYY-MM-DD HH:mm:ss");
}

Catraca.prototype.verificaCartao = function(abaTrack, callback) {
    var statusCartao = {
        bloqueado: null,
        funcionario: null,
        supervisor: null
    };
    var query = "SELECT situacao, codigoTipoCartao FROM tbl_cartao WHERE abaTrack = ?";
    q.query(query, abaTrack, function(err, rows, fields) {
        if (!err) {
            if (rows[0].situacao == 'I' || rows[0].situacao == 'E') {
                statusCartao.bloqueado = true;
            } else {
                statusCartao.bloqueado = false;
            }
            if (rows[0].codigoTipoCartao == '1') {
                statusCartao.funcionario = true;
            } else {
                statusCartao.funcionario = false;
            }
            if (rows[0].codigoTipoCartao == '3') {
                statusCartao.supervisor = true;
            } else {
                statusCartao.supervisor = false;
            }
        } else {
            statusCartao.bloqueado = null;
            statusCartao.funcionario = null;
            statusCartao.supervisor = null;
        }
        callback(statusCartao);
    });
}

Catraca.prototype.gravaAcessoCatraca = function(infoAcesso, callback) {
    this.pegaDonoCartao(infoAcesso.abaTrack, function(codigoPessoa, nome, foto) {
        var query = "INSERT INTO tbl_acessocatraca (abaTrack, codigoPessoa, sentido, catraca, dataHora ) VALUES (?, ?, ?, ?, ?)";
        q.query(query, [infoAcesso.abaTrack, codigoPessoa, infoAcesso.sentido, '4', infoAcesso.dataHora], function(err, rows, fields) {
            if (!err) {
                console.log('Inserido no BD');
                callback(true, nome, foto);
            } else {
                console.log(err);
                console.log('Erro ao inserir.');
                callback(false);
            }
        });
    });
}

Catraca.prototype.pegaDonoCartao = function(abaTrack, callback) {
    var query = "SELECT codigoPessoa, nome, foto FROM tbl_pessoa pes INNER JOIN tbl_cartao car ON car.codigoCartao = pes.codigoCartao OR car.codigoCartao = pes.codigoCartaoOficial OR car.codigoCartao = pes.codigoCartaoSupervisor WHERE car.abaTrack = ?";
    q.query(query, abaTrack, function(err, rows, fields) {
        if (!err) {
            if (typeof rows[0] !== 'undefined') {
                callback(rows[0].codigoPessoa, rows[0].nome, rows[0].foto);
            } else {
                callback(null);
            }
        } else {
            console.log(err);
            console.log('Erro ao consultar código da pessoa.');
        }
    });
}

Catraca.prototype.verificaUltimoAcesso = function(abaTrack, callback) {
    var query = "SELECT sentido FROM tbl_acessocatraca WHERE abaTrack = ? ORDER BY codigoAcessoCatraca DESC LIMIT 1";
    q.query(query, abaTrack, function(err, rows, fields) {
        if (!err) {
            if (typeof rows[0] !== 'undefined') {
                callback(rows[0].sentido);
            } else {
                callback(null);
            }
        } else {
            console.log(err);
            console.log('Erro ao consultar código da pessoa.');
        }
    });
}

Catraca.prototype.limpaInfoAcesso = function() {
    this.infoAcesso = {
        abaTrack: null,
        dataAcesso: null,
        hora: null,
        sentido: null,
        leitor: null,
        cartaoSupervisor: null,
        dataHora: null,
        nome: null,
        foto: null,
    };
}

module.exports = new Catraca();
