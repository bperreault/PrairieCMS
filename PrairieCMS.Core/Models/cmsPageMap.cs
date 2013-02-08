using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Linq;

namespace PrairieCMS.Core.Models
{
    public class cmsPageMap
    {
        public int cmsPageMapId { get; set; }
        public string pageName { get; set; }
        public int MasterId { get; set; }
        public int fkEditorRoleID { get; set; }
        public int ContentId { get; set; }
        public string tags { get; set; }
        public string pageTitle { get; set; }
        public string errorMessage { get; set; }
    }
}
