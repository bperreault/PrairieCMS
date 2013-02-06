using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PrairieCMS.Core.Models;
using PrairieCMS.Core;

namespace PrairieCMS.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            cmsModel cm = cmsRepository.HomeContent();
            return View(cm);
        }


        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}
