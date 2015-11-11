using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using PrairieCMS.Core.Controllers.FriendlyURLHandling;

namespace PrairieCMS
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.IgnoreRoute("images/{*pathInfo}");

            //routes.MapRoute(
            //    name: "cms",
            //    url: "{controller}/{action}/{id}",
            //    defaults: new { controller = "cms", action = "Index", id = UrlParameter.Optional }
            //);

            routes.MapRoute(
                  "Default",
                  "{*FriendlyUrl}"
                 ).RouteHandler = new FriendlyUrlRouteHandler();
        }
    }
}