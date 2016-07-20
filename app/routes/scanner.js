var express = require('express');
var router = express.Router();
var config = require('../config');
var exec = require('child_process').exec;
var fs   = require('fs'); 

router.get('/', function(req, res) {
  var json_data = {"name":"Scanner","Version":"0.1a"};
  res.json(json_data);
});
function parseOptions(obj) {
      if (!obj.resolution) 
        obj.resolution = this.config.defaultResolution;

    	if (!obj.mode)
    	  obj.mode = this.config.defaultMode;

      obj.deviceId = this.config.deviceId;
      return obj;
}
//scanimage --adf-mode Duplex --source="Automatic Document Feeder" --resolution 300 -x 215 -y 280 --format=pnm --batch=$WKDIR/document-p00%d.pnm -d epkowa 
function scanSync(options, callback, done) {
          var params = this.parseOptions(options, this.config);
        
        	var command = 'scanimage\ --device\ ' + params.deviceId + '\ ' +
        		            '--resolution\ ' + params.resolution + '\ ' +
        		            '--mode\ ' + params.mode + '\ |\ pnmtojpeg';

          var buffer = new Buffer('', 'binary');
          console.log(command);
        	// start to scan the image    
        	exec(command, {encoding: 'binary', maxBuffer: 50000*1024}, function(error, stdout) {
             		callback(stdout);
          	}).on('close', function() {
                done();
        	});
};
router.get('/scan', function(req, res) {
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
