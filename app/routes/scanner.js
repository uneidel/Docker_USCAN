var express = require('express');
var router = express.Router();
var config = require('../config');
var exec = require('child_process').exec;
router.get('/', function(req, res) {
  var json_data = {"name":"Scanner","Version":"0.1a"};
  res.json(json_data);
});
router.get('/single', function(req, res) {
  var json_data = {"name":"Scanner","Version":"0.1a", "Message": "single page Process started"};
  exec(config.scanscript.SinglePath,function(err,stdout,stderr){
      console.log(err,stdout,stderr);
  });
  res.json(json_data);
});
router.get('/merge', function(req, res) {
  var json_data = {"name":"Scanner","Version":"0.1a", "Message":"merging Process started"};
  exec(config.scanscript.MergePath,function(err,stdout,stderr){
      console.log(err,stdout,stderr);
  });
  res.json(json_data);
});

module.exports = router;
