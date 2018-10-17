const express = require('express');
const bodyParser = require('body-parser');
const fileupload = require('express-fileupload');

var server = express();
server.use(fileupload());
var jsonParser = bodyParser.json();

server.get('/', function(req, res) {
    var output = "<html><body style=\"font-family: 'Trebuchet MS';\">";
    output += "This is a demo server for the GTRestKit Swift library.";
    output += "<h2>Test Endpoints</h2>";
    output += "<br>";
    output += "<h3>GET</h3>"
    output += "<ul>";
    output += "<li>" + "/testapi/getsimple" + "</li>";
    output += "<li>" + "/testapi/getwithqueryparams" + "</li>";
    output += "</ul>";
    output += "<h3>POST</h3>"
    output += "<ul>";
    output += "<li>" + "/testapi/postsimple" + "</li>";
    output += "<li>" + "/testapi/postsinglefile" + "</li>";
    output += "<li>" + "/testapi/uploadmultiplefiles" + "</li>";
    output += "</ul>";
    res.send(output);
});


server.get('/testapi/getsimple', function(req, res) {
    res.send('This is the message of SUCCESS!');
});


server.get('/testapi/getwithqueryparams', function(req, res) {
    const sum = parseInt(req.query.a) + parseInt(req.query.b);
    const diff = parseInt(req.query.a) - parseInt(req.query.b);
    const multiply = parseInt(req.query.a) * parseInt(req.query.b);
    var div = "Cannot be defined";
    if (parseInt(req.query.b) !== 0) {
        div = parseInt(req.query.a) / parseInt(req.query.b);
    }

    var greater = parseInt(req.query.a);
    if (parseInt(req.query.b) > parseInt(req.query.a)) {
        greater = parseInt(req.query.b);
    } else if (parseInt(req.query.b) === parseInt(req.query.a)) {
        greater = "equal numbers";
    }

    var returnJSON = {'sum': sum, 'diff': diff, 'multiply': multiply, 'division': div, 'greater': greater};

    res.json(returnJSON);
});



server.post('/testapi/postsimple', jsonParser, function(req, res) {
    if (Object.keys(req.body).length !== 0) {
        res.status(201);
        res.send(req.body);
    } else {
        res.status(400).send("No data was found in the request body.");
    }
});



server.post('/testapi/postsinglefile', jsonParser, function(req, res) {
    if (!req.files) {
        res.status(400);
        res.send("Please upload a file.");
    } else {
        const totalFiles = Object.keys(req.files).length;
        if (totalFiles > 0) {
            let firstFile = Object.keys(req.files)[0];

            var returnJSON = {"name": req.files[firstFile].name};
            returnJSON["mimetype"] = req.files[firstFile].mimetype;
            returnJSON["encoding"] = req.files[firstFile].encoding;
            returnJSON["type"] = req.files[firstFile].data.type;
            returnJSON["size (bytes)"] = req.files[firstFile].data.length;

            res.send(returnJSON);
        } else {
            res.status(400);
            res.send("No files were found.");
        }
    }
});



server.post('/testapi/uploadmultiplefiles', jsonParser, function(req, res) {
    if (!req.files) {
        res.status(400);
        res.send("Please upload at least one file.");
    } else {
        const totalFiles = Object.keys(req.files).length;
        if (totalFiles > 0) {
            var returnJSON = {"totalFiles": totalFiles};
            var filesInfo = [];
            for (var i=0; i<totalFiles; i++) {
                let currentFile = Object.keys(req.files)[0];

                var currentJSON = {"name": req.files[currentFile].name};
                currentJSON["mimetype"] = req.files[currentFile].mimetype;
                currentJSON["encoding"] = req.files[currentFile].encoding;
                currentJSON["type"] = req.files[currentFile].data.type;
                currentJSON["size (bytes)"] = req.files[currentFile].data.length;

                filesInfo.push(currentJSON);
            }

            returnJSON["filesInfo"] = filesInfo;
            res.send(returnJSON);
        } else {
            res.status(400);
            res.send("No files were found.");
        }
    }
});




server.use(function(req, res, next) {
    res.status(404).send('The endpoint you are looking for does not exist (404).');
});


var port = process.env.PORT || 3000;
server.listen(port, function() {
    console.log("Listening on port " + port + "...");
});
