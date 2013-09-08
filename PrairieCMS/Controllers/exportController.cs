#region using
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
using System.IO;
using System.Text;
#endregion

namespace PrairieCMS.Web.Controllers
{

    [Authorize(Roles = "admin")]
    public class exportController : Controller
    {
        /// <summary>
        /// create a zip file containing .html content of all active content and send the contents of the zip file to the browser
        /// </summary>
        /// <param name="fileLocation"></param>
        /// <returns></returns>
        public void createHtmlContent()
        {
            string zipfilename = ExportRepository.ExportPages();
            FileInfo fi = new FileInfo( zipfilename);
            HttpContext.Response.TransmitFile(zipfilename, 0, fi.Length);
        }
       
        public void page()
        {
            string contentname = RouteData.Values["id"].ToString();
            cmsModel cms = new cmsModel();
            try
            {
                cms = new cmsRepository().PageContent(contentname);
            }
            catch (Exception exp)
            {
                HttpContext.Response.ContentType = "text/plain";
                HttpContext.Response.Write(exp.ToString()); 
            }
            HttpContext.Response.ContentType = "text/html";
            HttpContext.Response.Write( cms.html);                              
        }
    }
}
