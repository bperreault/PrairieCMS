define(['Boiler', './settings', './Content_Template/ct_component', './cms_Site_Map/sm_component', './Content_Type/ct_component',
             './Content_Type_Map/ctm_component', './landingPage/component', './SiteSetup/ss_component',
             './cms_Page_Map/cpm_component', './Master_Template/w_component'],


function (Boiler, settings, Content_TemplateComponent, SiteMapComponent, ContentTypeComponent,
                 ContentTypeMapComponent, LandingPageComponent, 
                 SiteSetupComponent, cms_Page_MapComponent, Master_TemplateComponent) {

    var Module = function(globalContext) {

        var context = new Boiler.Context(globalContext);
        context.addSettings(settings);

        var controller = new Boiler.UrlController($(".tab-content"));
        controller.addRoutes({
            "/": new LandingPageComponent(),
            "menu": new SiteMapComponent(context),
            "body": new Content_TemplateComponent(context),
            "body/{id}": new Content_TemplateComponent(context),
            "contentType": new ContentTypeComponent(context),
            "contentTypeMap": new ContentTypeMapComponent(context),
            "siteSetup": new SiteSetupComponent(context),
            "assignment": new cms_Page_MapComponent(context),
            "wrapper": new Master_TemplateComponent(context)
        });
        controller.start();
    };

    return Module;

});