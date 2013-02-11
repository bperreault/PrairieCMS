using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using PrairieCMS.Core.Models;
using System.Configuration;
using System.Collections.Specialized;
using Newtonsoft.Json.Linq;

namespace PrairieCMS.Core
{
    public class LogRepository
    {
        public static bool EmailEnabled { set; get; }
        public static bool LoggingEnabled { get; set; }
        
     protected static bool Initialized = false;

        public LogRepository()
        {
            
        }

        public static void SaveEntry(string category, string info, bool overrideEmailEnabledSendEmail)
        {
            if ( !Initialized)
            {
                EmailEnabled = string.IsNullOrEmpty(ConfigurationManager.AppSettings["emailEnabled"]) ? false : true;
                LoggingEnabled = string.IsNullOrEmpty(ConfigurationManager.AppSettings["loggingEnabled"]) ? false : true;
                Initialized = true;
            }


            //if (overrideEmailEnabledSendEmail || EmailEnabled)
            //    Util.SendAdminEmail(category + ": " + info);

            if (!LoggingEnabled)
                return;

       
            cmsEntities cr = new cmsEntities();
            Log tmp = new Log();
            tmp.Category = category;
            tmp.Date_Entered = DateTime.Now;
            tmp.Info = info;
            cr.Entry(tmp).State = System.Data.EntityState.Added;
            
            try
            {
                cr.SaveChanges();
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateException DbEx)
            {
                //Util.SendAdminEmail("LogRepository error: " + DbEx.ToString());
            }
            finally
            {
                ((IObjectContextAdapter)cr).ObjectContext.Detach(tmp);
                cr = null;
            }
        }


      
    }
}
