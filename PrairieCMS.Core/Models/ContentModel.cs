using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Linq;

namespace PrairieCMS.Core.Models
{
    public class ContentSelectionItems {
        public int ContentId { get; set; }
        public string ContentName { get; set; }
        public int ParentMenuId { get; set; }
        public int MenuId { get; set; }
        public string listClass { get; set; }
    }
    public class FormSelectionItems { //text: "label 2", value:
        public string text { get; set; }
        public string value { get; set; }
        public string html { get; set; }
        public string inputForm { get; set; }
    }
    public class FormDataItems {
        public List<ContentSelectionItems> contentList { set; get; }
        public List<FormSelectionItems> contentPieces { set; get; }
    }
    public class ContentModel
    {
        //combines both cms_Page_Map and ContentTemplate
        public int cmsPageMapId { get; set; }
      public int pkMapID {get;set;}      
      public int pkBcId { get; set; } //content type mapping id if there is one for this model.
      public string pageName {get;set;}
      public int fkMasterThemeID {get;set;}
      public int fkEditorRoleID {get;set;}
      public int fkLevelMappingId { get; set; }
      public string pageTitle {get;set;}
      public string tags {get;set;}
      public bool isActive {get;set;}
        public int ContentId { get; set; }
        public string ContentName { get; set; }
        public string ContentHtml { get; set; }
        public string errorMessage { get; set; }
        public List<cmsContentTypeMapping> contentTypeMappings { get; set; }
        public cmsPageMap pagemap { get; set; }
    }
}
