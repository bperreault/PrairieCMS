using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using PrairieCMS.Core.Models;


namespace PrairieCMS.Core
{
    public class ContentRepository
    {

        public ContentRepository()
        {
        }
        
        public static  ContentModel GetContentById( int contentId)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.Content_Template.Where(r => r.pkContentID == contentId).FirstOrDefault();
            ContentModel one = new ContentModel();
            if (obj == null)
            {
                one.errorMessage = "content was not found.";
                return one;
            }
            one.ContentId = obj.pkContentID;
            one.ContentName = obj.contentName;
            one.ContentHtml = obj.html;
            return one;
        }

        /// <summary>
        /// this method returns a list of packages that have been marked to be shown in selection boxes (limiting chunked records for example)
        /// </summary>
        /// <param name="companyid"></param>
        /// <returns></returns>
        public static List<cmsPageMap> GetExistingMCMs( int companyid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cms_Page_Map.Where(r => (bool)r.isActive ).ToList();
            List<cmsPageMap> cm = new List<cmsPageMap>();
            for (int ii = 0; ii < obj.Count(); ii++)
            {
                cmsPageMap one = new cmsPageMap();
                one.cmsPageMapId = obj[ii].pkMapID;
               // one.mailerName = obj[ii].mailerName;
                cm.Add(one);
            }
            cr = null;
            return cm;
        }

        public static List<MasterTemplate> GetExistingTemplates( int companyid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.Master_Template.Where(r => !string.IsNullOrEmpty(r.themeName) ).ToList();
            List<MasterTemplate> cm = new List<MasterTemplate>();
            for (int ii = 0; ii < obj.Count(); ii++)
            {
                MasterTemplate one = new MasterTemplate();
                one.MasterID = obj[ii].pkMasterID;
                one.ThemeName = obj[ii].themeName;
                cm.Add(one);
            }
            cr = null;
            return cm;
        }

        public static List< ContentModel> GetExistingContent(int companyid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.Content_Template.Where(r => !string.IsNullOrEmpty(r.contentName) ).ToList();
            List<ContentModel> cm = new List<ContentModel>();
            for (int ii = 0; ii < obj.Count(); ii++)
            {
                ContentModel one = new ContentModel();
                one.ContentId = obj[ii].pkContentID;
                one.ContentName = obj[ii].contentName;
                cm.Add(one);
            }
            cr = null;
            return cm;
        }


        public static cmsPageMap GetMcMById(int mcmId, int companyid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cms_Page_Map.Where(r => r.pkMapID == mcmId  ).FirstOrDefault();
            cmsPageMap one = new cmsPageMap();
            one.cmsPageMapId = obj.pkMapID;
            one.MasterId = obj.fkMasterThemeID;
            one.ContentId = obj.fkContentID;
            one.cmsPageMapId = obj.pkMapID;
            one.pageName = obj.pageName;
            one.fkEditorRoleID = obj.fkEditorRoleID;
            one.tags = obj.tags;
            one.pageTitle = obj.pageTitle;

            cr = null;
            return one;

        }

        public static cmsPageMap editOrCreatecmsPageMap(cmsPageMap mod, string user)
        {

            cmsEntities cr = new cmsEntities();
            cms_Page_Map mcm = cr.cms_Page_Map.Where(r => r.pkMapID == mod.cmsPageMapId).FirstOrDefault();

            if (mcm == null)
            {
                mcm = new cms_Page_Map();
                mcm.createdBy = "cms";
                mcm.createdOn = DateTime.Now;
               
                cr.Entry(mcm).State = System.Data.EntityState.Added;
            }
            
            mcm.pageName = mod.pageName;
            mcm.fkEditorRoleID = mod.fkEditorRoleID;
            mcm.tags = mod.tags;
            mcm.pageTitle = mod.pageTitle;
            mcm.fkContentID = mod.ContentId;
            mcm.fkMasterThemeID = mod.MasterId;
            mcm.modifiedBy = user;
            mcm.modifiedOn = DateTime.Now;
            
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
                mod.cmsPageMapId = mcm.pkMapID;
                ((IObjectContextAdapter)cr).ObjectContext.Detach(mcm);
                cr = null;
            }

            return mod;
        }

        public static ContentModel CreateNewOrUpdateExistingContent(ContentModel mod)
        {

            cmsEntities cr = new cmsEntities();
            Content_Template tmp = cr.Content_Template.Where(r => r.pkContentID == mod.ContentId).FirstOrDefault();
            if (tmp == null)
            {
                tmp = new Content_Template();
                tmp.createdBy = "cms";
                tmp.createdOn = DateTime.Now;
                cr.Entry(tmp).State = System.Data.EntityState.Added;
            }
            tmp.contentName = mod.ContentName;
            tmp.html = mod.ContentHtml;
            tmp.modifiedBy = "cms";
            tmp.modifiedOn = DateTime.Now;
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
                mod.ContentId = tmp.pkContentID;
                ((IObjectContextAdapter)cr).ObjectContext.Detach(tmp);
                cr = null;
            }

            return mod;
        }

        #region Master Template
        public static MasterTemplate CreateNewOrUpdateExistingTemplate(MasterTemplate mod)
        {

            cmsEntities cr = new cmsEntities();
            Master_Template tmp = cr.Master_Template.Where(r => r.pkMasterID == mod.MasterID).FirstOrDefault();
            
            if (tmp == null)
            {
                tmp = new Master_Template();
                tmp.createdBy = "cms";
                tmp.createdOn = DateTime.Now;
                cr.Entry(tmp).State = System.Data.EntityState.Added;
            }
            tmp.themeName = mod.ThemeName;
            tmp.html = mod.Html;
            tmp.modifiedBy = "cms";
            tmp.modifiedOn = DateTime.Now;
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
                mod.MasterID = tmp.pkMasterID;
                ((IObjectContextAdapter)cr).ObjectContext.Detach(tmp);
                cr = null;
            }

            return mod;
        }

        public static MasterTemplate GetTemplateById(int templateId)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.Master_Template.Where(r => r.pkMasterID == templateId).FirstOrDefault();
            MasterTemplate one = new MasterTemplate();
            if (obj == null)
            {
                one.errorMessage = "template was not found.";
                return one;
            }
            one.MasterID = obj.pkMasterID;
            one.Html = obj.html;
            one.ThemeName = obj.themeName;
            return one;
        }
        
        #endregion
    }
}
