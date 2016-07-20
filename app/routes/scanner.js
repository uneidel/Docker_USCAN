var express = require('express');
var router = express.Router();
var config = require('../config');
var exec = require('child_process').exec;
var fs   = require('fs');

router.get('/', function(req, res) {
  var json_data = {"name":config.RestApiName,"Version":config.Version};
  res.json(json_data);
});

        	// start to scan the image
        	/*exec(command, {encoding: 'binary', maxBuffer: 50000*1024}, function(error, stdout) {
             		callback(stdout);
          	}).on('close', function() {
                done();
        	});
          */

router.get('/scan', function(req, res) {
  console.log("Unpaper:"  + req.query.unpaper);
  console.log("Merge:" + req.query.merge);
  var command = config.scanscript.Path + " " + req.query.merge + " " + req.query.unpaper;
  var json_data = {"name": config.RestApiName,"Version":config.Version, "unpaper": req.query.unpaper, "merge": req.query.merge};
  exec(config.scanscript.Path,function(err,stdout,stderr){
      console.log(err,stdout,stderr);
  });
  res.json(json_data);
});

module.exports = router;
