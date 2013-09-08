using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PrairieCMS.Core.Models;


namespace PrairieCMS.Core
{
    public class cmsRepository
    {

        public cmsModel PageContent( string path)
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
        public cmsModel HomeContent()
        {
            return new cmsRepository().PageContent("home");
        }
        
        public static string GetStarterHtml()
        {
            return "<html><title></title><body><a href='cms'>Admin</a></body></html>";
        }
       
        //!!!!was!!!!!!getting duplicates in [cms_Page_Map] which means below ctm was first or default - 
        //mt is needing last or default. that's why I pull the list then get the last one.
        public string ObtainHtmlFromMap(cms_Page_Map mp, cmsEntities cr)
        {
            string body = string.Empty;
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
                body = sb.ToString();
                body = mt.html.Replace("{content_template}", body);
                if (body.Contains("{menu_component}"))
                {
                    body = body.Replace("{menu_component}", MenuRepository.GetTopLevelMenusHtml(mp.pageName));
                }

                //IModule support
                if (body.Contains("{{"))
                {
                    body = AddContentFromModules( body );
                }
                return body;
            }
            catch (Exception exp)
            {
                LogRepository.SaveEntry("cmsRepository.ObtainHtmlFromMap", exp.ToString(), true);
                return body + Page404Content() ;
            }
        }

        static string Page404Content()
        {
            return "<h1>Not Found</h1>";
        }

        protected class splitpage
        {
            public int startpos { set; get; }
            public int endpos { set; get; }
            public string text { set; get; }
        }


        protected List<splitpage> SplitDocAtModuleDefs( string HtmlView )
        {
            //load up a list with the document broken up into pieces,
            //process all with isHrefContents=true;
            //put it back together. this is our page.
            List<splitpage> d = new List<splitpage>();
            int pos = 0;
            while (true)
            {
                splitpage sp1 = new splitpage();
                sp1.startpos = pos; 

                int anchorAt = HtmlView.Substring(pos).IndexOf("{{");
                if (anchorAt < 0) // no more
                {
                    if (HtmlView.Substring(sp1.startpos).Equals("}}"))
                        break;

                    sp1.endpos = HtmlView.Length;
                    //get the regular case text
                    sp1.text = HtmlView.Substring(sp1.startpos);
                    d.Add(sp1);
                    break;
                }
                else
                {
                    //add from pos to IModule definition starting point
                    sp1.endpos = pos + anchorAt;
                    sp1.text = HtmlView.Substring(sp1.startpos, sp1.endpos - sp1.startpos);
                    d.Add(sp1);

                    //now get the IModule definition
                    pos = sp1.endpos + 2;//add the "{{" to get to the other side.

                    splitpage sp2 = new splitpage();
                    sp2.startpos = pos;
                    int endat = HtmlView.Substring(pos).IndexOf("}}");
                    sp2.endpos = endat + pos;
                    string EntryControllerName = HtmlView.Substring(sp2.startpos, sp2.endpos - sp2.startpos);

                    sp2.text = PrairiePluginLib.PluginBootstrapper.GetContentFromModule(EntryControllerName);
                    
                    d.Add(sp2);
                    pos = pos + (sp2.endpos-sp2.startpos) + 2; //get to the other side of }}
                }
            }

            return d;
        }
        
        string AddContentFromModules(string body)
        {
            List<splitpage> documentparsed = SplitDocAtModuleDefs( body );

            //put it back together.
            StringBuilder sb = new StringBuilder();
            for (int bb = 0; bb < documentparsed.Count; bb++)
            {
                sb.Append(documentparsed[bb].text);
            }

            return sb.ToString();
        }
    }
}
