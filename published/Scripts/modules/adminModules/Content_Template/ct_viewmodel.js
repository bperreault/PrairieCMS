define(["Boiler", './forms/fd_viewmodel', 'text!./forms/fd_view.html', "./modules", '../settings', './formBuilder', "sbsBusyIndicator"],
function (Boiler, ItemsModel, template, childModule, settings, forminputseditor, sbsBusyIndicator) {

    var ViewModel = function (moduleContext, contentToEdit) {

        var self = this;
        self.childContext = null; //for baby form items editor
        self.contentSetByUrl = contentToEdit;

        self.fkContentID = ko.observable(-1);
        self.fkLevelMappingId = ko.observable(1); //page level is default
        self.ContentName = ko.observable("");
        self.html = ko.observable("");
        self.contentSubmit = ko.observable(false);
        self.buttontext = ko.observable('Create self Content');
        self.selectedItem = ko.observable();
        self.wrapperList = ko.observableArray([]);
        self.rolesList = ko.observableArray([]);
        self.selectedRole = ko.observable(1);
        self.fkMasterThemeID = ko.observable(1);
        self.pageTitle = ko.observable("");
        self.contentList = ko.observableArray([]);
        self.contentPieces = ko.observableArray([{ text: "loading", value: ""}]); //user insertable content 
        self.selectedContent = ko.observable();

        self.tags = ko.observable("");
        self.deleteVisible = ko.observable(false);
        self.pkMapID = ko.observable("-1");
        self.pkBcId = ko.observable("-1");
        self.pageName = ko.observable("");
        self.isActive = ko.observable(true);
        self.cmsPageMapId = ko.observable("-1");

        self.editor = null;

        self.backToHome = function () {
            Boiler.UrlController.goTo("/");
        }


        self.initialize = function () {

            self.fkContentID(-1);
            self.ContentName("");
            self.html("");

            self.contentSubmit(false);

            //for the content map
            self.fkMasterThemeID(1);
            self.pageTitle("");
            self.selectedRole(1);
            self.fkLevelMappingId(1);
            self.tags("");
            self.pkMapID(-1);
            self.pkBcId(-1);
            self.pageName("");
            self.isActive(true);
            self.cmsPageMapId(-1);

            self.childContext = new Boiler.Context();
            self.childContext.addSettings(settings);

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
                        $('#adminTabs li').filter(function () {
                            return $(this).children().text() == 'Content';
                        }).addClass("active");

                        self.contentList(data.contentList);

                        self.contentPieces(data.contentPieces);
                        self.fillFormBuilderItems(); //knockout bindings aren't working for me in the template

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


                                    if (contentToEdit) {
                                        self.getContentByFriendlUrl(self.contentSetByUrl);
                                    }
                                    else {
                                        self.SetupKendoEditor();
                                    }
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
            moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'Start Over']);
            Boiler.UrlController.goTo("/");
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
                        moduleContext.notify("NOTIFICATION", ["#contentMessage1", data.errorMessage + " - Setup for New"]);
                        self.addNewNamedItem(friendlyUrl);
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

        self.addNewNamedItem = function (name) {
            self.ContentName(name);
            self.fkLevelMappingId(-1);
            self.html("");

            self.SetupKendoEditor();

            self.fkMasterThemeID(1);
            self.pageTitle(name);
            self.selectedRole(1);
            self.tags("");
            self.pkMapID(-1);
            self.pkBcId(-1);
            self.pageName(name);
            self.isActive(true);
            self.cmsPageMapId(-1);

            self.setContentId(-1);
            moduleContext.notify("NOTIFICATION", ["#contentMessage1", 'New: ' + self.ContentName()]);
            self.buttontext("Save changes");
            self.deleteVisible(false)
        };

        self.setUp = function (data) {

            self.ContentName(data.ContentName);
            self.fkLevelMappingId(data.fkLevelMappingId);
            self.html(data.ContentHtml);

            self.SetupKendoEditor();

            self.fkMasterThemeID(data.fkMasterThemeID);
            self.pageTitle(data.pageTitle);
            self.selectedRole(data.fkEditorRoleID);
            self.tags(data.tags);
            self.pkMapID(data.pkMapID);
            self.pkBcId(data.pkBcId);
            self.pageName(data.pageName);
            self.isActive(data.isActive);
            self.cmsPageMapId(data.cmsPageMapId);

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
            self.html(self.editor.value());
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
                    fkMasterThemeID: self.fkMasterThemeID(),
                    isActive: self.isActive(),
                    pkBcId: self.pkBcId(),
                    pkMapID: self.pkMapID(),
                    fkLevelMappingId: self.fkLevelMappingId(),
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
                        MasterID: self.fkMasterThemeID(),
                        fkEditorRoleID: self.selectedRole(),
                        tags: self.tags(),
                        pageTitle: self.pageTitle(),
                        cmsPageMapId: self.cmsPageMapId()
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
            if (self.fkContentID() === undefined || self.fkContentID() == -1) {
                moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'nothing selected']);
                return;
            }
            sbsBusyIndicator.showBusy();
            self.contentSubmit(false);
            self.deleteVisible(false);

            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.content_item_delete,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    contentid: self.fkContentID()
                }),
                dataType: 'json',
                success: function (data, status) {
                    if (!data) {
                        self.errorMessage("No Data, an error occurred.");
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu Error: ' + self.errorMessage()]);
                        return;
                    }
                    self.startOver();

                    moduleContext.notify("NOTIFICATION", ["#contentMessage1", data]);

                    sbsBusyIndicator.hideBusy();
                }
            });

        };

        this.getPageForEdit = function (pageInfo) {

            self.contentSetByUrl = pageInfo.ContentName;
            Boiler.UrlController.goTo("body/" + pageInfo.ContentName);
        }

        self.findTemplateItemInContentPieces = function (templateItem) {
            for (var ii = 0; ii < self.contentPieces().length; ii++) {
                if (self.contentPieces()[ii].value + '' == templateItem + '') {
                    return self.contentPieces()[ii];
                }
            }
            return null;
        }

        // handle event to allow showing a form that will get inputs.
        self.gatherFormInputs = function (templateItem) {

            var panel = new Boiler.ViewTemplate($('#forminputseditor'), template);
            panel.getDomElement().innerHtml = ''; //clear out old stuff

            var contentObject = self.findTemplateItemInContentPieces(templateItem);

            var itmvm = new ItemsModel(self.childContext);
            itmvm.initialize();
            itmvm.setItem(contentObject);
            ko.applyBindings(itmvm, panel.getDomElement());

            //get the script associated with this inputform and execute it
            var itmscript = new forminputseditor().getScript(templateItem);
            eval(itmscript);

            ////////////////////////
            var dialog = $(panel.getDomElement())  //$('#forminputseditor').html())
                    .find('.preview').html(contentObject.html).end()
                    .find('#insertItemButton')
                        .click(function (e) {
                            e.preventDefault();
                            var inserted = dialog.element.find('.preview')[0].innerHTML; //.val();
                            var editor = $("#Html_1_90").data("kendoEditor");

                            editor.clipboard.paste(inserted || "");

                            dialog.close();
                            $('#forminputseditor').html('');
                            editor.focus();

                        })
                    .end()

                    .kendoWindow({
                        actions: ["Close"],
                        modal: true,
                        title: 'Format',
                        deactivate: function () {
                            dialog.destroy();
                        }
                    }).data('kendoWindow');

            dialog.center().open();

        }

        self.fillFormBuilderItems = function () {
            $('#formBuilder').children().remove().end().append('<option selected value="-1">--select--</option>')
            $.each(self.contentPieces(), function (i, item) {
                $('#formBuilder').append($('<option>', {
                    value: item.value,
                    text: item.text
                }));
            });
        }

        self.SetupKendoEditor = function () {

            if (self.editor != null) {
                self.editor.destroy();
                $("#editordiv").html('<textarea rows="40" cols="80" class="input-block-level" id="Html_1_90" name="Html_1_90"></textarea>');
            }
            self.editor = $("#Html_1_90").kendoEditor({
                tools: ["bold", "italic", "underline", "strikethrough",
                "fontName", "fontSize", "foreColor", "backColor", "justifyLeft",
                "justifyCenter", "justifyRight", "justifyFull", "insertUnorderedList",
                "insertOrderedList", "indent", "outdent", "formatBlock", "createLink",
                "unlink", "insertImage", "subscript", "superscript",
            {
                name: "formBuilder",
                template: $("#formBuilder-template").html()
            },
                "viewHtml"
                ],
                value: self.html()

            });

            self.fillFormBuilderItems(); //knockout bindings aren't working for me in the template

            $("#formBuilder").kendoDropDownList({
                dataTextField: "text",
                dataValueField: "value",
                change: function (e) {
                    self.gatherFormInputs(e.sender.value());
                }
            });

            self.editor = $("#Html_1_90").data("kendoEditor");



        }

    };

    return ViewModel;
});

