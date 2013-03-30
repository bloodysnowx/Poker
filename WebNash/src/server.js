var portNum = process.env.PORT || 3000;
var http = require('http');
var url = require("url");

function start(route, handle) {
    function onRequest(request, response) {
        var pathName = url.parse(request.url).pathname;
        var postData = "";

        request.setEncoding("utf8");

        request.addListener("data", function(postDataChunk) {
            postData += postDataChunk;
        });

        request.addListener("end", function() {
            route(handle, pathName, response, postData);
        });
    }

    http.createServer(onRequest).listen(portNum);
 
    console.log('Server running at' + portNum + '/');
}

exports.start = start;
