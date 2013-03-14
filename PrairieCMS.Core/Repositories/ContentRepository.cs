using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using PrairieCMS.Core.Models;
using System.Web.Mvc;


namespace PrairieCMS.Core
{
    public class ContentRepository
    {

        public ContentRepository()
        {
        }

        public static ContentModel GetContentById(int pkMapID)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cms_Page_Map.Where(r => r.pkMapID == pkMapID).FirstOrDefault();
            ContentModel one = new ContentModel();
            if (obj == null)
            {
                one.errorMessage = "content was not found.";
                return one;
            }
            one.pkMapID = obj.pkMapID;
            one.pageName = obj.pageName;
            one.fkMasterThemeID = obj.fkMasterThemeID;
            one.fkEditorRoleID = obj.fkEditorRoleID;
            one.pageTitle = obj.pageTitle;
            one.tags = obj.tags;
            one.isActive = obj.isActive.HasValue? (bool)obj.isActive : false;

            one.ContentId = obj.fkContentID;
            one.ContentName = obj.Content_Template.contentName;
            one.ContentHtml = obj.Content_Template.html;
            return one;
        }

        /// <summary>
        /// this method returns a list of packages that have been marked to be shown in selection boxes (limiting chunked records for example)
        /// </summary>
        /// <param name="companyid"></param>
        /// <returns></returns>
        public static List<cmsPageMap> GetExistingMCMs( )
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

        public static List< ContentModel> GetExistingContent()
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cms_Page_Map.Where(r => !string.IsNullOrEmpty(r.pageName) ).ToList();
            List<ContentModel> cm = new List<ContentModel>();
            for (int ii = 0; ii < obj.Count(); ii++)
            {
                ContentModel one = new ContentModel();
                one.ContentId = obj[ii].fkContentID;
               //// one.ContentName = obj[ii].Content_Template.contentName;
                one.pageName = obj[ii].pageName;
                one.fkEditorRoleID = obj[ii].fkEditorRoleID;
                one.tags = obj[ii].tags;
                one.pageTitle = obj[ii].pageTitle;
                one.fkMasterThemeID = obj[ii].fkMasterThemeID;
                one.pkMapID = obj[ii].pkMapID;
                cm.Add(one);
            }
            cr = null;
            return cm;
        }

        public static cmsPageMap GetMcMById(int mcmId )
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

        [HttpPost]
        public static ContentModel CreateNewOrUpdateExistingContent(ContentModel mod, string user)
        {
            cmsEntities cr = new cmsEntities();
            Content_Template tmp = cr.Content_Template.Where(r => r.pkContentID == mod.ContentId).FirstOrDefault();
            if (tmp == null)
            {
                tmp = new Content_Template();
                tmp.createdBy = user;
                tmp.createdOn = DateTime.Now;
                cr.Entry(tmp).State = System.Data.EntityState.Added;
            }
            tmp.contentName = mod.ContentName;
            tmp.html = Uri.UnescapeDataString(mod.ContentHtml);
            tmp.modifiedBy = user;
            tmp.modifiedOn = DateTime.Now;
            try
            {
                cr.SaveChanges();
                foreach ( cmsContentTypeMapping ctm in mod.contentTypeMappings)
                {
                    ctm.fkContent = tmp.pkContentID;
                    ctm.dateCreated = DateTime.Now;
                    ctm.createdBy = user;
                    ctm.dateModified = DateTime.Now;
                    ctm.modifiedBy = user;
                    ContentTypeMappingRepository.CreateNewOrUpdateExistingContentTypeMapping(ctm, user);
                }
                mod.pagemap.ContentId = tmp.pkContentID;
                editOrCreatecmsPageMap(mod.pagemap, user);
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

        public static string removeContentItem(int contentid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.Content_Template.Where(r => r.pkContentID == contentid).FirstOrDefault();

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
            return "successfully deleted: " + contentid.ToString();
        }

    }
}
