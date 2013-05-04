using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PrairieCMS.Core.Models;


namespace PrairieCMS.Core
{
    public class cmsRepository
    {

            public static cmsModel PageContent( string path)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cms_Page_Map.Where(r => r.pageName.Equals(path)).FirstOrDefault();
            cmsModel one = new cmsModel();
            one.html = ObtainHtmlFromMap(obj, cr);
            if (obj != null)
            {
                one.tags = obj.tags;
                one.title = obj.pageTitle;
                one.controller = "home";
                one.action = "index";
            }
            else
            {
                one.html = GetStarterHtml();
                one.title = "Let's get started";
                one.controller = string.Empty;
                one.action = string.Empty;
            }

            one.friendlyUrl = path;

            return one;
        
        }



        //view cms
        public static cmsModel HomeContent()
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cms_Page_Map.Where(r => r.pageName.Equals("home")).FirstOrDefault();
            cmsModel one = new cmsModel();
            one.html = ObtainHtmlFromMap(obj, cr);
            if (obj != null)
            {
                one.tags = obj.tags;
                one.title = obj.pageTitle;
            }
            else
            {
                one.html = GetStarterHtml();
                one.title = "Let's get started";
            }
            return one;
        
        }
        
        public static string GetStarterHtml()
        {
            return "<html><title></title><body><a href='cms'>Admin</a></body></html>";
        }
       
        //!!!!was!!!!!!getting duplicates in [cms_Page_Map] which means below ctm was first or default - 
        //mt is needing last or default. that's why I pull the list then get the last one.
        public static string ObtainHtmlFromMap(cms_Page_Map mp, cmsEntities cr)
        {
            try
            {
                List<cmsContent_Type_Mapping> ctm = cr.cmsContent_Type_Mapping.Where(b => b.fkParent == mp.pkMapID).ToList();
               List<Master_Template> allmatches = cr.Master_Template.Where(c => c.pkMasterID == mp.fkMasterThemeID).ToList();
                 if (allmatches.Count == 0)
                     return null;
                Master_Template mt = allmatches[ allmatches.Count-1];
                if (mt == null)
                    return null;
                StringBuilder sb = new StringBuilder();
                for (int ii = 0; ii < ctm.Count; ii++)
                {
                    int fkcontent = (int)ctm[ii].fkContent;
                    Content_Template ct = cr.Content_Template.Where(b => b.pkContentID == fkcontent).FirstOrDefault();
                    sb.Append(ct.html);
                }
                //this needs to get all the content referenced by the page map id from content_type_mapping
                // and place the content into the master template in the proper referenced DOM items
                string body = sb.ToString();
                body = mt.html.Replace("{content_template}", body);
                if (body.Contains("{menu_component}"))
                {
                    body = body.Replace("{menu_component}", MenuRepository.GetTopLevelMenusHtml());
                }
                return body;
            }
            catch (Exception exp)
            {
                LogRepository.SaveEntry("cmsRepository.ObtainHtmlFromMap", exp.ToString(), true);
                return string.Empty;
            }
        }
    }
}
