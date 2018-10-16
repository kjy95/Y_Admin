var fs    = require("fs") ; 

var express = require('express')
    ,app = express();

app.listen(3303, function(){
    console.log("server start.");
})

app.get('/', function(req, res){
    fs.resFile('/index', function(error, data){
        res.writeHead(200, {'content-Type':'text/html'});
        res.end(data);
    });
});