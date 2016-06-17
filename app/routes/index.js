var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
var json_data = {"name":"Scanner REST API","Version":"0.1a"};
  res.json(json_data);
});

module.exports = router;
