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
    public partial class webpages_Roles
    {
        public webpages_Roles()
        {
            this.cmsContent_Type_Mapping = new HashSet<cmsContent_Type_Mapping>();
            this.Users = new HashSet<User>();
            this.cms_Page_Map = new HashSet<cms_Page_Map>();
        }
    
        public int RoleId { get; set; }
        public string RoleName { get; set; }
    
        public virtual ICollection<cmsContent_Type_Mapping> cmsContent_Type_Mapping { get; set; }
        public virtual ICollection<User> Users { get; set; }
        public virtual ICollection<cms_Page_Map> cms_Page_Map { get; set; }
    }
    
}
