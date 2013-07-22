using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Linq;

namespace PrairieCMS.Core.Models
{
    public class cmsActionNotification
    {
        public string errorMessage { get; set; }
        public string successMessage { get; set; }
    }
}
