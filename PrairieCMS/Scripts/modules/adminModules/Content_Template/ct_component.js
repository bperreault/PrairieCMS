define(['Boiler', 'text!./ct_view.html', './ct_viewmodel'],
function (Boiler, template, ViewModel) {

    var Component = function (moduleContext) {
        var panel, vm = null;

        this.activate = function (parent, params) {
            if (!panel) {
                vm = new ViewModel(moduleContext, params.id);
                panel = new Boiler.ViewTemplate(parent, template);
                vm.ContentName.subscribe(function (newValue) {
                   // alert(vm.ContentName());
                    //work to keep any spaces out
                    if (vm.ContentName().indexOf(" ") !== -1) {
                        vm.ContentName(vm.ContentName().replace(' ', '_'));
                    }
                });  
                ko.applyBindings(vm, panel.getDomElement());
            }
            vm.initialize(params.name);
            panel.show();
        };

        this.deactivate = function () {
            if (panel) {
                panel.hide();
            }
        }
    };

    return Component;

}); 