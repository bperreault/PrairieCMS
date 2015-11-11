define(["Boiler"],
function (Boiler) {

    var ViewModel = function (moduleContext) {

        var self = this;
        self.pluginList = ko.observableArray([]);
        self.selectedModule = ko.observable();

        self.initialize = function () {
            

            moduleContext.notify("NOTIFICATION", ["#contentMessage1", '']);

            var url = moduleContext.getSettings().urls.modulesList;

            $.ajax({
                type: "GET",
                url: url,
                contentType: 'application/x-www-form-urlencoded',
                dataType: 'json',
                success: function (data, status) {
                   
                    $('#adminTabs li').filter(function () {
                        return $(this).children().text() == 'Plugins';
                    }).addClass("active");

                    self.pluginList(data);
                }
            });
        };

        self.getPluginAdminPages = function (moduleInfo) {
            
            moduleContext.notify("NOTIFICATION", ["#contentMessage1", '']);

            var url = moduleContext.getSettings().urls.getPluginAdminPages;

            $.ajax({
                type: "POST",
                url: url,
                data: JSON.stringify({
                    EntryControllerName: moduleInfo.EntryControllerName
                        }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (data, status) {

                    self.selectedModule(data);
                }
            });
        }

    };
   
    return ViewModel;
});

