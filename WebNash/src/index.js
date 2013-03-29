var server = require("./server");
var router = require("./router");
var requestHandler = require("./requestHandler");

var handle = {}
handle["/"] = requestHandler.main;
handle["/main"] = requestHandler.main;
handle["/postHand"] = requestHandler.postHand;

server.start(router.route, handle);

