using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Configuration;

namespace PrairieCMS.Core.Models
{
    public class cmsModel
    {
        public string title { get; set; }
        public string message { get; set; }
        public string tags { get; set; }
        [AllowHtml]
        public string html { get; set; }
        public string friendlyUrl { get; set; }
        public string controller { get; set; }
        public string action { get; set; }

        public cmsModel()
        {
            title = ConfigurationManager.AppSettings["AppTitle"];
            message = ConfigurationManager.AppSettings["AppMessage"];
        }
    }
}
