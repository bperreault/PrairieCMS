using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using DotNetOpenAuth.AspNet;
using Microsoft.Web.WebPages.OAuth;
using WebMatrix.WebData;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PrairieCMS.Filters;
using PrairieCMS.Models;
using PrairieCMS.Core;
using PrairieCMS.Core.Models;
using PrairiePluginLib;

namespace PrairieCMS.Web.Controllers
{

    [Authorize(Roles = "admin")]
    public class pluginController : Controller
    {
        /// <summary>
        /// returns a list of all installed modules
        /// </summary>
        /// <returns></returns>
         public JsonResult GetModules()
        {
            var modulesList = PluginManager.Current.GetModules();
            return Json(modulesList, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
         public JsonResult getPluginAdminPages(string EntryControllerName)
        {
            string adminhtml = PluginManager.Current.GetAdminHtml(EntryControllerName);
            return Json(adminhtml, JsonRequestBehavior.AllowGet);
        }
    }
}
