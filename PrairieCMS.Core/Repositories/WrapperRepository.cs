using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using PrairieCMS.Core.Models;


namespace PrairieCMS.Core
{
    public class WrapperRepository
    {

        public WrapperRepository()
        {
        }

        public static  MasterTemplate GetWrapperById( int MasterID)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.Master_Template.Where(r => r.pkMasterID == MasterID).FirstOrDefault();
            MasterTemplate one = new MasterTemplate();
            if (obj == null)
            {
                one.errorMessage = "Wrapper was not found.";
                return one;
            }
            one.MasterID = obj.pkMasterID;
            one.ThemeName = obj.themeName;
            one.Html = obj.html;
            return one;
        }

        public static List<MasterTemplate> GetExistingTemplates( )
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

        public static List< MasterTemplate> GetExistingWrapper()
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

        public static MasterTemplate CreateNewOrUpdateExistingWrapper(MasterTemplate mod, string username)
        {

            cmsEntities cr = new cmsEntities();
            Master_Template tmp = cr.Master_Template.Where(r => r.pkMasterID == mod.MasterID).FirstOrDefault();
            if (tmp == null)
            {
                tmp = new Master_Template();
                tmp.createdBy = username;
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


        public static string removeWrapper(int wrapperid)
        {
            cmsEntities cr = new cmsEntities();
            var obj = cr.Master_Template.Where(r => r.pkMasterID == wrapperid).FirstOrDefault();

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
            return "successfully deleted: " + wrapperid.ToString();
        }

        
    }
}
