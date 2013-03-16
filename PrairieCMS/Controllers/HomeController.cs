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
        public ActionResult Index(string id="")
        {
            cmsModel cm = null;
            if (!string.IsNullOrWhiteSpace(id))
            {
                cm = cmsRepository.PageContent(id);
            }
            else
            {
                cm = cmsRepository.HomeContent();
            }

            return View(cm);
        }

        [AllowAnonymous]
        public ActionResult pages()
        {
            var allPaths = Request.Path;
            cmsModel cm = cmsRepository.PageContent(allPaths);
            if (cm.html == string.Empty)
            {

            }
            return View(cm);
        }

        [AllowAnonymous]
        public ActionResult Handle()
        {
            var allPaths = Request.Path;
            cmsModel cm = cmsRepository.PageContent(allPaths);
            if (cm.html == string.Empty)
            {

            }
            return View(cm);
        }
    }
}
