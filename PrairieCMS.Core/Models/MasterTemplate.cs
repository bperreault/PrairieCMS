using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PrairieCMS.Core.Models
{
    public class MasterTemplate
    {

        public int MasterID{get;set;}
        public string errorMessage { get; set; }
        public string ThemeName{get;set;}

        public string Html{get;set;}

        public string CreatedOn{get;set;}

        public string CreatedBy{get;set;}

        public string ModifiedOn{get;set;}

        public string ModifiedBy{get;set;}
    }
}
