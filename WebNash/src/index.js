var server = require("./server");
var router = require("./router");
var requestHandler = require("./requestHandler");

var handle = {}
handle["/"] = requestHandler.main;
handle["/main"] = requestHandler.main;
handle["/postHand"] = requestHandler.postHand;

handle["/css/style.css"] = requestHandler.cssStyleCss;
handle["/css/colour.css"] = requestHandler.cssColourCss;
handle["/js/modernizr-1.5.min.js"] = requestHandler.jsModernizrJs;
handle["/js/jquery.easing-sooper.js"] = requestHandler.jsJqueryEasingsooperJs;
handle["/js/jquery.sooperfish.js"] = requestHandler.jsJquerySooperfishJs;
handle["/js/jquery.min.js"] = requestHandler.jsJqueryJs;
handle["/js/image_fade.js"] = requestHandler.jsImagefadeJs;
handle["/images/dark2.png"] = requestHandler.imagesDark2Png;

handle["/faulkner/title_left.gif"] = requestHandler.faulknerTitleLeftGif;
handle["/faulkner/title_right.gif"] = requestHandler.faulknerTitleRightGif;
handle["/faulkner/style.css"] = requestHandler.faulknerStyleCss;

server.start(router.route, handle);

