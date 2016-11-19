var express = require('express');
var router = express.Router();
var config = require('../config');
var exec = require('child_process').exec;
var fs   = require('fs');

router.get('/', function(req, res) {
  var json_data = {"name":config.RestApiName,"Version":config.Version};
  res.json(json_data);
});



router.get('/scanpdf', function(req, res) {
  console.log("Unpaper:"  + req.query.unpaper);
  console.log("Merge:" + req.query.merge);
  var command = config.PDF.ScriptPath + " " + req.query.merge + " " + req.query.unpaper;
  var json_data = {"name": config.RestApiName,"Version":config.Version, "unpaper": req.query.unpaper, "merge": req.query.merge};
  exec(command,{encoding: 'binary', maxBuffer: 50000*1024},function(err,stdout,stderr){
      console.log(err,stdout,stderr);
  }).on('close', function() {
      
});
  res.json(json_data);
});
router.get('/scanpic', function(req, res) {
  var resolution = config.PIC.Resolution;
  var format = config.PIC.DefaultFormat;
  if (!req.query.resolution)
    resolution=req.query.resolution;
  if (!req.query.format)
    format=req.query.format;

  console.log("Resolution:"  + resolution);

  var command = config.PIC.ScriptPath + " " + resolution + " " + format;
  var json_data = {"name": config.RestApiName,"Version":config.Version};
  exec(command,{encoding: 'binary', maxBuffer: 50000*1024}, function(err,stdout,stderr){
      console.log(err,stdout,stderr);
  });
  res.json(json_data);
});
module.exports = router;
