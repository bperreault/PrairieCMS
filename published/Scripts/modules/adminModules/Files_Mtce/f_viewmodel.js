define(["Boiler"],
function (Boiler) {

    var ViewModel = function (moduleContext) {

        var self = this;
        self.filesList = ko.observableArray([]);
        self.selectedFile = ko.observable();

        self.initialize = function () {

        };

        self.getFileForEdit = function () { }

    };
   
    return ViewModel;
});

