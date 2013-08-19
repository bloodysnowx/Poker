var exec = require("child_process").exec;
var fs = require('fs');
var querystring = require("querystring");
var webnash = require('./webnash');

function main(response, postData) {
    printFile('./main.html', 'text/html', response);
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

function printFile(fileName, contentType, response)
{
    response.writeHead(200, {"Content-Type": contentType});
    response.write(fs.readFileSync(fileName));
    response.end();
}

function cssStyleCss(response, postData) {
    printFile("./css/style.css", "text/css", response);
}

function cssColourCss(response, postData) {
    printFile("./css/colour.css", "text/css", response);
}

function jsModernizrJs(response, postData) {
    printFile("./js/modernizr-1.5.min.js", "text/javascript", response);
}

function jsJqueryJs(response, postData) {
    printFile("./js/jquery.min.js", "text/javascript", response);
}

function jsJquerySooperfishJs(response, postData) {
    printFile("./js/jquery.sooperfish.js", "text/javascript", response);
}

function jsJqueryEasingsooperJs(response, postData) {
    printFile("./js/jquery.easing-sooper.js", "text/javascript", response);
}

function jsImagefadeJs(response, postData) {
    printFile("./js/image_fade.js", "text/javascript", response);
}

function imagesDark2Png(response, postData) {
    printFile("./images/dark2.png", "image/png", response);
}

function faulknerStyleCss(response, postData) {
    printFile("./faulkner/style.css", "text/css", response);
}

function faulknerTitleLeftGif(response, postData) {
    printFile("./faulkner/title_left.gif", "image/gif", response);
}

function faulknerTitleRightGif(response, postData) {
    printFile("./faulkner/title_right.gif", "image/gif", response);
}

function faulknerBgJpg(response, postData) {
    printFile("./faulkner/bg.jpg", "image/jpeg", response);
}

function faulknerOrnamentGif(response, postData) {
    printFile("./faulkner/ornament.gif", "image/gif", response);
}

function faulknerParchmentJpg(response, postData) {
    printFile("./faulkner/parchment.jpg", "image/jpeg", response);
}

function faulknerFootJpg(response, postData) {
    printFile("./faulkner/foot.jpg", "image/jpeg", response);
}

function faulknerMenuhoverJpg(response, postData) {
    printFile("./faulkner/menuhover.jpg", "image/jpeg", response);
}

exports.main = main;
exports.postHand = postHand;
exports.printFile = printFile;
exports.cssStyleCss = cssStyleCss;
exports.cssColourCss = cssColourCss;
exports.jsModernizrJs = jsModernizrJs;
exports.jsJqueryJs = jsJqueryJs;
exports.jsJquerySooperfishJs = jsJquerySooperfishJs;
exports.jsJqueryEasingsooperJs = jsJqueryEasingsooperJs;
exports.jsImagefadeJs = jsImagefadeJs;
exports.imagesDark2Png = imagesDark2Png;

exports.faulknerStyleCss = faulknerStyleCss;
exports.faulknerTitleLeftGif = faulknerTitleLeftGif;
exports.faulknerTitleRightGif = faulknerTitleRightGif;
exports.faulknerBgJpg = faulknerBgJpg;
exports.faulknerOrnamentGif = faulknerOrnamentGif;
exports.faulknerParchmentJpg = faulknerParchmentJpg;
exports.faulknerFootJpg = faulknerFootJpg;
exports.faulknerMenuhoverJpg = faulknerMenuhoverJpg;
