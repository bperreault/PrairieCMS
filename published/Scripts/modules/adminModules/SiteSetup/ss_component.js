define(['Boiler', 'text!./ss_view.html', "./ss_viewmodel"], 
function(Boiler, template, ViewModel) {

	var Component = function(moduleContext) {
	    var panel, vm = null;

	    this.activate = function (parent, params) {
	        if (!panel) {
	            panel = new Boiler.ViewTemplate(parent, template);
	            vm = new ViewModel(moduleContext);
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