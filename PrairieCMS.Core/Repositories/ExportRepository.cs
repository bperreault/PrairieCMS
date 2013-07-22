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
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.Zip;

namespace PrairieCMS.Core
{
    public class ExportRepository
    {

        public ExportRepository()
        {
        }

        public static string ExportPages()
        {
            // Create a temp directory to hold site contents in staging area
            string packageId = Guid.NewGuid().ToString();
            DirectoryInfo siteDirectory = CreateSiteDirectory( packageId );

            List<string> filenames = new List<string>();

            //create html files for all the content
            var pgs = ContentRepository.GetExistingContent();
            foreach (var pg in pgs.contentList)
            {
                cmsModel cms = cmsRepository.PageContent(pg.ContentName);
                filenames.Add(cms.WriteOut(siteDirectory.FullName));
            }
            
            //zip it up
            string zipfilename = ZipContent(siteDirectory.FullName);

            return zipfilename;
        }

        private static string ZipContent(string directory)
        {
            string zipfile = directory + ".zip";

            FastZip fz = new ICSharpCode.SharpZipLib.Zip.FastZip();
            fz.CreateZip(zipfile, directory, true, null);
            return zipfile;
        }

        private static DirectoryInfo CreateSiteDirectory(string packageId)
        {            
            var rootPath = HttpContext.Current.Server.MapPath("~/App_Data");
            return Directory.CreateDirectory(Path.Combine(rootPath, "WebsiteStaging", packageId));
        }

    }
}
