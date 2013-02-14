using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace PrairieCMS.Core.Models
{
    public class cmsSiteMapItemBO
    {
        public string errorMessage { get; set; }
        public int pkSiteMapItemID { get; set; }
	    public string SiteMapItemName { get; set; }
	    public int fkSiteMapParentId { get; set; }
	    public string relativeUrl { get; set; }
        public int itemOrder { get; set; }
    }
}
