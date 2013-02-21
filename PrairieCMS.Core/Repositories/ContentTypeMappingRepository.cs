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
    public class ContentTypeMappingRepository
    {

        public ContentTypeMappingRepository()
        {
        }
        
        public static  cmsContentTypeMapping GetContentTypeMappingById( int ContentTypeMappingId)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cmsContent_Type_Mapping.Where(r => r.pkBcId == ContentTypeMappingId).FirstOrDefault();
            cmsContentTypeMapping one = new cmsContentTypeMapping();
            if (obj == null)
            {
                one.errorMessage = "ContentTypeMapping was not found.";
                return one;
            }
            one.pkBcId = obj.pkBcId;
            one.fkParent = obj.fkParent;
            one.fkEditorsRole = obj.fkEditorsRole;
            one.fkContentType = obj.fkContentType;
            one.fkContent = (int) obj.fkContent;
            one.domInsertionPoint = obj.domInsertionPoint;
            one.dateModified = obj.dateModified;
            one.modifiedBy = obj.modifiedBy;
            return one;
        }

        
        public static List< cmsContentTypeMapping> GetExistingContentTypeMapping()
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cmsContent_Type_Mapping.ToList();
            List<cmsContentTypeMapping> cm = new List<cmsContentTypeMapping>();
            for (int ii = 0; ii < obj.Count(); ii++)
            {
                cmsContentTypeMapping one = new cmsContentTypeMapping();
                one.pkBcId = obj[ii].pkBcId;
                one.fkParent = obj[ii].fkParent;
                one.fkEditorsRole = obj[ii].fkEditorsRole;
                one.fkContentType = obj[ii].fkContentType;
                one.fkContent = (int)obj[ii].fkContent;
                one.domInsertionPoint = obj[ii].domInsertionPoint;
                cm.Add(one);
            }
            cr = null;
            return cm;
        }

        [HttpPost]
        public static cmsContentTypeMapping CreateNewOrUpdateExistingContentTypeMapping(cmsContentTypeMapping mod, string user)
        {
            cmsEntities cr = new cmsEntities();
            cmsContent_Type_Mapping tmp = cr.cmsContent_Type_Mapping.Where(r => r.pkBcId == mod.pkBcId).FirstOrDefault();
            if (tmp == null)
            {
                tmp = new cmsContent_Type_Mapping();
                cr.Entry(tmp).State = System.Data.EntityState.Added;
                tmp.dateCreated = DateTime.Now;
                tmp.createdBy = user;
            }
            tmp.fkParent = mod.fkParent;
            tmp.fkEditorsRole = mod.fkEditorsRole;
            tmp.fkContentType = mod.fkContentType;
            tmp.fkContent = mod.fkContent;
            tmp.domInsertionPoint = mod.domInsertionPoint;
            tmp.dateModified = mod.dateModified;
            tmp.modifiedBy = mod.modifiedBy;

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
                mod.pkBcId = tmp.pkBcId;
                ((IObjectContextAdapter)cr).ObjectContext.Detach(tmp);
                cr = null;
            }

            return mod;
        }

        public static string removeContentTypeMappingItem(int ContentTypeMappingid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.cmsContent_Type_Mapping.Where(r => r.pkBcId == ContentTypeMappingid).FirstOrDefault();

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
            return "successfully deleted: " + ContentTypeMappingid.ToString();
        }

    }
}
