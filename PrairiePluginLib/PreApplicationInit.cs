using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web.Hosting;
using System.Reflection;
using System.Web.Compilation;


namespace PrairiePluginLib
{
    public class PreApplicationInit
    {
        static PreApplicationInit()
        {
            string pluginsPath = HostingEnvironment.MapPath("~/plugins");
            string pluginsTempPath = HostingEnvironment.MapPath("~/plugins/temp");

            if (pluginsPath == null || pluginsTempPath == null)
                throw new DirectoryNotFoundException("plugins");

            PluginFolder = new DirectoryInfo(pluginsPath);
            TempPluginFolder = new DirectoryInfo(pluginsTempPath);
        }
        
        /// <summary>
        /// The source plugin folder from which to copy from
        /// </summary>
        private static readonly DirectoryInfo PluginFolder;
        /// <summary>
        /// The folder to copy the plugin DLLs to use for running the application
        /// </summary>
        private static readonly DirectoryInfo TempPluginFolder;

        /// <summary>
        /// Initialize method that registers all plugins
        /// </summary>
        public static void InitializePlugins()
        {
            Directory.CreateDirectory(TempPluginFolder.FullName);

            //clear out plugins
            foreach (var f in TempPluginFolder.GetFiles("*.dll", SearchOption.AllDirectories))
            {
                f.Delete();
            }

            //copy files
            foreach (var plug in PluginFolder.GetFiles("*.dll", SearchOption.AllDirectories))
            {
                var di = Directory.CreateDirectory(TempPluginFolder.FullName);
                File.Copy(plug.FullName, Path.Combine(di.FullName, plug.Name), true);
            }

            //This will put the plugin assemblies in the 'Load' context
            var assemblies = TempPluginFolder.GetFiles("*.dll", SearchOption.AllDirectories)
                    .Select(x => AssemblyName.GetAssemblyName(x.FullName))
                    .Select(x => Assembly.Load(x.FullName));

            foreach (var assembly in assemblies)
            {
                Type type = assembly.GetTypes()
                                    .Where(t => t.GetInterface(typeof(IModule).Name) != null).FirstOrDefault();
                if (type != null)
                {
                    //Add the plugin as a reference to the application
                    BuildManager.AddReferencedAssembly(assembly);

                    //Add the modules to the PluginManager to manage them later
                    var module = (IModule)Activator.CreateInstance(type);
                    PluginManager.Current.Modules.Add(module, assembly);
                }
            }
        }
    }
}
