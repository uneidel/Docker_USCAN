module.exports = function(){
    console.log(process.env.NODE_ENV);
    switch(process.env.NODE_ENV){
        case 'development':
            var config = {};
            config.DefaultAuthor="Ulrich Neidel";
            config.PDF = {};
            config.PIC = {};
            config.Documents = {};
            config.Documents.Path = "C:\\Temp\\REST";
            config.PDF.ScriptPath = "/srv/scripts/scan.sh";
            config.PDF.Unpaper = "true";
            config.PDF.Merge ="false";
            config.PIC.ScriptPath = "/srv/scripts/scanpic.sh";
            config.PIC.Resolution = 600;
            config.PIC.DefaultFormat = "jpg";
            config.Version = "0.4";
            config.RestApiName ="ScannerApi";

            return config;

        case 'production':
        var config = {};
            config.DefaultAuthor="Ulrich Neidel";
            config.PDF = {};
            config.PIC = {};
            config.Documents = {};
            config.Documents.Path = "/srv/scanner/";
            config.PDF.ScriptPath = "/srv/scripts/scan.sh";
            config.PDF.Unpaper = "true";
            config.PDF.Merge ="false";
            config.PIC.ScriptPath = "/srv/scripts/scanpic.sh";
            config.PIC.Resolution = 600;
            config.PIC.DefaultFormat = "jpg";
            config.Version = "0.4";
            config.RestApiName ="ScannerApi";
            module.exports = config;

            return config;

        default:
            return null;
    }
};
