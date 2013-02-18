﻿using System;
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

namespace PrairieCMS.Controllers
{

    [Authorize(Roles = "admin")]
    public class ContentController : Controller
    {
       
        public ActionResult editcontent(ContentModel mod)
        {
            ContentModel ct = ContentRepository.CreateNewOrUpdateExistingContent(mod, User.Identity.Name);
            return Json(ct, JsonRequestBehavior.AllowGet);
        }

        public JsonResult removeContentItem(int menuid)
        {
            string returnstr = ContentRepository.removeContentItem(menuid);
            return Json(returnstr, JsonRequestBehavior.AllowGet);
        }
        
    }
}