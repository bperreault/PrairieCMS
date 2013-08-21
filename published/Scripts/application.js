
define(["Boiler", "./settings", "./modules/modules"], function (Boiler, settings, moduleContexts) {

    var Application = function () {
        var appContext = new Boiler.Context();

        appContext.addSettings(settings);

        appContext.loadChildContexts(moduleContexts);

        appContext.listen("NOTIFICATION", function (div) {
            $("#globalMessage").html(div[1]);
            if (div[1] != '')
                toastr.info(div[1]);
        });
        appContext.listen("CONTENT", function (contentid) {
            appContext.getSettings().contentid = contentid;
        });
        appContext.listen("LIST", function (listid) {
            appContext.getSettings().listid = listid;
        });
        appContext.listen("MCM", function (mcmid) {
            appContext.getSettings().mcmid = mcmid;
        });
        appContext.listen("WRAPPER", function (wrapperid) {
            appContext.getSettings().wrapperid = wrapperid;
        });

        $("#adminTabs li a").on("click", function () {
            $(this).parent().parent().find("li").removeClass("active");
            $(this).parent().addClass("active");
        });

//////        //note:at this time (2/2/13) ConfigureImageUploaders will not work unless the dom element is in the page on page load.
//////        //need to do this using knockout kendo and in the html. see golf whisperer
//////        this.ConfigureImageUploaders = function (sender, args) {
//////            $('#files').kendoUpload({
//////                multiple: true,
//////                showFileList: true,
//////                async: {
//////                    saveUrl: moduleContext.getSettings().urls.image_uploadUrl
//////                },
//////                error:  function (e) {
//////                    sbsBusyIndicator.hideBusy();
//////                    if (e.operation == 'upload' && e.response != '0') {
//////                        self.responsetext(e.response);
//////                        self.src('')
//////                        self.imgVisible(false);
//////                        self.src(e.response);
//////                        self.imgVisible(true);
//////                        if ($('#modal-scroll-container').length) {
//////                            $('#modal-scroll-container').tinyscrollbar_update('relative');
//////                        }

//////                    }

//////                },
//////                complete: function (e) {
//////                    sbsBusyIndicator.hideBusy();
//////                    if (e.operation == 'upload' && e.response != '0') {
//////                        self.responsetext(e.response);
//////                        self.src('')
//////                        self.imgVisible(false);
//////                        self.src(e.response);
//////                        self.imgVisible(true);
//////                        if ($('#modal-scroll-container').length) {
//////                            $('#modal-scroll-container').tinyscrollbar_update('relative');
//////                        }

//////                    }

//////                }
//////            });

//////        }
    };

    return Application;
});
