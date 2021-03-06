﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PrairieCMS.Core.Models;

namespace PrairieCMS.Core.Controllers.FriendlyURLHandling
{

        public class PageManager
        {

            public cmsModel GetPageNoContentByFriendlyUrl(string friendlyUrl)
            {
                cmsModel page = new cmsRepository().PageNoContent(friendlyUrl);
                return page;                
            }

            public cmsModel GetPageByFriendlyUrl(string friendlyUrl)
            {
                cmsModel page = new cmsRepository().PageContent(friendlyUrl);
                return page;                
            }
        }
    
}
