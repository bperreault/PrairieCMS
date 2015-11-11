using System;
using System.Linq;
using System.Collections.Generic;
using System.Reflection;
using System.Collections.Specialized;

namespace PrairiePluginLib
{
    public class PluginManager
    {
        public PluginManager()
        {
            Modules = new Dictionary<IModule, Assembly>();
        }

        private static PluginManager _current;
        public static PluginManager Current 
        { 
	        get { return _current ?? (_current = new PluginManager()); }
        }

    	internal Dictionary<IModule, Assembly> Modules { get; set; }

        public IEnumerable<IModule> GetModules()
        {
            return Modules.Select(m => m.Key).ToList();
        }

        public IModule GetModule(string name)
        {
            return GetModules().Where(m => m.Name == name).FirstOrDefault();
        }

        /// <summary>
        /// use this method to see if a plugged in module entry controller name matches
        /// the first part of the friendly url
        /// </summary>
        /// <param name="friendlyUrl"></param>
        /// <returns></returns>
        public static bool LocateIfModule(string friendlyUrl)
        {
            //check for this: (plugin supported public entry)friendlyUrl = "PrairieMessages.MessagesController.getSeriesForView"
            bool thisIsCallToModule = false;
            string[] parts = friendlyUrl.Split('.');
            if (parts.Length > 0)
            {
                var assembly = PluginManager.Current.GetModule(parts[0]);
                if (assembly != null)
                    thisIsCallToModule = true;
            }
            return thisIsCallToModule;
        }

        public string GetBridgedContent(string friendlyUrl, string json)
        {
            string[] parts = friendlyUrl.Split('.');
            if (parts.Length > 0)
            {
                var assembly = PluginManager.Current.GetModule(parts[0]);
                if (assembly != null)
                {
                    if (assembly == null)
                        return "Module " + parts[0] + " is not currently accessible.";
                    else
                        return assembly.GetRequestedContent(friendlyUrl, json);
                }
            }
            return friendlyUrl + " had no data";
        }

        public  string GetContentFromModule(string entryControllerName)
        {
            var assembly = PluginManager.Current.GetModule(entryControllerName);
            if (assembly == null)
                return "Module " + entryControllerName + " was not loaded.";
            else
                return assembly.GetHtml();
        }

        public string GetAdminHtml(string entryControllerName)
        {
            var assembly = PluginManager.Current.GetModule(entryControllerName);
            if (assembly == null)
                return "Module " + entryControllerName + " was not loaded.";
            else
                return assembly.GetAdminPages();
        }
        
    }
}
