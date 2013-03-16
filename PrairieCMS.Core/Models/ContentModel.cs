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
    {/*      * 
            Enter a name for this Page<br />
            contentName

            Select the Wrapper for your page
            selectedWrapper

            Enter a title for this Page
            pageTitle

            Select the role of people who can edit this page<br />
            editorRole

            Enter tags for this page
            tags

            Enter the html for your page.
            html"
             */
        //combines both cms_Page_Map and ContentTemplate
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
