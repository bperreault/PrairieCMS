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
        
        public static List<cmsSiteMapItem> GetMenuById( int menuId)
        {
            cmsEntities cr = new cmsEntities();
            var obj = (from mnu in cr.cmsSiteMapItems 
                        where mnu.fkSiteMapParentId == menuId
                            select new cmsSiteMapItem() {                            
                                pkSiteMapItemID = mnu.pkSiteMapItemID,
                                SiteMapItemName = mnu.SiteMapItemName,
                                fkSiteMapParentId = mnu.fkSiteMapParentId,
                                relativeUrl = mnu.relativeUrl                     
                            }).ToList();

          
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
                       where mnu.fkSiteMapParentId == -1
                       select new cmsSiteMapItemBO()
                       {
                           pkSiteMapItemID = mnu.pkSiteMapItemID,
                           SiteMapItemName = mnu.SiteMapItemName,
                           fkSiteMapParentId = mnu.fkSiteMapParentId,
                           relativeUrl = mnu.relativeUrl
                       }).ToList();


            return obj;
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
