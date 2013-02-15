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
    public class WrapperController : Controller
    {

        public JsonResult removeWrapper(int wrapperid)
        {
            string returnstr = WrapperRepository.removeWrapper(wrapperid);
            return Json(returnstr, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetwrapperById(int wrapperid)
        {
            MasterTemplate ct= WrapperRepository.GetWrapperById(wrapperid);
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

        public JsonResult save_wrapper_option(MasterTemplate mod)
        {
            MasterTemplate ct = WrapperRepository.CreateNewOrUpdateExistingWrapper(mod, User.Identity.Name);
            return Json(ct, JsonRequestBehavior.AllowGet);
        }
    }
}
