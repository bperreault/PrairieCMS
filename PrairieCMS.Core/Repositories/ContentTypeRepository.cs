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
    public class ContentTypeRepository
    {

        public ContentTypeRepository()
        {
        }
        
        public static  cmsContentTypeModel GetContentTypeById( int ContentTypeId)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cmsContent_Type.Where(r => r.pkContentTypeId == ContentTypeId).FirstOrDefault();
            cmsContentTypeModel one = new cmsContentTypeModel();
            if (obj == null)
            {
                one.errorMessage = "ContentType was not found.";
                return one;
            }
            one.pkContentTypeId = obj.pkContentTypeId;
            one.contentName = obj.contentName;
            one.fkLevelMappingId = (int)obj.fkLevelMappingId;
            one.templateHtml = obj.templateHtml;
            return one;
        }

        
        public static List< cmsContentTypeModel> GetExistingContentType()
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cmsContent_Type.Where(r => !string.IsNullOrEmpty(r.contentName) ).ToList();
            List<cmsContentTypeModel> cm = new List<cmsContentTypeModel>();
            for (int ii = 0; ii < obj.Count(); ii++)
            {
                cmsContentTypeModel one = new cmsContentTypeModel();
                one.pkContentTypeId = obj[ii].pkContentTypeId;
                one.contentName = obj[ii].contentName;
                one.fkLevelMappingId = (int)obj[ii].fkLevelMappingId;
                cm.Add(one);
            }
            cr = null;
            return cm;
        }

        [HttpPost]
        public static cmsContentTypeModel CreateNewOrUpdateExistingContentType(cmsContentTypeModel mod, string user)
        {
            cmsEntities cr = new cmsEntities();
            cmsContent_Type tmp = cr.cmsContent_Type.Where(r => r.pkContentTypeId == mod.pkContentTypeId).FirstOrDefault();
            if (tmp == null)
            {
                tmp = new cmsContent_Type();
                cr.Entry(tmp).State = System.Data.EntityState.Added;
            }
            tmp.contentName = mod.contentName;
            tmp.fkLevelMappingId = mod.fkLevelMappingId;
            tmp.templateHtml = mod.templateHtml;
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
                mod.pkContentTypeId = tmp.pkContentTypeId;
                ((IObjectContextAdapter)cr).ObjectContext.Detach(tmp);
                cr = null;
            }

            return mod;
        }

        public static string removeContentTypeItem(int ContentTypeid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cmsContent_Type.Where(r => r.pkContentTypeId == ContentTypeid).FirstOrDefault();

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
            return "successfully deleted: " + ContentTypeid.ToString();
        }

    }
}
