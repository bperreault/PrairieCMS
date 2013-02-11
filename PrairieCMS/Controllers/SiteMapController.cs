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


namespace PrairieCMS.Web.Controllers
{

    [Authorize(Roles = "admin")]
    public class SiteMapController : Controller
    {
        
        public JsonResult save_menu_option(cmsSiteMapItemBO mod)
        {
            cmsSiteMapItemBO ct = MenuRepository.editOrCreatecmsMenuItem(mod, User.Identity.Name);
            return Json(ct, JsonRequestBehavior.AllowGet);
        }
    }
}
