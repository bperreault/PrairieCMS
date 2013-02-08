'use strict'; // avoid accidental global variable declarations

/*
 * Let's define short alias for commonly used AMD libraries and name-spaces. Using
 * these alias, we do not need to specify lengthy paths, when referring a child
 * files. We will 'import' these scripts, using the alias, later in our application.
 */
require.config({
	paths : {
		// requirejs plugins in use
		text : './libs/require/text',
		i18n : './libs/require/i18n',
		domReady : './libs/require/domReady',
		path :  './libs/require/path',
		// namespace that aggregate core classes that are in frequent use
		Boiler: './core/_boiler_',
        sbsBusyIndicator: './libs/sbsBusyIndicator/sbsBusyIndicator'
	}
});


require([ "./application", "domReady" ], function( Application, domReady) {
	domReady(function() {
		
		new Application();
	});
});
