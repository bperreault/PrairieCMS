define(["Boiler"], function (Boiler) {

    var ViewModel = function (moduleContext) {

        var self = this;
        this.contentSubmit = ko.observable(false);
        this.buttontext = ko.observable('Create this Menu Item');

        var errorMessage = ko.observable("");
        var pkSiteMapItemID = ko.observable(-1);
        var SiteMapItemName = ko.observable("");
        var fkSiteMapParentId = ko.observable("");
        var relativeUrl = ko.observable("");
        var menuItemList = ko.observableArray([]);  

        this.initialize = function () {
            self.pkContentID(-1);
            self.contentName("");
            self.Html("");
            self.contentSubmit(false);

            moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", '']);

            var url = moduleContext.getSettings().urls.menu_options; 

            $.ajax({
                type: "GET",
                url: url,
                contentType: 'application/x-www-form-urlencoded',
                dataType: 'json',
                success: function (data, status) {
                    self.contentSubmit(true);
                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu Item Error: ' + data.errorMessage]);
                    }
                    else {
                        $("#adminTabs li:contains('Content')").addClass("active");

                        self.menuItemList(data);
                    }
                }
            });
        };
        this.backToHome = function () {
            Boiler.UrlController.goTo("/");
        }
      
    };

    return ViewModel;
});

