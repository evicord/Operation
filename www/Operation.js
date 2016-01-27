var exec = require('cordova/exec');

exports.toBinary = function(arg0, success, error) {
    exec(success, error, "Operation", "", [arg0]);
};
