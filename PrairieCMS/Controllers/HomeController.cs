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
using PrairieCMS.Core.Events;
using FormSystem;
using PrairiePluginLib;
using System.IO;


namespace PrairieCMS.Controllers
{
    public class HomeController : Controller
    {
        [AllowAnonymous]
        public ActionResult Index(string id="")
        {
            cmsModel cm = null;
            string message = string.Empty;
            if (Request.Form.AllKeys != null 
                && Request.Form.AllKeys.Length > 0 
                && Request.Form.AllKeys[0] != null)
            {
                //EmailRepository.SendFormByEmail( Request.Form, id );
               
                message = FormProcessor.ProcessForm(Request.Form, id, true, false); //send email and record at dcmlfs if supported

                if (message.Equals( "Thank-you, your information has been recorded." ))
                     message = "<p style='color:#ff0000;'>Thank-you, the answers have been saved.</p>";

            }
            cmsRepository cms = new cmsRepository();
            if (!string.IsNullOrWhiteSpace(id))
            {
                cm = cms.PageContent(id);
            }
            else
            {
                cm = cms.HomeContent();
            }

            cm.html = cm.html.Replace("{form_submit_message}", message);
            
            return View(cm);
        }

        [AllowAnonymous]
        public ActionResult pages()
        {
            var allPaths = Request.Path;
            cmsModel cm = new cmsRepository().PageContent(allPaths);
            if (cm.html == string.Empty)
            {

            }
            return View(cm);
        }

        [AllowAnonymous]
        public ActionResult Handle()
        {
            var allPaths = Request.Path;
            cmsModel cm = new cmsRepository().PageContent(allPaths);
            if (cm.html == string.Empty)
            {

            }
            return View(cm);
        }

        [AllowAnonymous]
        public JsonResult bridge()
        {
            var friendlyUrl = HttpContext.Request.RawUrl;
            if (friendlyUrl.StartsWith("/"))
                friendlyUrl = friendlyUrl.Substring(1);
            string json;
            using (var reader = new StreamReader(Request.InputStream))
            {
                json = reader.ReadToEnd();
            }
            string dataReturn = PluginManager.Current.GetBridgedContent(friendlyUrl, json);
            return Json(dataReturn, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Occurs when the page is being served to the output stream.
        /// </summary>
        public static event EventHandler<ServingEventArgs> Serving;
        /// <summary>
        /// Raises the event in a safe way
        /// </summary>
        public static void OnServing(HomeController comment, ServingEventArgs arg)
        {
            if (Serving != null)
            {
                Serving(comment, arg);
            }
        }

        /// <summary>
        /// Raises the Serving event
        /// </summary>
        public void OnServing(ServingEventArgs eventArgs)
        {
            if (Serving != null)
            {
                Serving(this, eventArgs);
            }
        }


    }
}
