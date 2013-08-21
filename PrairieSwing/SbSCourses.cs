using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PrairieSwing
{
    class SbSCourses
    {
        public string GetCourse(string name, string city)
        {
            SbSResponse returnobj = SwingBySwingGet.SendToApi("courses" ,
                new Dictionary<string,string>(){
                    {"name",name},
                    {"city",city}
                } );
            if (returnobj.successful)
                return returnobj.response;

            return returnobj.message;
        }
    }
}
