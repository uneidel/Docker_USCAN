var express = require('express');
var router = express.Router();
var config = require('../config');
var exec = require('child_process').exec;
var fs   = require('fs');
var Q = require('q');

router.get('/', function(req, res) {
  console.log(config.Documents.Path);
  var files = GetFiles(config.Documents.Path);
  console.log("Files: " + files);
  var json_data = JSON.stringify(files);
  res.json(json_data);
});

function GetFiles(path){
  var fileList=null;
  return fs.readdirSync(path);
}

function ParseTextLayer(path){
  let fs = require('fs'),PDFParser = require("pdf2json/PDFParser");
    var jsonData = null;
    let pdfParser = new PDFParser();
    console.log(path);
    pdfParser.on("pdfParser_dataError", errData => console.error(errData.parserError) );
    pdfParser.on("pdfParser_dataReady", pdfData => {
        console.log("dataReady");
        jsonData= JSON.stringify(pdfData);
        console.log(jsonData);
    });
    console.log("dataReady_PRE");
    pdfParser.loadPDF(path);
    return jsonData;
}

router.get('/:fileName', function(req, res) {
  var filename = req.params.fileName;
  var fullName = config.Documents.Path + "\\" + filename;
  var json_data = ParseTextLayer(fullName);
  res.json(json_data);
    //var files = "";//GetFiles(config.Documents.Path);
    //console.log(files);
    //var json_data = JSON.stringify(files);
    //res.json(json_data);
});

module.exports = router;
