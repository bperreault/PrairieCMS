using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using PrairieCMS.Core.Models;
using System.Web.Mvc;
using System.Web;
using System.IO;

namespace PrairieCMS.Core
{
    public class ContentRepository
    {

        public ContentRepository()
        {
        }

        public static ContentModel GetContentByFriendlyUrl(string friendlyUrl)
        {
            cmsEntities cr = new cmsEntities();

            var obj = cr.cmsContent_Type_Mapping.Where(r => r.cms_Page_Map.pageName.Equals(friendlyUrl)).FirstOrDefault();
            
            ContentModel one = new ContentModel();
            if (obj == null)
            {
                one.errorMessage = "content was not found.";
                return one;
            }
            fillContent(obj, one);
            return one;
        }


        public static ContentModel GetContentById(int pkMapID)
        {
            cmsEntities cr = new cmsEntities();

            var obj = cr.cmsContent_Type_Mapping.Where(r => r.fkParent == pkMapID).FirstOrDefault();

            ContentModel one = new ContentModel();
            if (obj == null)
            {
                //no content type mapping record, but see if there is a page map
                var pm = cr.cms_Page_Map.Where(r => r.pkMapID == pkMapID).FirstOrDefault();
                if (pm == null)
                {
                    one.errorMessage = "content was not found.";
                    return one;
                }

                ContentTypeMappingRepository.CreateNewContentTypeMapping(pm);
                //reload to get the object setup right.
                cr.cmsContent_Type_Mapping.Where(r => r.fkParent == pkMapID).FirstOrDefault();
            }
            fillContent(obj, one);
            return one;
        }

        protected static void fillContent(cmsContent_Type_Mapping obj, ContentModel one)
        {
            one.pkMapID = obj.fkParent;
            one.pageName = obj.cms_Page_Map.pageName;
            one.fkMasterThemeID = obj.cms_Page_Map.fkMasterThemeID;
            one.fkEditorRoleID = obj.cms_Page_Map.fkEditorRoleID;
            one.pageTitle = obj.cms_Page_Map.pageTitle;
            one.tags = obj.cms_Page_Map.tags;
            one.isActive = obj.cms_Page_Map.isActive.HasValue ? (bool)obj.cms_Page_Map.isActive : false;
            one.cmsPageMapId = obj.cms_Page_Map.pkMapID;

            one.fkLevelMappingId = (int)obj.cmsContent_Type.fkLevelMappingId;
            one.pkBcId = obj.pkBcId;


            one.ContentId = obj.cms_Page_Map.fkContentID;
            one.ContentName = obj.Content_Template.contentName;
            one.ContentHtml = obj.Content_Template.html;
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

        public static FormDataItems GetExistingContent()
        {
            FormDataItems fdi = new FormDataItems();
            cmsEntities cr = new cmsEntities();
            List<ContentSelectionItems> contentList = (from con in cr.cms_Page_Map
                                                       where !string.IsNullOrEmpty(con.pageName)
                                                       where (bool)con.isActive
                                                       select new ContentSelectionItems()
                                                       {
                                                           ContentId = con.pkMapID,
                                                           ContentName = con.pageName
                                                       }).ToList();
            fdi.contentList = contentList;

            List<FormSelectionItems> contentPieces = (from con in cr.cmsContent_Type
                                                       where con.fkLevelMappingId > 1
                                                       where con.fkLevelMappingId != 5 //email content type
                                                      select new FormSelectionItems()
                                                       {
                                                           text = con.contentName,
                                                           value = con.contentName,
                                                           html = con.templateHtml,
                                                           inputForm = con.inputForm
                                                       }).ToList();
            fdi.contentPieces = contentPieces;

            cr = null;
            return fdi;
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
            if (mod.fkEditorRoleID == 0)
                mod.fkEditorRoleID = 1;  //default to admin only
            if (mod.fkLevelMappingId == 0)
                mod.fkLevelMappingId = 1; //default to page level

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
            tmp.html = HttpUtility.UrlDecode(mod.ContentHtml);
            tmp.modifiedBy = user;
            tmp.modifiedOn = DateTime.Now;
            try
            {
                cr.SaveChanges();
                
                mod.pagemap.ContentId = tmp.pkContentID;
                cmsPageMap pagemap = editOrCreatecmsPageMap(mod.pagemap, user);

                foreach ( cmsContentTypeMapping ctm in mod.contentTypeMappings)
                {
                    ctm.fkParent = pagemap.cmsPageMapId;
                    ctm.fkContent = tmp.pkContentID;
                    ctm.dateCreated = DateTime.Now;
                    ctm.createdBy = user;
                    ctm.dateModified = DateTime.Now;
                    ctm.modifiedBy = user;
                    ctm.pkBcId = mod.pkBcId;
                    ContentTypeMappingRepository.CreateNewOrUpdateExistingContentTypeMapping(ctm, user);
                }
                
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
            var pageman = cr.cms_Page_Map.Where(r => r.fkContentID == contentid);
            foreach( cms_Page_Map obj in pageman)
                obj.isActive = false;
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
