using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Text;

namespace PrairieSwing
{
    public class SwingBySwingPost
    {

        public const String SBSAPIURL = "https://api.swingbyswing.com/";

        public static SbSResponse PostToApi(string postTarget, Dictionary<string, string> postItems)
        {
            try
            {
                HttpWebRequest httpWReq = (HttpWebRequest)WebRequest.Create(SBSAPIURL + postTarget);

                ASCIIEncoding encoding = new ASCIIEncoding();
                string postData = flattenDictionaryPostItems(postItems);
                byte[] data = encoding.GetBytes(postData);

                httpWReq.Method = "POST";
                httpWReq.ContentType = "application/x-www-form-urlencoded";
                httpWReq.ContentLength = data.Length;

                using (Stream stream = httpWReq.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }

                HttpWebResponse response = (HttpWebResponse)httpWReq.GetResponse();

                string responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

                SbSResponse returnobj = new SbSResponse() { response = responseString, successful = true, message = string.Empty };
                return returnobj;
            }
            catch (Exception exp)
            {
                SbSResponse returnobj = new SbSResponse() { response = null, successful = false, message = exp.ToString() };
                return returnobj;
            }
        }

        public static string flattenDictionaryPostItems( Dictionary<string,string> postItems)
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
