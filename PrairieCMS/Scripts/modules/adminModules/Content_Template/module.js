define(['Boiler', './forms/fd_component'],


function (Boiler,  formItemComponent) {

    var Module = function(globalContext) {

        var context = new Boiler.Context(globalContext);

        var controller = new Boiler.UrlController($("#forminputseditor"));
        
        controller.start();
    };

    return Module;

});
