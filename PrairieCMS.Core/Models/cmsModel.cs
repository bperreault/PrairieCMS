using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Configuration;
using System.IO;

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

        public string WriteOut(string dirlocation)
        {
            var filename = Path.Combine(dirlocation , friendlyUrl + ".html");

            using (var file = new StreamWriter( filename ))
            {
                html = html.Replace("{form_submit_message}", "");
                file.Write(html);
                file.Flush();
                file.Close();
            }
            return filename;
        }
    }
}
