http = require 'http'

server = http.createServer (req, res) ->
    console.log req.method, req.url
    data = 'I like cats\n'
    res.writeHead 200,
        'Content-Type':     'text/plain'
        'Content-Length':   data.length
    res.end data

io = require 'socket.io'
io.sockets.on 'connection', (socket) ->
    console.log('Initializing Socket');


server.listen 8000
