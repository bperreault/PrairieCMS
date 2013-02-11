using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using DotNetOpenAuth.AspNet;
using Microsoft.Web.WebPages.OAuth;
using WebMatrix.WebData;
using PrairieCMS.Filters;
using PrairieCMS.Core.Models;
using PrairieCMS.Core;


namespace PrairieCMS.Controllers
{
    public class HomeController : Controller
    {
        [AllowAnonymous]
        public ActionResult Index()
        {
            cmsModel cm = cmsRepository.HomeContent();
            if (cm.html == string.Empty)
            {
             
            }
            return View(cm);
        }

        
    }
}
