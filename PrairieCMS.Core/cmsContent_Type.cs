//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

namespace PrairieCMS.Core
{
    public partial class cmsContent_Type
    {
        public cmsContent_Type()
        {
            this.cmsContent_Type_Mapping = new HashSet<cmsContent_Type_Mapping>();
        }
    
        public int pkContentTypeId { get; set; }
        public string contentName { get; set; }
        public Nullable<int> fkLevelMappingId { get; set; }
        public string templateHtml { get; set; }
        public string inputForm { get; set; }
    
        public virtual cmsLevel_Mapping cmsLevel_Mapping { get; set; }
        public virtual ICollection<cmsContent_Type_Mapping> cmsContent_Type_Mapping { get; set; }
    }
    
}
