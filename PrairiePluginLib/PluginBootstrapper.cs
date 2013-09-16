using System.Collections.Specialized;

namespace PrairiePluginLib
{
    public static class PluginBootstrapper
    {
        static PluginBootstrapper()
        {
	        
        }
        
    	public static void Initialize()
        {
            foreach (var module in PluginManager.Current.Modules.Keys)
            {
                var assembly = PluginManager.Current.Modules[module];

                //Calling install on module, to register dependencies
                module.Install();

            }
        }
    }
}
