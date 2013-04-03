define(["Boiler"], function (Boiler) {

    var ViewModel = function (moduleContext, contentToEdit) {

        var self = this;
        self.fkContentID = ko.observable(-1);
        self.fkLevelMappingId = ko.observable(1); //page level is default
        self.ContentName = ko.observable("");
        self.html = ko.observable("");
        self.contentSubmit = ko.observable(false);
        self.buttontext = ko.observable('Create self Content');
        self.selectedItem = ko.observable();
        self.wrapperList = ko.observableArray([]);
        self.rolesList = ko.observableArray([]);
        self.selectedWrapper = ko.observable();
        self.selectedRole = ko.observable();
        self.fkMasterThemeID = ko.observable();
        self.pageTitle = ko.observable("");
        self.contentList = ko.observableArray([]);
        self.contentPieces = [{ text: "loading", value: ""}]; //user insertable content 

        self.tags = ko.observable("");
        self.deleteVisible = ko.observable(false);
        self.pkMapID = ko.observable("-1");
        self.pkBcId = ko.observable("-1");
        self.pageName = ko.observable("");
        self.isActive = ko.observable(false);

        self.editor = null;
        self.dostartover = false;

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
            self.selectedRole("1");
            self.fkLevelMappingId(1);
            self.tags("");
            self.pkMapID(-1);
            self.pkBcId(-1);
            self.pageName("");
            self.isActive(false);

            self.setupRoles();

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

                        self.contentList(data.contentList);
                        self.contentPieces = data.contentPieces;

                        self.SetupKendoEditor();

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

                                    if (contentToEdit && !self.dostartover) {
                                        self.getContentByFriendlUrl(contentToEdit);
                                    }
                                    self.dostartover = false;
                                }
                            }
                        });
                    }
                }
            });
        };

        self.setupRoles = function () {
            self.rolesList.push({ RoleId: 1, RoleName: 'Admin' });
        };

        self.startOver = function () {
            self.dostartover = true;
            self.initialize();

            moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Start Over']);
        };

        self.getContentByFriendlUrl = function (friendlyUrl) {

            self.contentSubmit(false);
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.content_byFriendlyUrl,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    friendlyUrl: friendlyUrl
                }),
                dataType: 'json',
                success: function (data, status) {
                    self.contentSubmit(true);

                    if (data.errorMessage) {
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content Item Error: ' + data.errorMessage]);
                    }
                    else {
                        self.setUp(data)
                    }
                }
            });
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
                        self.setUp(data)
                    }
                }
            });
        };

        self.setUp = function (data) {

            self.ContentName(data.ContentName);
            self.fkLevelMappingId(data.fkLevelMappingId);
            self.html(data.ContentHtml);

            self.SetupKendoEditor();

            var editor = $("#Html_1_90").data("kendoEditor");
            editor.value(data.ContentHtml);

            self.fkMasterThemeID(data.fkMasterThemeID);
            self.selectedWrapper(data.fkMasterThemeID);
            self.pageTitle(data.pageTitle);
            self.selectedRole(data.fkEditorRoleID);
            self.tags(data.tags);
            self.pkMapID(data.pkMapID);
            self.pkBcId(data.pkBcId);
            self.pageName(data.pageName);
            self.isActive(data.isActive);


            self.setContentId(data.ContentId);
            moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Content: ' + self.ContentName()]);
            self.buttontext("Save changes");
            self.deleteVisible(true)
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
                    fkEditorRoleID: self.selectedRole(),
                    fkMasterThemeID: self.selectedWrapper(),
                    isActive: true,
                    pkBcId: self.pkBcId(),
                    pkMapID: self.pkMapID(),
                    contentTypeMappings: [{
                        pkBcId: self.pkBcId(),
                        fkContent: self.fkContentID(),
                        fkParent: self.fkContentID(),  //pages parents equal their content
                        fkEditorsRole: self.selectedRole(),
                        fkContentType: 1,
                        domInsertionPoint: 'content_template'
                    }],
                    pagemap: {
                        pageName: self.ContentName(),
                        MasterID: self.selectedWrapper(),
                        fkEditorRoleID: self.selectedRole(),
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
                        self.pkMapID(data.pkMapID);

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
                    self.dostartover = true;
                    self.startOver();
                    self.errorMessage(data);

                }
            });

        };

        this.getPageForEdit = function (pageInfo) {

            Boiler.UrlController.goTo("body/" + pageInfo.ContentName);
        }

        self.SetupKendoEditor = function () {
            self.editor = $("#Html_1_90").data("kendoEditor");
            if (self.editor)
                self.editor.destroy();

            $("#Html_1_90").kendoEditor({
                tools: [
                "bold",
                "italic",
                "underline",
                "strikethrough",
                "fontName",
                "fontSize",
                "foreColor",
                "backColor",
                "justifyLeft",
                "justifyCenter",
                "justifyRight",
                "justifyFull",
                "insertUnorderedList",
                "insertOrderedList",
                "indent",
                "outdent",
                "formatBlock",
                "createLink",
                "unlink",
                "insertImage",
                "subscript",
                "superscript",
                "insertHtml",
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
                }
            ],
                insertHtml: self.contentPieces
            });

            self.editor = $("#Html_1_90").data("kendoEditor");
            // bind to the select event
            self.editor.bind("select", function (e) {
                // handle event
                alert(e);
            });
            self.editor.value(self.html());

        };
    };

    return ViewModel;
});
