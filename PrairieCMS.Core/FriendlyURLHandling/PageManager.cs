using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PrairieCMS.Core.Models;

namespace PrairieCMS.Core.Controllers.FriendlyURLHandling
{

        public class PageManager
        {
            public static cmsModel GetPageByFriendlyUrl(string friendlyUrl)
            {
                cmsModel page = cmsRepository.PageContent(friendlyUrl);
                return page;                
            }
        }
    
}
