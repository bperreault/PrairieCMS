define(["Boiler"], function (Boiler) {

    var ViewModel = function (moduleContext) {

        var self = this;
        this.MenuSubmit = ko.observable(false);
        this.buttontext = ko.observable('Create this Menu Item');
        this.selectedItem = ko.observable();
        this.deleteVisible = ko.observable(false);


        this.errorMessage = ko.observable("");
        this.pkSiteMapItemID = ko.observable(-1);
        this.SiteMapItemName = ko.observable("");
        this.fkSiteMapParentId = ko.observable(-1);
        this.relativeUrl = ko.observable("");
        this.itemOrder = ko.observable(1);
        this.menuItemList = ko.observableArray([]);
        this.menuItemsInSubMenu = ko.observableArray([]);

        this.initialize = function () {
            self.pkSiteMapItemID(-1);
            self.SiteMapItemName("");
            self.relativeUrl("");
            self.fkSiteMapParentId(-1);
            self.itemOrder(1);
            self.MenuSubmit(false);
            self.deleteVisible(false);
            self.menuItemsInSubMenu([]);

            moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", '']);

            var url = moduleContext.getSettings().urls.menu_options;

            $.ajax({
                type: "GET",
                url: url,
                cache: false,
                contentType: 'application/x-www-form-urlencoded',
                dataType: 'json',
                success: function (data, status) {
                    self.MenuSubmit(true);
                    if (data.errorMessage) {
                        self.errorMessage(data.errorMessage);
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu Item Error: ' + data.errorMessage]);
                    }
                    else {
                        $("#adminTabs li:contains('Menus')").addClass("active");

                        self.menuItemList(data);
                    }
                }
            });
        };

        this.startOver = function () {
            self.initialize();
        }

        this.backToHome = function () {
            Boiler.UrlController.goTo("cms");
        }

        this.removeMenuItem = function () {
            if (self.pkSiteMapItemID === undefined || self.pkSiteMapItemID == -1) {
                moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'nothing selected']);
                return;
            }
            self.MenuSubmit(false);
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.menu_item_delete,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    menuid: self.pkSiteMapItemID
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

        this.getMenuItemById = function () {
            if (this.selectedItem()[0] === undefined) {
                moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'select something before trying to set menu']);
                return;
            }
            self.runServerRequestForMenuItem(this.selectedItem()[0].pkSiteMapItemID);
        };

        this.getMenuItemsFromList = function (dataitem) {
            if (!dataitem)
                return;

            self.runServerRequestForMenuItem(dataitem.pkSiteMapItemID);
        }
   
        this.getPageForEdit = function () {

            Boiler.UrlController.goTo("body/" + self.relativeUrl());
        }

        this.runServerRequestForMenuItem = function (menuid) {
            if (menuid == -1)
                return;
            self.MenuSubmit(false);
            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.menu_item_data,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    menuid: menuid
                }),
                dataType: 'json',
                success: function (data, status) {
                    self.MenuSubmit(true);
                    if (!data) {
                        self.errorMessage("No Data, an error occurred.");
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu Error: ' + self.errorMessage()]);
                        return;
                    }
                    if (data.errorMessage) {
                        self.errorMessage(data.errorMessage);
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu Error: ' + data.errorMessage]);
                    }
                    else {

                        self.deleteVisible(true);
                        self.SiteMapItemName(data.SiteMapItemName);
                        self.relativeUrl(data.relativeUrl);
                        self.fkSiteMapParentId(data.fkSiteMapParentId);
                        self.itemOrder(data.itemOrder);

                        self.setMenuId(data.pkSiteMapItemID);
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu: ' + self.SiteMapItemName()]);
                        self.buttontext("Save changes");

                        self.getSubMenuItems();

                    }
                }
            });
        };

        this.getSubMenuItems = function () {
            var url = moduleContext.getSettings().urls.menu_data;

            $.ajax({
                type: "POST",
                url: url,
                cache: false,
                contentType: 'application/x-www-form-urlencoded',
                data: { "menuid": this.selectedItem()[0].pkSiteMapItemID },
                success: function (data, status) {
                    self.MenuSubmit(true);
                    if (data.errorMessage) {
                        self.errorMessage(data.errorMessage);
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu Item(s) Error: ' + data.errorMessage]);
                    }
                    else {
                        self.menuItemsInSubMenu(data);
                    }
                }
            });
        };

        this.setMenuId = function (Menuid) {
            self.pkSiteMapItemID(Menuid);
            moduleContext.notify("Menu", Menuid);
            self.selectedItem(Menuid);
        }

        this.saveMenu = function () {
            self.MenuSubmit(false);
            if (self.SiteMapItemName() === '') {
                moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Please fill in Menu items before sending it out']);
                self.MenuSubmit(true);
                return;
            }
            var parent = self.fkSiteMapParentId()[0];
            if (!parent)
                parent = -1
            else
                parent = parent.pkSiteMapItemID;

            $.ajax({
                type: "POST",
                url: moduleContext.getSettings().urls.save_menu_option,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    pkSiteMapItemID: self.pkSiteMapItemID(),
                    SiteMapItemName: self.SiteMapItemName(),
                    fkSiteMapParentId: parent,
                    relativeUrl: self.relativeUrl(),
                    itemOrder: self.itemOrder()
                }),
                dataType: 'json',
                success: function (data, status) {
                    self.MenuSubmit(true);
                    if (data.errorMessage) {
                        self.errorMessage(data.errorMessage);
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Error Saving Menu: ' + data.errorMessage]);
                    }
                    else {
                        self.menuItemList.push(data);
                        self.setMenuId(data.pkSiteMapItemID);
                        moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'Menu: ' + self.SiteMapItemName()]);
                    }

                },
                error: function (data, status, e) {

                    self.MenuSubmit(true);
                    self.errorMessage(data.errorMessage);
                    moduleContext.notify("NOTIFICATION", ["#menuItemMessage1", 'An error occurred: ' + data.errorMessage]);
                }
            });

        };
    };

    return ViewModel;
});

