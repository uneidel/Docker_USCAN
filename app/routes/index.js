var express = require('express');
var router = express.Router();
var config = require('../config'),conf = new config();
router.get('/', function(req, res) {


  res.json(conf);
});
function extend(target) {
    var sources = [].slice.call(arguments, 1);
    sources.forEach(function (source) {
        for (var prop in source) {
            target[prop] = source[prop];
        }
    });
    return target;
}

module.exports = router;
