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
    public class formDataController : Controller
    {
        public JsonResult GetContent(int companyid)
        {
            List<ContentModel> ct = ContentRepository.GetExistingContent( companyid );
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetWrappers( int companyid )
        {
            List<MasterTemplate> ct =  ContentRepository.GetExistingTemplates( companyid );
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPackages(int companyid)
        {
            List<cmsPageMap> ct = ContentRepository.GetExistingMCMs(companyid);
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

    }
}
