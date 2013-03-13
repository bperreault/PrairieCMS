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
        //cms_page_map
        public JsonResult GetContent()
        {
            List<ContentModel> ct = ContentRepository.GetExistingContent(  );
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetWrappers(  )
        {
            List<MasterTemplate> ct =  WrapperRepository.GetExistingTemplates(  );
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPackages()
        {
            List<cmsPageMap> ct = ContentRepository.GetExistingMCMs();
            return Json(ct, JsonRequestBehavior.AllowGet);
        }
        
        public JsonResult getmenus()
        {
            List<cmsSiteMapItemBO> ct = MenuRepository.GetTopLevelMenus();
            return Json(ct, JsonRequestBehavior.AllowGet);
        }
          
        
    }
}
