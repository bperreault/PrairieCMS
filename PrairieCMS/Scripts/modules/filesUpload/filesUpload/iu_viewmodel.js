define(["Boiler", "sbsBusyIndicator"], function (Boiler, sbsBusyIndicator) {

    var ViewModel = function (moduleContext) {

        var self = this;
        self.responsetext = ko.observable();
        self.hiddenField = ko.observable();
        self.src = ko.observable();
        self.imgVisible = ko.observable(false);
        self.files = ko.observable();
        self.copyHref = ko.observable('javascript:copyToClipboard');
        self.urlVisibility = ko.observable("notBusy");

        self.initialize = function () {

        };

        self.copyToClipboard = function () {

            var text = $('#picurl').text();
            window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
        }

        self.removeImage = function () {
            self.hiddenField("0");
            self.src("");
            self.urlVisibility("notBusy");
            self.imgVisible(false);
        };

        //        //note:at this time (2/2/13) ConfigureImageUploaders will not work unless the dom element is in the page on page load.
        //        //
        self.ConfigureImageUploaders = function (sender, args) {
            $('#files').kendoUpload({
                multiple: true,
                showFileList: false,
                async: {
                    saveUrl: moduleContext.getSettings().urls.image_uploadUrl
                },
                error: function (e) { //it's returning error when there is none.
                    sbsBusyIndicator.hideBusy();
                    if (e.operation == 'upload' && e.response != '0') {
                        self.responsetext(e.response);
                        self.src('')
                        self.urlVisibility("notBusy");
                        self.imgVisible(false);
                        var imgFileName = e.XMLHttpRequest.responseText;
                        self.src(imgFileName);
                        if (imgFileName.indexOf('mages/') > 0) //only if path has images in it.
                            self.imgVisible(true);
                        self.urlVisibility("busy");
                        if ($('#modal-scroll-container').length) {
                            $('#modal-scroll-container').tinyscrollbar_update('relative');
                        }

                    }
                },
                complete: function (e) {


                }
            });

        }

    };

    return ViewModel;
});
