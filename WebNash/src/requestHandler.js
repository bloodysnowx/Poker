var exec = require("child_process").exec;
var fs = require('fs');
var querystring = require("querystring");
var webnash = require('./webnash');

function main(response, postData) {
    console.log("Request handler 'main' was called.");
    response.writeHead(200, {"Content-Type": "text/html"});
    response.write(fs.readFileSync('./main.html' ));
    response.end();
}

function postHand(response, postData) {
    console.log("Request handler 'postHand' was called.");

    // response.write('Structure = ' + querystring.parse(postData).Structure);
    // response.write('Content = ' + querystring.parse(postData).Content);
    try {
        console.log(querystring.parse(postData).submit);
        var url = webnash.main(querystring.parse(postData).Structure, querystring.parse(postData).Content, querystring.parse(postData).submit === "Next Hand");
        // response.writeHead(200, {"Content-Type": "text/plain"});
        response.writeHead(301, {'Location':url, 'Expires': (new Date).toGMTString()});
    } catch (error) {
        console.log(error);
        response.writeHead(500, {"Content-Type": "text/plain"});
        response.write("500 Internal Server Error");
    } finally {
        response.end();
    }
}

exports.main = main;
exports.postHand = postHand;
