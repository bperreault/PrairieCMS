using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using PrairieCMS.Core.Models;


namespace PrairieCMS.Core
{
    public class MenuRepository
    {

        public MenuRepository()
        {
        }

        public static string removeMenuItem(int menuid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cmsSiteMapItems.Where(r => r.pkSiteMapItemID == menuid).FirstOrDefault();

           cr.Entry(obj).State = System.Data.EntityState.Deleted;
            try
            {
                cr.SaveChanges();
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateException DbEx)
            {
                return DbEx.ToString();
            }
            finally
            {               
                cr = null;
            }
            return "successfully deleted: " + menuid.ToString();
        }

        public static cmsSiteMapItemBO getMenuItem(int menuid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = (from mnu in cr.cmsSiteMapItems
                       where mnu.pkSiteMapItemID == menuid
                       select new cmsSiteMapItemBO()
                       {
                           pkSiteMapItemID = mnu.pkSiteMapItemID,
                           SiteMapItemName = mnu.SiteMapItemName,
                           fkSiteMapParentId = mnu.fkSiteMapParentId,
                           relativeUrl = mnu.relativeUrl,
                           itemOrder = (int)mnu.itemOrder
                       }).FirstOrDefault();


            return obj;
        }

        public static List<cmsSiteMapItemBO> GetMenuById(int menuId)
        {
            cmsEntities cr = new cmsEntities();
            var obj = (from mnu in cr.cmsSiteMapItems 
                       orderby mnu.itemOrder
                        where mnu.fkSiteMapParentId == menuId
                       select new cmsSiteMapItemBO()
                       {                            
                            pkSiteMapItemID = mnu.pkSiteMapItemID,
                            SiteMapItemName = mnu.SiteMapItemName,
                            fkSiteMapParentId = mnu.fkSiteMapParentId,
                            relativeUrl = mnu.relativeUrl,
                            itemOrder = (int)mnu.itemOrder                    
                        } ).ToList();

          
            return obj;
        }

        /// <summary>
        /// this method returns a list of top level menu items.
        /// </summary>
        /// <param name="companyid"></param>
        /// <returns></returns>
        public static List<cmsSiteMapItemBO> GetTopLevelMenus()
        {
            cmsEntities cr = new cmsEntities();
            var obj = (from mnu in cr.cmsSiteMapItems
                       orderby mnu.itemOrder
                       where mnu.fkSiteMapParentId == -1
                       select new cmsSiteMapItemBO()
                       {
                           pkSiteMapItemID = mnu.pkSiteMapItemID,
                           SiteMapItemName = mnu.SiteMapItemName,
                           fkSiteMapParentId = mnu.fkSiteMapParentId,
                           relativeUrl = mnu.relativeUrl,
                           itemOrder = (int)mnu.itemOrder
                       }).ToList();


            return obj;
        }

        public static string GetTopLevelMenusHtml(string activeMenuRelativeUrl)
        {
            //"menu_component"
            cmsEntities cr = new cmsEntities();
            List<GetMainMenu_Result> gmmr = cr.GetMainMenu().ToList();
            //build the html
            StringBuilder sb = new StringBuilder();

            //the container html
            string menu_component = gmmr.Where(m => m.fkSiteMapParentId == -2).FirstOrDefault().templateHtml;

            var toplevelitems = gmmr.Where(m => m.fkSiteMapParentId == -1);
            foreach (var mnu in toplevelitems)
            {
                var submnuItems = gmmr.Where(m => m.fkSiteMapParentId == mnu.pkSiteMapItemID).ToList();
                if (submnuItems == null)
                    continue;
                bool isActive = false;
                if (activeMenuRelativeUrl.ToLower().Equals(mnu.relativeUrl.ToLower()))
                {
                    isActive = true;
                }
                

                if (submnuItems.Count == 0)
                {
                    sb.Append(getMenuItem(mnu, isActive));
                }
                else
                {
                    string menuheader = getMenuHeader(mnu, isActive);

                    StringBuilder submenu = new StringBuilder();
                    submenu.Append("<ul  class=\"dropdown-menu\">");
                    foreach (var submnu in submnuItems)
                    {
                        //this marks the menu tab if a sub menu item is active
                        if (activeMenuRelativeUrl.ToLower().Equals(submnu.relativeUrl.ToLower()))
                        {
                            isActive = true;
                            menuheader = getMenuHeader(mnu, isActive);
                        }
                        submenu.Append(getMenuSubItem(submnu));
                    }
                    submenu.Append("</ul>");

                    sb.Append(  menuheader.Replace("[submenu]", submenu.ToString()) );
                }
            }


            menu_component = menu_component.Replace("[menu_component]", sb.ToString());
            return menu_component;
        }

        public static string getMenuSubItem(GetMainMenu_Result menuObj)
        {
            string html = string.Format( "<li><a tabindex=\"-1\" href=\"{0}\">{1}</a></li>", menuObj.relativeUrl , menuObj.SiteMapItemName);
            return html;
        }

