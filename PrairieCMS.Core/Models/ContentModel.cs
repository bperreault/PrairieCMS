using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Linq;

namespace PrairieCMS.Core.Models
{
    public class ContentModel
    {
        public int ContentId { get; set; }
        public string ContentName { get; set; }
        public string ContentHtml { get; set; }
        public string errorMessage { get; set; }
    }
}
