using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Text;

namespace PrairieSwing
{
    public class SwingBySwingGet
    {
               
        public static SbSResponse SendToApi(string getTarget, Dictionary<string, string> getItems)
        {
            try
            {
                string uri = SwingBySwingPost.SBSAPIURL + getTarget;
                HttpWebRequest req = null;
                req.Method = "GET";// Supports POST too
                StringBuilder sb = new System.Text.StringBuilder();

                HttpWebResponse res = null;
                try
                {
                    req = (HttpWebRequest)WebRequest.Create(uri);
                    res = (HttpWebResponse)req.GetResponse();
                    Stream stream = res.GetResponseStream();

                    byte[] data = new byte[4096];
                    int read;
                    while ((read = stream.Read(data, 0, data.Length)) > 0)
                    {
                       sb.Append(data);
                    }
                }
                finally
                {
                    if (res != null)
                        res.Close();
                }
                SbSResponse returnobj = new SbSResponse() { response = sb.ToString(), successful = true, message = string.Empty };
                return returnobj;
            }
            catch (Exception exp)
            {
                SbSResponse returnobj = new SbSResponse() { response = null, successful = false, message = exp.ToString() };
                return returnobj;
            }
        }

        protected static string flattenDictionaryPostItems( Dictionary<string,string> postItems)
        {            
            StringBuilder sb = new System.Text.StringBuilder();
            foreach (KeyValuePair<string, string> pair in postItems)
            {
                Console.WriteLine("{0}, {1}",
                pair.Key,
                pair.Value);
                sb.Append(pair.Key).Append("=").Append(pair.Value).Append("&");
            }
            sb.Remove(sb.Length - 2, 1);
            return sb.ToString();
        }
    }
}
