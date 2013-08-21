define(['Boiler', 'text!./iu_view.html', './iu_viewmodel'], 
function(Boiler, viewText, ViewModel) {
	var Component = function(context) {

		var panel, vm = null;

		this.activate = function(parent, params) {
			if (!panel) {
			    vm = new ViewModel(context);
			    vm.initialize();
				panel = new Boiler.ViewTemplate(parent, viewText);
				ko.applyBindings(vm, panel.getDomElement());
			}
            panel.show();

            //call configure image uploaders here because they have been added to the dom and it only works if they're present
            //OH, NEVERMIND. ONLY WORKS IN I.E.  MOVING IT BACK TO THE INDEX.CHTML FILE
           vm.ConfigureImageUploaders(null, null);
		};

		this.deactivate = function() {
			if (panel) {
				panel.hide();
			}

		};

	};

	return Component;
});
