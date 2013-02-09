using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PrairieCMS.Core;
using PrairieCMS.Core.Models;

namespace PrairieCMS.Controllers
{

     [Authorize(Roles = "admin")]
    public class cmsController : Controller
    {

         public ActionResult Index()
         {
             cmsModel im = new cmsModel();
             return View(im);

         }

       
    }
}
