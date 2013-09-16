using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using PrairiePluginLib;
using System.Reflection;
using System.Collections.Specialized;

namespace PrairieSwing
{
    public class PrairieSwingModule : IModule
        {
            public string Title
            {
                get { return "PrairieSwing"; }
            }
            public string Name
            {
                get { return Assembly.GetAssembly(GetType()).GetName().Name; }
            }
            public Version Version
            {
                get { return new Version(1, 0, 0, 0); }
            }
            public string EntryControllerName
            {
                get { return "PrairieSwing"; }
            }

            // the plan is to use Unity for resolving references.
        //ideally there will be a service here which can be plugged in as below with Castle Windsor.
            public void Install()
            {

                //var container = ServiceLocator.Current.GetInstance<IWindsorContainer>();

                //container.Kernel.AddFacility<WcfFacility>();
                //container.Register(Component.For<IAgendaService>()
                //                       .ActAs(new DefaultClientModel
                //                       {
                //                           Endpoint = WcfEndpoint.BoundTo(new BasicHttpBinding())
                //                               .At("http://localhost:32610/AgendaService.svc")
                //                       }));

                //container.Register(Component.For<AgendaPrefill>());

                //container.Resolve<AgendaPrefill>().Prefill();
            }

            public string GetHtml()
            {
                return "<h1>Prairie Swing Module!!!!</h1>";
            }


            public string GetRequestedContent(string friendlyUrl, string json)
            {
                return "<h1>content for json request</h1>";
            }

            public string GetAdminPages()
            {
                return "<h1>admin pages</h1>";
            }
        
    }
}
