define(["Boiler"], function (Boiler) {

    var ViewModel = function (moduleContext) {

        var self = this;
        this.pkContentID = ko.observable(-1);
        this.contentName = ko.observable("");
        this.html = ko.observable("");
        this.contentSubmit = ko.observable(false);
        this.buttontext = ko.observable('Create this Content');
        this.contentList = ko.observableArray([]);
        this.selectedItem = ko.observable();

        this.backToHome = function () {
            Boiler.UrlController.goTo("/");
        }

        this.initialize = function () {
            
            self.pkContentID(-1);
            self.contentName("");
            self.html("");
            self.contentSubmit(false);

           // $("#Html_1_90").kendoEditor();
            moduleContext.notify("NOTIFICATION", ["#contentMessage1", '']);
            
            var url = moduleContext.getSettings().urls.list_of_content; 

            $.ajax({
                type: "GET",
                url: url,
                contentType: 'application/x-www-form-urlencoded',
                dataType: 'json',
                success: function (data, status) {
                    self.contentSubmit(true);
                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content List Error: ' + data.errorMessage]);
                    }
                    else {
                        $("#adminTabs li:contains('Content')").addClass("active");
         
                        self.contentList(data);
                    }
                }
            });
        };

        this.startOver = function () {
            self.initialize();

            moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Start Over']);
        }

        this.getContentTemplate = function () {
            if (this.selectedItem()[0] === undefined) {
                moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'select something before trying to set content']);
                return;
            }
            self.contentSubmit(false);
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.content_template,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    contentId: this.selectedItem()[0].ContentId
                }),
                dataType: 'json',
                success: function (data, status) {
                    self.contentSubmit(true);

                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content Item Error: ' + data.errorMessage]);
                    }
                    else {
                       
                        self.contentName(data.ContentName);
                        self.html(data.Html);
                        //var editor = $("#Html_1_90").data("kendoEditor");
                       // editor.value(data.Html);
                        
                        self.setContentId(data.ContentId);
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content: ' + self.contentName()]);
                        self.buttontext("Save changes");
                    }
                }
            });
        };

        this.setContentId = function (contentid) {
            self.pkContentID(contentid);
            moduleContext.notify("CONTENT", contentid);

        }

        this.saveContent = function () {
            self.contentSubmit(false);
           // self.html($("#Html_1_90").val());
            if (self.html() === '' || self.contentName() === '') {
                moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Please fill in content items before sending it out']);
                self.contentSubmit(true);
                return;
            }

            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.edit_content,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    contentName: self.contentName(),
                    Html: self.html(),
                    contentId: self.pkContentID()
                }),
                dataType: 'json',
                success: function (data, status) {
                    self.contentSubmit(true);
                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Error Saving: ' + data.errorMessage]);
                    }
                    else {
                        self.setContentId(data.ContentId);
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content: ' + self.contentName()]);
                    }

                },
                error: function (data, status, e) {

                    self.contentSubmit(true);
                    moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'An error occurred: ' + data.errorMessage]);
                }
            });

        };
    };

    return ViewModel;
});
