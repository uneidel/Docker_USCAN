var config = {};

config.PDF = {};
config.PIC = {};
config.Documents = {};
config.Documents.Path = "C:\\Temp";
config.PDF.ScriptPath = "/srv/scripts/scan.sh";
config.PDF.Unpaper = "true";
config.PDF.Merge ="false";
config.PIC.ScriptPath = "/srv/scripts/scanpic.sh";
config.PIC.Resolution = 600;
config.Version = "0.3";
config.RestApiName ="ScannerApi";
module.exports = config;
