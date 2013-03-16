using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PrairieCMS.Core.Models
{
    public class cmsContentTypeMapping
    {
        public int pkBcId { get; set; }
        public int fkParent { get; set; }
        public int fkEditorsRole { get; set; }
        public int fkContentType { get; set; }
        public int fkContent { get; set; }
        public string domInsertionPoint { get; set; }
        public DateTime dateCreated { get; set; }
        public string createdBy { get; set; }
        public DateTime dateModified { get; set; }
        public string modifiedBy { get; set; }
        public string errorMessage { get; set; }

    }
}
