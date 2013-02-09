﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace PrairieCMS.Core.Models
{
    public class cmsModel
    {
        public string title { get; set; }
        public string message { get; set; }
        public string tags { get; set; }
        [AllowHtml]
        public string html { get; set; }
    }
}
