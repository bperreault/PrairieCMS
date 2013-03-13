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
    public partial class cms_Page_Map
    {
        public cms_Page_Map()
        {
            this.cmsContent_Type_Mapping = new HashSet<cmsContent_Type_Mapping>();
        }
    
        public int pkMapID { get; set; }
        public string pageName { get; set; }
        public int fkMasterThemeID { get; set; }
        public int fkEditorRoleID { get; set; }
        public System.DateTime createdOn { get; set; }
        public string createdBy { get; set; }
        public System.DateTime modifiedOn { get; set; }
        public string modifiedBy { get; set; }
        public string pageTitle { get; set; }
        public string tags { get; set; }
        public Nullable<bool> isActive { get; set; }
        public int fkContentID { get; set; }
    
        public virtual Master_Template Master_Template { get; set; }
        public virtual webpages_Roles webpages_Roles { get; set; }
        public virtual ICollection<cmsContent_Type_Mapping> cmsContent_Type_Mapping { get; set; }
        public virtual Content_Template Content_Template { get; set; }
    }
    
}
