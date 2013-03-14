define(["Boiler"], function (Boiler) {

    var ViewModel = function (moduleContext) {

        var self = this;
        self.fkContentID = ko.observable(-1);
        self.ContentName = ko.observable("");
        self.html = ko.observable("");
        self.contentSubmit = ko.observable(false);
        self.buttontext = ko.observable('Create self Content');
        self.contentList = ko.observableArray([]);
        self.selectedItem = ko.observable();
        self.wrapperList = ko.observableArray([]);
        self.selectedWrapper = ko.observable();
        self.fkMasterThemeID = ko.observable();
        self.pageTitle = ko.observable("");
        self.fkEditorRoleID = ko.observable(-1);
        self.tags = ko.observable("");
        self.deleteVisible = ko.observable(false);
        self.pkMapID = ko.observable("-1");
        self.pageName = ko.observable("");
        self.isActive = ko.observable(false);

        self.backToHome = function () {
            Boiler.UrlController.goTo("/");
        }


        self.initialize = function () {

            self.fkContentID(-1);
            self.ContentName("");
            self.html("");
            self.contentSubmit(false);

            //for the content map
            self.fkMasterThemeID(-1);
            self.pageTitle("");
            self.fkEditorRoleID(-1);
            self.tags("");
            self.pkMapID("1");
            self.pageName("");
            self.isActive(false);

            self.SetupKendoEditor();

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
                        $("#adminTabs li").removeClass("active");
                        $('#adminTabs li').filter(function () {
                            return $(this).children().html() == 'Content';
                        }).addClass("active");

                        self.contentList(data);

                        var url = moduleContext.getSettings().urls.list_of_wrappers;

                        $.ajax({
                            type: "GET",
                            url: url,
                            contentType: 'application/x-www-form-urlencoded',
                            dataType: 'json',
                            success: function (data, status) {

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

        self.startOver = function () {
            self.initialize();

            moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Start Over']);
        };

        self.getContentTemplate = function () {
            if (self.selectedItem()[0] === undefined) {
                moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'select something before trying to set content']);
                return;
            }
            self.contentSubmit(false);
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.content_template,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    pkMapID: self.selectedItem()[0].pkMapID
                }),
                dataType: 'json',
                success: function (data, status) {
                    self.contentSubmit(true);

                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content Item Error: ' + data.errorMessage]);
                    }
                    else {

                        self.ContentName(data.ContentName);
                        self.html(data.ContentHtml);
                        var editor = $("#Html_1_90").data("kendoEditor");
                        editor.value(data.ContentHtml);

                        self.fkMasterThemeID(data.fkMasterThemeID);
                        self.selectedWrapper({ MasterID: data.fkMasterThemeID });

                        self.pageTitle(data.pageTitle);
                        self.fkEditorRoleID(data.fkEditorRoleID);
                        self.tags(data.tags);
                        self.pkMapID(data.pkMapID);
                        self.pageName(data.pageName);
                        self.isActive(data.isActive);


                        self.setContentId(data.fkContentID);
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content: ' + self.ContentName()]);
                        self.buttontext("Save changes");
                        self.deleteVisible(true)
                    }
                }
            });
        };

        self.setContentId = function (contentid) {
            self.fkContentID(contentid);
            moduleContext.notify("CONTENT", contentid);

        };

        self.saveContent = function () {
            self.contentSubmit(false);
            var editor = $("#Html_1_90").data("kendoEditor");
            self.html(editor.value());
            if (self.html() === '' || self.ContentName() === '') {
                moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Please fill in content items before sending it out']);
                self.contentSubmit(true);
                return;
            }
            
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.edit_content,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    ContentName: self.ContentName(),
                    ContentHtml: self.html(),
                    ContentId: self.fkContentID(),
                    fkEditorRoleID: self.fkEditorRoleID,
                    fkMasterThemeID: self.selectedWrapper()[0].MasterID,
                    contentTypeMappings: [{
                        fkParent: -1,
                        fkEditorsRole: 1,
                        fkContentType: 1,
                        domInsertionPoint: 'content_template'
                    }],
                    pagemap: {
                        pageName: self.ContentName(),
                        MasterID: self.selectedWrapper()[0].MasterID,
                        fkfkEditorRoleIDID: self.fkEditorRoleID(),
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
                        self.setContentId(data.fkContentID);
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content: ' + self.ContentName()]);
                    }

                },
                error: function (data, status, e) {

                    self.contentSubmit(true);
                    moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'An error occurred: ' + data.errorMessage]);
                }
            });

        };

        self.removeContentItem = function () {
            if (self.fkContentID === undefined || self.fkContentID == -1) {
                moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'nothing selected']);
                return;
            }
            self.MenuSubmit(false);
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.content_item_delete,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    menuid: self.fkContentID
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

        self.SetupKendoEditor = function () {
            $("#Html_1_90").kendoEditor({
                tools: [
                {
                    name: "fontName",
                    items: [].concat(kendo.ui.Editor.prototype.options.fontName[8], [{ text: "Garamond", value: "Garamond, serif"}])
                },
                {
                    name: "fontSize",
                    items: [].concat(kendo.ui.Editor.prototype.options.fontSize[0], [{ text: "16px", value: "16px"}])
                },
                {
                    name: "formatBlock",
                    items: [].concat(kendo.ui.Editor.prototype.options.formatBlock[0], [{ text: "Fieldset", value: "fieldset"}])
                },
                {
                    name: "customTemplate",
                    template: $("#backgroundColor-template").html()
                },
                {
                    name: "viewHtml",
                    tooltip: "View HTML",
                    exec: function (e) {
                        var editor = $(this).data("kendoEditor");

                        var dialog = $($("#viewHtml-template").html())
                            .find("textarea").val(editor.value()).end()
                            .find(".viewHtml-update")
                                .click(function () {
                                    editor.value(dialog.element.find("textarea").val());
                                    dialog.close();
                                })
                            .end()
                            .find(".viewHtml-cancel")
                                .click(function () {
                                    dialog.close();
                                })
                            .end()
                            .kendoWindow({
                                modal: true,
                                title: "View HTML",
                                deactivate: function () {
                                    dialog.destroy();
                                }
                            }).data("kendoWindow");

                        dialog.center().open();
                    }
                },
                {
                    name: "custom",
                    tooltip: "Insert a horizontal rule",
                    exec: function (e) {
                        var editor = $(this).data("kendoEditor");
                        editor.exec("inserthtml", { value: "<hr />" });
                    }
                }
            ]
            });

        };
    };

    return ViewModel;
});
