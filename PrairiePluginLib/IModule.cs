using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections.Specialized;
using System.Text;

namespace PrairiePluginLib
{
    //http://www.codeproject.com/Articles/358360/NET-4-0-ASP-NET-MVC-3-plug-in-architecture-with-e
    public interface IModule
    {
        /// <summary>
        /// Title of the plugin, can be used as a property to display on the user interface
        /// </summary>
        string Title { get; }

        /// <summary>
        /// Name of the plugin, should be an unique name
        /// </summary>
        string Name { get; }

        /// <summary>
        /// Version of the loaded plugin
        /// </summary>
        Version Version { get; }

        /// <summary>
        /// Entry controller name
        /// </summary>
        string EntryControllerName { get; }

        /// <summary>
        /// Installs the plugin with all the scripts, css and DI 
        /// </summary>
        void Install();
        string GetHtml();
        string GetRequestedContent(string friendlyUrl, string json);
        string GetAdminPages();
    }
}
