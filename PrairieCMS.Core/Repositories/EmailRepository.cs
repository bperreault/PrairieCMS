using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Mail;
using System.Configuration;
using System.Collections.Specialized;
using PrairieCMS.Core.Models;

namespace PrairieCMS.Core
{
    public class EmailRepository
    {
        public class Email
        {
            public string Subject { get; set; }
            public string ToList { get; set; }
            public string CcList { get; set; }
            public string MessageBody { get; set; }
            public bool IsHTML { get; set; }
        }

        public static bool SendFormByEmail(NameValueCollection formPost, string pagename)
        {
            
            StringBuilder sb = new StringBuilder();
            foreach (string s in formPost.AllKeys)
            {
                sb.Append(s).Append(": ").Append(formPost[s]).Append("\r\n");
            }

            Email em = getFormDeliveryBody( pagename );
            em.IsHTML = false;
            em.MessageBody = em.MessageBody.Replace("[SurveyAnswers]", sb.ToString());
            em.ToList = ConfigurationManager.AppSettings["FormEmail"];
            return SendEmail(em);
        }

        public static Email getFormDeliveryBody(string pagename)
        {
            cmsContentTypeModel ctm = ContentTypeRepository.GetEmailFormTemplate();
            Email em = new Email();
            em.Subject = "Survey Form: " + pagename + " has been filled in.";
            em.MessageBody = ctm.templateHtml.Replace("[PageName]", pagename);
            return em;
        }

        public static bool SendEmail(Email mailer)
        {
            string mailfrom = ConfigurationManager.AppSettings["EmailFrom"];
            System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient();
            using (System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage())
            {
                if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["networkcredentialsuser"]))
                {
                    System.Net.NetworkCredential myCred = new System.Net.NetworkCredential(
                        ConfigurationManager.AppSettings["networkcredentialsuser"],
                        ConfigurationManager.AppSettings["networkcredentialspass"]);
                    client.Credentials = myCred;
                    client.EnableSsl = true;
                }
                bool bOut = false;
                if (!String.IsNullOrEmpty(mailer.ToList))
                {
                    string[] toList = mailer.ToList.Split(';');
                    foreach (string to in toList)
                    {
                        message.To.Add(new MailAddress(to));
                    }
                }
                if (!String.IsNullOrEmpty(mailer.CcList))
                {
                    string[] ccList = mailer.CcList.Split(';');
                    foreach (string cc in ccList)
                    {
                        message.CC.Add(new MailAddress(cc));
                    }
                }
                if (message.From == null)
                    message.From = new MailAddress(mailfrom);

                message.Subject = mailer.Subject;
                message.IsBodyHtml = mailer.IsHTML;
                message.Body = mailer.MessageBody;
                try
                {
                    client.Send(message);
                    //TODO: CMC - log this
                    bOut = true;
                }
                catch (System.Net.Mail.SmtpException x)
                {
                    //throw x;
                    //TODO: CMC - Log Exception, Do we really want to throw this back up the stack?
                    //throw new Exception("Email not sent: " + x.Message + "; message details: " + message.ToString());
                    //log this
                }
                return bOut;
            }
        }

    }
}
