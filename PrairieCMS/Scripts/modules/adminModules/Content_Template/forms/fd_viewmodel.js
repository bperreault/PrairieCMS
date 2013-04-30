define(["Boiler"], function (Boiler) {

    var ViewModel = function (moduleContext) {
      
        var self = this;
        self.templateText = ko.observable("");
        self.itemObject = ko.observable();
        self.itemObjectHtml = ko.observable("");

        self.initialize = function () {

        };

        self.setItem = function (itemobject) {
            if (!itemobject)
                return;
            self.itemObject(itemobject);
            self.templateText(itemobject.inputForm);
            self.itemObjectHtml(itemobject.html);
        }

    };


    return ViewModel;
});

