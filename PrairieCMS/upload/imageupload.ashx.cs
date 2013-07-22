using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PrairieCMS.Core;
using System.IO;
using System.Configuration;

namespace PrairieCMS.upload
{
    /// <summary>
    /// Summary description for imageupload
    /// </summary>
    public class imageupload : IHttpHandler
    {

        private static string ImageFileFolder = @"images\";
        private static string ImageUrlFolder = "images/";

        public void ProcessRequest(HttpContext context)
        {
            string UploadFilePath = ConfigurationManager.AppSettings["UploadFilePath"];
            string UploadURLPath = ConfigurationManager.AppSettings["UploadURLPath"];
            
            context.Response.ContentType = "text/plain";
            
             if (string.IsNullOrEmpty(UploadFilePath))
                throw new Exception("UploadFilePath and UploadURLPath are not configured.");
            try
            {
                HttpPostedFile uploadedFile = null;
                HttpFileCollection hfc = context.Request.Files;
                foreach (string fk in hfc.AllKeys)
                {
                    uploadedFile = hfc[fk];
                    break;
                }
                if ( uploadedFile == null || uploadedFile.ContentLength == 0 )
                    context.Response.Write(""); 

                string fileName = Path.GetFileName(uploadedFile.FileName);

                //if is an image, add images info to paths.
                if (fileIsImage(fileName))
                {
                    UploadFilePath += ImageFileFolder;
                    UploadURLPath += ImageUrlFolder;
                }

                uploadedFile.SaveAs(UploadFilePath + fileName);
                context.Response.Write(UploadURLPath + fileName);
            }
            catch (Exception exp)
            {
                LogRepository.SaveEntry("Image Upload Error", exp.ToString(), true);
                context.Response.Write(""); 
            }
        }

        bool fileIsImage(string fileName)
        {
            var pieces = fileName.Split('.');
            if (pieces.Length > 1)
            {
                string ext = pieces[pieces.Length - 1].ToLower();
                if (ext.Equals("gif") || ext.Equals("jpg") || ext.Equals("png") || ext.Equals("svg"))
                    return true;
            }
            return false;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}