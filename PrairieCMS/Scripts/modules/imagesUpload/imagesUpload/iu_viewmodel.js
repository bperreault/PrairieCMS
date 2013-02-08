define(["Boiler", "sbsBusyIndicator"], function (Boiler, sbsBusyIndicator) {

    var ViewModel = function (moduleContext) {

        var self = this;
        this.responsetext = ko.observable();
        this.hiddenField = ko.observable();
        this.src = ko.observable();
        this.imgVisible = ko.observable(false);
        this.files = ko.observable();

        this.initialize = function () {
           
        };

        this.removeImage = function () {
            hiddenField("0");
            src("");
            imgVisible(false);
        };

//        //note:at this time (2/2/13) ConfigureImageUploaders will not work unless the dom element is in the page on page load.
//        //
        this.ConfigureImageUploaders = function (sender, args) {
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
                        self.imgVisible(false);
                        self.src(e.XMLHttpRequest.responseText);
                        self.imgVisible(true);
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
