define(['Boiler', './settings', './Content_Template/ct_component', './cms_Site_Map/sm_component', './Content_Type/ct_component',
             './Content_Type_Map/ctm_component', './landingPage/component', './SiteSetup/ss_component',
             './cms_Page_Map/cpm_component', './Master_Template/w_component', './Export/e_component',
              './Files_Mtce/f_component', './Plugin_Mtce/p_component'],


function (Boiler, settings, Content_TemplateComponent, SiteMapComponent, ContentTypeComponent,
                 ContentTypeMapComponent, LandingPageComponent,
                 SiteSetupComponent, cms_Page_MapComponent, Master_TemplateComponent, ExportComponent
                 , FilesComponent, PluginComponent) {

    var Module = function(globalContext) {

        var context = new Boiler.Context(globalContext);
        context.addSettings(settings);

        var controller = new Boiler.UrlController($(".tab-content"));
        controller.addRoutes({
            "/": new LandingPageComponent(context),
            "menu": new SiteMapComponent(context),
            "body": new Content_TemplateComponent(context),
            "body/{id}": new Content_TemplateComponent(context),
            "contentType": new ContentTypeComponent(context),
            "contentTypeMap": new ContentTypeMapComponent(context),
            "siteSetup": new SiteSetupComponent(context),
            "assignment": new cms_Page_MapComponent(context),
            "wrapper": new Master_TemplateComponent(context),
            "export": new ExportComponent(context),
            "filesmtce": new FilesComponent(context),
            "pluginmtce": new PluginComponent(context)
        });
        controller.start();
    };

    return Module;

});
