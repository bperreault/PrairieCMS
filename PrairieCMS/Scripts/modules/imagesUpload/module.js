define(['Boiler', './settings','./imagesUpload/iu_component'],


function (Boiler, settings,  ImagesComponent) {

    var Module = function(globalContext) {

        var context = new Boiler.Context(globalContext);
        context.addSettings(settings);

        var controller = new Boiler.UrlController($(".imageuploader"));
        controller.addRoutes({
           
            "/": new ImagesComponent(context)
        });
        controller.start();
    };

    return Module;

});
