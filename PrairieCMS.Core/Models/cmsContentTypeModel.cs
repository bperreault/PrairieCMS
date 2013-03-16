using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PrairieCMS.Core.Models
{
    public class cmsContentTypeModel
    {
       public int pkContentTypeId{set;get;}
      public string contentName{set;get;}
      public int fkLevelMappingId{set;get;}
      public string templateHtml{set;get;}
      public string errorMessage { set; get; }
    }
}
