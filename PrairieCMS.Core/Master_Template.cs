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
    public partial class Master_Template
    {
        public Master_Template()
        {
            this.cmsSiteSetups = new HashSet<cmsSiteSetup>();
            this.cmsSiteSetups1 = new HashSet<cmsSiteSetup>();
            this.cms_Page_Map = new HashSet<cms_Page_Map>();
        }
    
        public int pkMasterID { get; set; }
        public string themeName { get; set; }
        public string html { get; set; }
        public int fkBelongsTo { get; set; }
        public System.DateTime createdOn { get; set; }
        public string createdBy { get; set; }
        public System.DateTime modifiedOn { get; set; }
        public string modifiedBy { get; set; }
        public string markDown { get; set; }
    
        public virtual ICollection<cmsSiteSetup> cmsSiteSetups { get; set; }
        public virtual ICollection<cmsSiteSetup> cmsSiteSetups1 { get; set; }
        public virtual ICollection<cms_Page_Map> cms_Page_Map { get; set; }
    }
    
}
