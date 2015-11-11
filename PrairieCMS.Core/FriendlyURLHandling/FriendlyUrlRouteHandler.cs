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
            PageManager pm = new PageManager();

 
            if (!string.IsNullOrEmpty(friendlyUrl))
            {
                //check for this: (plugin supported public entry)friendlyUrl = "PrairieMessages.MessagesController.getSeriesForView"
                bool thisIsCallToModule = PrairiePluginLib.PluginManager.LocateIfModule(friendlyUrl);
                if (thisIsCallToModule)
                {
                    page = new cmsModel() { controller = "Home", action = "bridge" };
                }
                else
                {
                    page = pm.GetPageNoContentByFriendlyUrl(friendlyUrl);
                }
            }

            if (page == null && !hasController(friendlyUrl))
                page = pm.GetPageNoContentByFriendlyUrl("home");

            if (string.IsNullOrEmpty(friendlyUrl))
            {
                requestContext.RouteData.Values["controller"] = "Home";
                requestContext.RouteData.Values["action"] = "index";
                return base.GetHttpHandler(requestContext);
            }
            else if (page != null && !string.IsNullOrEmpty( page.controller))
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

            requestContext.RouteData.Values["id"] = getIdFromUrl(friendlyUrl);

            return base.GetHttpHandler(requestContext);
        }

        bool hasController(string friendlyUrl)
        {
            if (string.IsNullOrEmpty(friendlyUrl))
                return false;

            if (friendlyUrl.IndexOf("/") < 1 && friendlyUrl.Contains("."))
                return false; //bridge

            return true;
        }

        protected string getIdFromUrl(string friendlyUrl)
        {
            string[] pieces = friendlyUrl.Split('/');
            
            return pieces[pieces.Length - 1];

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
