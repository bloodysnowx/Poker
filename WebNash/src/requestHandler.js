var exec = require("child_process").exec;
var fs = require('fs');

function main(response) {
    console.log("Request handler 'main' was called.");
    response.writeHead(200, {"Content-Type": "text/html"});
    response.write(fs.readFileSync('./main.html' ));
    response.end();
}

function postHand(response) {
    console.log("Request handler 'postHand' was called.");
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write("Hello postHand");
    response.end();
}

exports.main = main;
exports.postHand = postHand;
