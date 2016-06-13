var Catraca = require('../catraca');

Catraca.montaResposta60("!0048104005986101/06/1614:11:06T100000000000000S*");

Catraca.verificaCartao(Catraca.infoAcesso.abaTrack, function(resultado) {
    console.log(resultado);
    Catraca.gravaAcessoCatraca(Catraca.infoAcesso, function(resultado) {
        console.log(resultado);
    });
});
