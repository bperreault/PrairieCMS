using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PrairieCMS.Core;
using PrairieCMS.Core.Models;

namespace PrairieCMS.Controllers
{

    [Authorize]
    public class cmsController : Controller
    {       

        [AllowAnonymous]
        public ActionResult Home()
        {
            cmsModel cm = cmsRepository.HomeContent();
            return View(cm);
        }

       
    }
}
