﻿using System;
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

        public static string GetTopLevelMenusHtml()
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
                if (submnuItems.Count == 1)
                    sb.Append(getMenuItem( mnu));
                else
                    sb.Append(getMenuHeader( mnu));

                sb.Append("<ul  class=\"dropdown-menu\">");
                foreach (var submnu in submnuItems)
                {
                    sb.Append(getMenuItem( submnu));
                }
                sb.Append("</ul>");
            }

            //menu_component = "<article class=\"menucomponent\"><ul class=\"dropdown-menu\" role=\"menu\"></ul></article>        "
          
            menu_component = menu_component.Replace("[menu_component]", sb.ToString());
            return menu_component;
        }

        public static string getMenuItem(GetMainMenu_Result menuObj)
        {
            string html = string.Format( "<li><a tabindex=\"-1\" href=\"{0}\">{1}</a></li>", menuObj.relativeUrl , menuObj.SiteMapItemName);
            return html;
        }

        public static string getMenuHeader(GetMainMenu_Result menuObj)
        {
            string html = string.Format("<li  class=\"dropdown-submenu\"><a tabindex=\"-1\" href=\"{0}\">{1}</a></li>", menuObj.relativeUrl, menuObj.SiteMapItemName);
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

    }
}
