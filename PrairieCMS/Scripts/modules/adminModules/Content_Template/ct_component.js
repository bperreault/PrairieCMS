define(['Boiler', 'text!./ct_view.html', './ct_viewmodel'], 
function (Boiler, template, ViewModel) {

	var Component = function(moduleContext) {
	    var panel, vm = null;

		this.activate = function(parent, params) {
			if(!panel) {
                vm = new ViewModel(moduleContext, params.id);
                panel = new Boiler.ViewTemplate(parent, template);

                ko.applyBindings(vm, panel.getDomElement());
            }
            vm.initialize(params.name);
			panel.show();
		};

		this.deactivate = function() {
			if (panel) {
				panel.hide();
			}
		}
};

	return Component;

}); 