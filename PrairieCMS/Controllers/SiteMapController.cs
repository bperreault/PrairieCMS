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

        public JsonResult removeMenuItem(int menuid)
        {
            string returnstr = MenuRepository.removeMenuItem(menuid);
            return Json(returnstr, JsonRequestBehavior.AllowGet);
        }

        public JsonResult getMenuItem(int menuid)
        {
            cmsSiteMapItemBO ct = MenuRepository.getMenuItem(menuid);
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMenuById(int menuid)
        {
            List<cmsSiteMapItemBO> ct = MenuRepository.GetMenuById(menuid);
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

        public JsonResult save_menu_option(cmsSiteMapItemBO mod)
        {
            cmsSiteMapItemBO ct = MenuRepository.editOrCreatecmsMenuItem(mod, User.Identity.Name);
            return Json(ct, JsonRequestBehavior.AllowGet);
        }
    }
}