        public static string getMenuItem(GetMainMenu_Result menuObj, bool isActive)
        {
            string html = string.Empty;
            if (isActive)
                html = string.Format("<li class=\"active\"><a tabindex=\"-1\" href=\"{0}\">{1}</a></li><li class=\"divider-vertical\"></li>", menuObj.relativeUrl, menuObj.SiteMapItemName);
            else
                html = string.Format("<li><a tabindex=\"-1\" href=\"{0}\">{1}</a></li><li class=\"divider-vertical\"></li>", menuObj.relativeUrl, menuObj.SiteMapItemName);
            return html;
        }

        public static string getMenuHeader(GetMainMenu_Result menuObj, bool isActive)
        {
            string html = string.Empty;
            if (isActive)
                html = string.Format("<li class=\"active dropdown\"><a tabindex=\"-1\" href=\"{0}\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" >{1}<b class=\"caret\"></b></a>[submenu]</li><li class=\"divider-vertical\"></li>", menuObj.relativeUrl, menuObj.SiteMapItemName);
                    else
                html = string.Format("<li class=\"dropdown\"><a tabindex=\"-1\" href=\"{0}\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" >{1}<b class=\"caret\"></b></a>[submenu]</li><li class=\"divider-vertical\"></li>", menuObj.relativeUrl, menuObj.SiteMapItemName);
            return html;
        }

        public static cmsSiteMapItemBO editOrCreatecmsMenuItem(cmsSiteMapItemBO mod, string user)
        {

            cmsEntities cr = new cmsEntities();
            cmsSiteMapItem mcm = cr.cmsSiteMapItems.Where(r => r.pkSiteMapItemID == mod.pkSiteMapItemID).FirstOrDefault();

            if (mcm == null)
            {
                mcm = new cmsSiteMapItem();               
                cr.Entry(mcm).State = System.Data.EntityState.Added;
            }
            
	        mcm.SiteMapItemName = mod.SiteMapItemName;
	        mcm.fkSiteMapParentId = mod.fkSiteMapParentId;
	        mcm.relativeUrl = mod.relativeUrl;
            mcm.itemOrder = mod.itemOrder;
            try
            {
                cr.SaveChanges();
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateException DbEx)
            {
                mod.errorMessage = DbEx.ToString();
            }
            finally
            {
                mod.pkSiteMapItemID = mcm.pkSiteMapItemID;
                ((IObjectContextAdapter)cr).ObjectContext.Detach(mcm);
                cr = null;
            }

            return mod;
        }

        /// <summary>
        /// fill in the content list with mnu info where applicable. 
        /// used on the dashboard to show available pages in an easy to understand manner
        /// </summary>
        /// <param name="contentList"></param>
        /// <returns></returns>
        public static List<ContentSelectionItems> GetDashboardTree(List<ContentSelectionItems> contentList)
        {
           
            List<ContentSelectionItems> newContentList = new List<ContentSelectionItems>();
            using ( cmsEntities cr = new cmsEntities() )
            {
                List<GetMainMenu_Result> gmmr = cr.GetMainMenu().ToList();           
                var toplevelitems = gmmr.Where(m => m.fkSiteMapParentId == -1);
                foreach (var mnu in toplevelitems)
                {
                    var submnuItems = gmmr.Where(m => m.fkSiteMapParentId == mnu.pkSiteMapItemID).ToList();
                    if (submnuItems == null)
                        continue;
                 
                    string relativeUrl = mnu.relativeUrl.ToLower();
                    var contentitm = contentList.Where(m => m.ContentName.ToLower().Equals(relativeUrl)).FirstOrDefault();
                    if (contentitm == null)
                        continue;
                
                    contentitm.ParentMenuId = mnu.fkSiteMapParentId;
                    contentitm.MenuId = mnu.pkSiteMapItemID;
                    contentitm.listClass = "pagelist";
                    newContentList.Add(contentitm);

                   foreach (var submnu in submnuItems)
                    {
                        relativeUrl = submnu.relativeUrl.ToLower();
                       contentitm = contentList.Where(m => m.ContentName.ToLower().Equals(relativeUrl)).FirstOrDefault();
                       if (contentitm == null)
                           continue;
                       contentitm.ParentMenuId = submnu.fkSiteMapParentId;
                       contentitm.MenuId = submnu.pkSiteMapItemID;
                       contentitm.listClass = "sublistitem";
                       newContentList.Add(contentitm);
                    }
                
                }
           }
            foreach (var content in contentList)
            {
                var newcontent = newContentList.Where(m => m.ContentId == content.ContentId).FirstOrDefault();
                if (newcontent == null)
                {
                    content.ParentMenuId = -1;
                    content.MenuId = -1;
                    content.listClass = "pagelist";
                    newContentList.Add(content);
                }
            }
            return newContentList;
        }

        
    }
}
