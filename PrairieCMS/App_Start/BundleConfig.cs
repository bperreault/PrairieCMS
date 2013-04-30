using System.Web;
using System.Web.Optimization;

namespace PrairieCMS
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery")
               .Include("~/Scripts/libs/jquery/jquery-{version}.js")
               .Include("~/Scripts/libs/bootstrap/bootstrap.js")
               .Include("~/Scripts/libs/toastr.js")
               );

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                        "~/Scripts/libs/jquery/jquery-ui-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/libs/jquery/jquery.unobtrusive*",
                        "~/Scripts/libs/jquery/jquery.validate*"));

            //this thing skips all mins if we're not building in release mode!
            //so putting the links directly into the html for now.
            ////bundles.Add(new ScriptBundle("~/bundles/thirdparty")
            ////            .Include("~/Scripts/libs/knockout/knockout-2.1.0.js")
            ////            .Include("~/Scripts/libs/underscore/underscore-1.3.3.js"));
            ////bundles.Add(new ScriptBundle("~/bundles/thirdparty2")
            ////            .Include("~/Scripts/libs/signals/signals.min.js")
            ////            .Include("~/Scripts/libs/crossroads/crossroads.min.js")
            ////            .Include("~/Scripts/libs/flot/jquery.flot.min.js"));
            ////bundles.Add(new ScriptBundle("~/bundles/thirdparty3")
            ////            .Include("~/Scripts/libs/flot/jquery.flot.resize.js")
            ////            .Include("~/Scripts/libs/hasher/hasher.min.js")
            ////            .Include("~/Scripts/libs/pubsub/pubsub-20120708.js")
            ////            .Include("~/Scripts/libs/boilerplate/groundwork.js")
            ////            .Include("~/Scripts/libs/kendo/kendo.web.min.js"));
            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/libs/modernizr/modernizr-*"));

            bundles.Add(new StyleBundle("~/Content/css")
                       .Include("~/Content/bootstrap.css")
                       .Include("~/Content/toastr.css")
                       .Include("~/Content/site.css"));

            bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
                        "~/Content/themes/base/jquery.ui.core.css",
                        "~/Content/themes/base/jquery.ui.resizable.css",
                        "~/Content/themes/base/jquery.ui.selectable.css",
                        "~/Content/themes/base/jquery.ui.accordion.css",
                        "~/Content/themes/base/jquery.ui.autocomplete.css",
                        "~/Content/themes/base/jquery.ui.button.css",
                        "~/Content/themes/base/jquery.ui.dialog.css",
                        "~/Content/themes/base/jquery.ui.slider.css",
                        "~/Content/themes/base/jquery.ui.tabs.css",
                        "~/Content/themes/base/jquery.ui.datepicker.css",
                        "~/Content/themes/base/jquery.ui.progressbar.css",
                        "~/Content/themes/base/jquery.ui.theme.css"));


        }
       
        //this thing skips all mins if optimizations isn't on!
        //BundleTable.EnableOptimizations = true;
    }
}