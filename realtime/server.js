require('dotenv').config();
var http = require('http'),
    fs = require('fs'),
    index = fs.readFileSync(__dirname + '/views/index.html');

var app = http.createServer(function(req, res) {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end(index);
});

// Socket.io server
var io = require('socket.io').listen(app);

io.on('connection', function(socket) {
    socket.emit('bemvindo', { message: 'Sistema de Catraca em tempo Real', id: socket.id });

    socket.on('nova-movimentacao', function(data){
        console.log(data);
        socket.broadcast.emit("nova-movimentacao", data);
    });

    socket.on('confirma-conexao', function(data){
        socket.broadcast.emit("confirma-conexao", 'Conectado');
    });

});

app.listen(process.env.WS_PORT, process.env.IP, function(){
  console.log('WebSocket OnLine!');
});
