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
        this.wrapperList = ko.observableArray([]);
        this.selectedWrapper = ko.observable("");
        this.pageTitle = ko.observable("");
        this.editorRole = ko.observable("1");
        this.tags = ko.observable("");

        this.backToHome = function () {
            Boiler.UrlController.goTo("/");
        }

        this.initialize = function () {

            self.pkContentID(-1);
            self.contentName("");
            self.html("");
            self.contentSubmit(false);

            //for the content map
            this.selectedWrapper = ko.observable();
            this.pageTitle = ko.observable("");

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

                        var url = moduleContext.getSettings().urls.list_of_wrappers;

                        $.ajax({
                            type: "GET",
                            url: url,
                            contentType: 'application/x-www-form-urlencoded',
                            dataType: 'json',
                            success: function (data, status) {
                                $("#adminTabs li:contains('Wrapper')").addClass("active");

                                self.contentSubmit(true);
                                if (data.errorMessage) {
                                    moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Wrapperss Error: ' + data.errorMessage]);
                                }
                                else {
                                    self.wrapperList(data);
                                }
                            }
                        });
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
            self.html($("#Html_1_90").val());
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
                    ContentHtml: self.html(),
                    ContentId: self.pkContentID(),
                    pagemap: {
                        pageName: self.contentName(),
                        MasterId: self.selectedWrapper()[0].MasterID,
                        fkEditorRoleID: self.editorRole(),
                        tags: self.tags(),
                        pageTitle: self.pageTitle()
                    }
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

        this.getWrapperById = function () {
            if (this.selectedWrapper()[0] === undefined) {
                moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'select something before trying to set content']);
                return;
            }
        };

        this.removeContentItem = function () {
                if (self.pkContentID === undefined || self.pkContentID == -1) {
                    moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'nothing selected']);
                    return;
                }
                self.MenuSubmit(false);
                $.ajax({
                    type: "POST",
                    url: moduleContext.getSettings().urls.content_item_delete,
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({
                        menuid: self.pkContentID
                    }),
                    dataType: 'json',
                    success: function (data, status) {
                        if (!data) {
                            self.errorMessage("No Data, an error occurred.");
                            moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu Error: ' + self.errorMessage()]);
                            return;
                        }

                        self.startOver();
                        self.errorMessage(data);

                    }
                });
           
        };

    };

    return ViewModel;
});
