<img src="http://www.faxt.com/images/PrairieCMS-logo.png" alt="Prairie CMS" />
[Prairie CMS](http://prairiesoft.co/)
=================================================================
Prairie Software is developing this CMS.  Some features are:  A data-driven plugin architecture enables flexibility in content.  An example of a plubin that is under development for this CMS is a page to present video content (Church services from YouTube).

This CMS could be easily integrated into an existing web site, it's .MVC.   It was also built with the goal in mind of making individual areas of responsibility for editors.   So a person with the right to edit one area can't access others. 

This software uses [Kendo UI controls](http://www.kendoui.com/web.aspx),  and the Kendo editor has provision for adding custom tools.    I added a custom form builder tool to my CMS.   So any form is really easy for anyone to build into their pages.

Prairie CMS is a .Net 4.0 Entity Framework MVC app written in C#.  It uses SQL Server for data storage.  (Express, Compact, or Standard)

The scripts in this CMS leverage these opensource projects:
boilerplatejs
bootstrap
crossroads
flot
hasher
jquery
kendo
knockout
modernizr
pubsub
require
signals
underscore
toastr

Begin Documentation:

Plugin Architecture:

Table CMSLevelMapping contains entries for content types supported by the software.
Page
Sub_Page
Form
Sub_Div
Email
Module

Table CMSContent_Type contains the code which is used for each content type.  
These level definitions are not fully coded.
An example of one that works is Form and these are the user defined form items that can be inserted into the content of the page.
Module content type defines the tags which can be inserted into the content of the page - {{MessagesView}} for example will load up an instance of IMessagesView if one exists and the IMessagesView will be responsible for injecting html into the page.

To use a plugin module, add a reference to PrairiePluginLib to your project.  In your project, add a public class that implements interface IModule.  IModule interface defines a method called GetHtml() - this will be called by Prairie CMS when the content which is being loaded contains an section of content defined as a Module in the ContentType table.

Admin pages for plugins are accessed through the IModule interface
