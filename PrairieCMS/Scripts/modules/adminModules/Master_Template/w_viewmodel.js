define(["Boiler"], function (Boiler) {

    var ViewModel = function (moduleContext) {

        var self = this;
        this.pkMasterID = ko.observable("");
        this.themeName = ko.observable("");
        this.Html = ko.observable("");
        this.wrapperList = ko.observableArray([]);
        this.selectedItem = ko.observable();
        this.buttontext = ko.observable("Create this Wrapper");
        this.wrapperSubmit = ko.observable(false);
        moduleContext.notify("NOTIFICATION", ["#masterMessage1", '']);

        this.initialize = function () {
            this.pkMasterID("");
            this.themeName("");
            this.Html("");
            //$("#Html_0_00").kendoEditor();
            var url = moduleContext.getSettings().urls.list_of_wrappers; 

            $.ajax({
                type: "GET",
                url: url,
                contentType: 'application/x-www-form-urlencoded',
                dataType: 'json',
                success: function (data, status) {
                    $("#adminTabs li:contains('Wrapper')").addClass("active");
         
                    self.wrapperSubmit(true);
                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#masterMessage1", 'Wrapperss Error: ' + data.errorMessage]);
                    }
                    else {
                        self.wrapperList(data);
                    }
                }
            });
        };

        this.startOver = function () {
            self.initialize();
        }

        this.getWrapperById = function () {
            if (this.selectedItem()[0] === undefined) {
                moduleContext.notify("NOTIFICATION", ["#masterMessage1", 'select something before trying to set content']);
                return;
            }
            self.wrapperSubmit(false);
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.wrapper_data,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    wrapperid: this.selectedItem()[0].MasterID
                }),
                dataType: 'json',
                success: function (data, status) {
                    self.wrapperSubmit(true);

                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#masterMessage1", 'Wrapper Error: ' + data.errorMessage]);
                    }
                    else {

                        self.themeName(data.ThemeName);
                       self.Html(data.Html);
                       // var editor = $("#Html_0_00").data("kendoEditor");
                        //editor.value(data.Html);
                        
                        self.setWrapperId(data.MasterID);
                        moduleContext.notify("NOTIFICATION", ["#masterMessage1", 'List: ' + self.themeName()]);
                        self.buttontext("Save changes");
                    }
                }
            });
        };

        this.setWrapperId = function(wrapperid)
        {
            self.pkMasterID(wrapperid);
            moduleContext.notify("WRAPPER", wrapperid);

        }

        this.saveWrapper = function () {
            self.wrapperSubmit(false);
            if (self.themeName() === '') {
                moduleContext.notify("NOTIFICATION", ["#masterMessage1", 'Please fill in wrapper items before sending it out']);
                self.wrapperSubmit(true);
                return;
            }

            self.Html($("#Html_0_00").val());
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.edit_wrapper,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    ThemeName: self.themeName(),
                    Html: self.Html(),
                    MasterID: self.pkMasterID()
                }),
                dataType: 'json',
                success: function (data, status) {
                    self.wrapperSubmit(true);
                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#masterMessage1", 'Error Saving List: ' + data.errorMessage]);
                    }
                    else {
                        self.setWrapperId(data.MasterID);
                        moduleContext.notify("NOTIFICATION", ["#masterMessage1", 'List: ' + self.themeName()]);
                        self.wrapperList.push(data);
                    }

                },
                error: function (data, status, e) {

                    self.wrapperSubmit(true);
                    moduleContext.notify("NOTIFICATION", ["#masterMessage1", 'An error occurred: ' + data.errorMessage]);
                }
            });

        };
    };

    return ViewModel;
});