//                        ///////////http://www.kendoui.com/forums/ui/editor/inserthtml-from-datasource.aspx//////
//                        var selectBox = $(".k-insertHtml select").data("kendoSelectBox");
//                        if (selectBox) {
//                            selectBox.options.autoBind = false;
//                            selectBox.setDataSource(self.contentPieces());
//                            ko.applyBindings(self, $(".k-insertHtml select"));
//                        }

//                        selectBox.text("Insert Token");
//                       // selectBox.options.dataSource=data.contentPieces;
//                        ///////////////
//                        Used $(".k-insertHtml").hide(); to hide the insertHtml dropdown control. And linked another menu to this control.

//// https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&ved=0CDcQFjAB&url=http%3A%2F%2Fwww.kendoui.com%2Fforums%2Fui%2Feditor%2Fget-cursor-position-in-textbox.aspx&ei=nPBjUYGHEpXH4APmrYCACg&usg=AFQjCNFqQz-7MqTNk8Y8iNrsEnDdKlLQ9A
////When user clicks on a variable in the list menu, insert this variable in the mail text.
//function addMailVariableToBodyText(selected_item) {
//    var editor = $("[id$='_txtMailBody']").data("kendoEditor");
//    editor.exec("inserthtml", { value: " %" + selected_item.id + "% " });
//}


   
