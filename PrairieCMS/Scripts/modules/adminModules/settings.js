define([], function() {
	return {
	    urls: {
            menu_item_delete: "/sitemap/removeMenuItem",
	        menu_item_data: "/sitemap/getMenuItem",
	        menu_data: "/sitemap/GetMenuById",
	        menu_options: "/formData/getmenus",
	        save_menu_option: "/sitemap/save_menu_option",
		    content_template: "/jobs/setcontent" ,
            list_of_content: "/formData/GetContent" ,
            edit_content: "/content/editcontent",
            content_item_delete: "/content/removeContentItem",
            list_of_wrappers: "/formData/GetWrappers",
            wrapper_data: "/wrapper/GetwrapperById",
            edit_wrapper: "/wrapper/save_wrapper_option"
		}
	}
}); 
