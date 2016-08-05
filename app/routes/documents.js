var express = require('express');
var router = express.Router();
var config = require('../config');
var exec = require('child_process').exec;
var fs   = require('fs');
var Q = require('q');
var util = require( "util" );

router.get('/', function(req, res) {
  console.log(config.Documents.Path);
  GetFilesWithAttributes(config.Documents.Path).done(function(data){
    res.json(data);
  });


});

function GetFilesWithAttributes(path){
  var defer = Q.defer();
  var fa = [];
  fs.readdir(path, function(err, items) {

    for (var i=0; i<items.length; i++) {
        var fObj = {};
        var file = path + '/' + items[i];

        stats = fs.lstatSync(file);
        if(stats.isFile()){
          fObj.FileName = items[i];
          fObj.CreationTime = stats["ctime"];
          fa.push(fObj);
        }
    }
    defer.resolve(fa);
  });
  return defer.promise;
}

function GetFiles(path){
  var fileList=null;
  fileList =  fs.readdirSync(path);
  return fileList;
}

function ParseTextLayer(path){
  var defer = Q.defer();
  let fs = require('fs'),PDFParser = require("pdf2json/PDFParser");
    var jsonData = null;
    let pdfParser = new PDFParser();
    console.log(path);
    pdfParser.on("pdfParser_dataError", errData => console.error(errData.parserError) );
    pdfParser.on("pdfParser_dataReady", pdfData => {
        console.log("dataReady");

        defer.resolve(pdfData);
        //console.log(jsonData);
    });
    console.log("dataReady_PRE");
    pdfParser.loadPDF(path);
    return defer.promise;
}
function GetJustText(data){
    var array=[];
    var gersw = ["dass","der","zum","ihrer","einen","herr","im", "sich", "die","wir","zu","von","dem","wo","für","und","durch","Ihren","nach"];
    for (var i = 0, len = data.formImage.Pages.length; i < len; i++)
    {
      var page = data.formImage.Pages[i];
      console.log("PageIndex:" + i);
      if (!page){
        console.log("return because i:" + i);
        return array;
      }
      for (var j = 0, jlen = page.Texts.length; j < jlen; j++)
      {
          var text = page.Texts[j];
          var x = text.R[0].T;

          //prepare
          var x = decodeURI(x);
          //check if multiple words
          var res = x.split(" ");
          //console.log("ResLength: " + res.length);
          for (var z = 0, zlen = res.length;z<zlen;z++)
          {
              //check if stopword / lowerit / trim
               //console.log(".");
               var word = res[z].trim().toLowerCase();
               if (word.length > 1 && !gersw.includes(word))
                array.push(word);
          }

      }
    };
    return array;
}

router.get('/:fileName/details', function(req, res) {
  var filename = req.params.fileName;

  var fullName = config.Documents.Path + "\\" + filename;
  ParseTextLayer(fullName).done(function(data){
    console.log(req.query);

    if (req.query.text && req.query.text == "true")
    {
      console.log("parse only textwords");
      var data = GetJustText(data);

    }

    res.json(data);
  });
});
router.get('/:fileName/file', function(req, res) {
  var filename = req.params.fileName;
  var fullName = config.Documents.Path + "\\" + filename;
  res.download(fullName, filename, function(err){
    console.log("error has occurred: " +  err);
  });

});

router.post('/:fileName', function(req, res){
  var filename = req.params.fileName;
  var fullName = config.Documents.Path + "\\" + filename;

  var keywords="";
  if (req.body.keywords)
   keywords=req.body.keywords;

   var author=config.DefaultAuthor;

  var command = util.format("exiftool -Keywords='%s' -Author='%s' -Title='%s' %s ", keywords, author, filename, fullName);
  console.log(command);
  exec(command,{encoding: 'binary', maxBuffer: 50000*1024},function(err,stdout,stderr){
      console.log(err,stdout,stderr);
   }).on('close', function() {
      done();
    });
  
});

module.exports = router;
