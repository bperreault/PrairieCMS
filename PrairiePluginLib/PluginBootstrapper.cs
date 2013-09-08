namespace PrairiePluginLib
{
    public static class PluginBootstrapper
    {
        static PluginBootstrapper()
        {
	        
        }

        public static string GetContentFromModule(string entryControllerName)
        {
            var assembly = PluginManager.Current.GetModule(entryControllerName);
            if (assembly == null)
                return "Module " + entryControllerName + " was not loaded.";
            else
                return assembly.GetHtml();
        }

    	public static void Initialize()
        {
            foreach (var module in PluginManager.Current.Modules.Keys)
            {
                var assembly = PluginManager.Current.Modules[module];
                //ApplicationPartRegistry.Register(PluginManager.Current.Modules[module]);

                //Calling install on module, to register dependencies
                module.Install();

                //// Controllers registration from the plugin assembly
                //var container = Microsoft.Practices.ServiceLocation.ServiceLocator.Current
                //    .GetInstance<Castle.Windsor.IWindsorContainer>();

                //container.Register(Castle.MicroKernel.Registration.AllTypes
                //    .Of<System.Web.Mvc.IController>()
                //    .FromAssembly(assembly).LifestyleTransient());
            }
        }
    }
}
