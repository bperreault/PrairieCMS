using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using PrairieCMS.Core.Models;

namespace PrairieCMS.Core.Controllers.FriendlyURLHandling
{
    public class FriendlyUrlRouteHandler : System.Web.Mvc.MvcRouteHandler
    {
        protected override IHttpHandler GetHttpHandler(System.Web.Routing.RequestContext requestContext)
        {
            var friendlyUrl = (string)requestContext.RouteData.Values["FriendlyUrl"];

            cmsModel page = null;
            string page1 = friendlyUrl;

            if (!string.IsNullOrEmpty(friendlyUrl))
                page = PageManager.GetPageByFriendlyUrl(friendlyUrl);

            if (page == null)
                page = PageManager.GetPageByFriendlyUrl("home");

            if (string.IsNullOrEmpty(friendlyUrl))
            {
                requestContext.RouteData.Values["controller"] = "Home";
                requestContext.RouteData.Values["action"] = "index";
            }
            else if (!string.IsNullOrEmpty( page.controller))
            {
                requestContext.RouteData.Values["controller"] = page.controller;
                requestContext.RouteData.Values["action"] = page.action;
            }
            else
            {
                requestContext.RouteData.Values["controller"] = getControllerFromUrl(friendlyUrl);
                page1 = getPageFromUrl( friendlyUrl);
                requestContext.RouteData.Values["action"] = page1;
            }

            requestContext.RouteData.Values["id"] = page1;

            return base.GetHttpHandler(requestContext);
        }
        protected string getPageFromUrl(string friendlyUrl)
        {
            string[] pieces = friendlyUrl.Split('/');
            if (pieces.Length == 1)
            {
               return "index";
            }
            return pieces[1];

        }
        protected string getControllerFromUrl(string friendlyUrl)
        {
            string[] pieces = friendlyUrl.Split('/');
            return pieces[0];
            
        }
    }
}
