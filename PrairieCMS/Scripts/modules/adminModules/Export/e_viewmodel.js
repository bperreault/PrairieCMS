define(["Boiler"],
function (Boiler) {

    var ViewModel = function (moduleContext) {

        var self = this;
        self.fileLocation = ko.observable();
        self.url = moduleContext.getSettings().urls.exportContent;

        self.backToHome = function () {
            Boiler.UrlController.goTo("/");
        }

        self.initialize = function () {

        };

    };

    return ViewModel;
});

//                        ///////////http://www.kendoui.com/forums/ui/editor/inserthtml-from-datasource.aspx//////
//                        var selectBox = $(".k-insertHtml select").data("kendoSelectBox");
//                        if (selectBox) {
//                            selectBox.options.autoBind = false;
//                            selectBox.setDataSource(self.contentPieces());
//                            ko.applyBindings(self, $(".k-insertHtml select"));
//                        }

//                        selectBox.text("Insert Token");
//                       // selectBox.options.dataSource=data.contentPieces;
//                        ///////////////
//                        Used $(".k-insertHtml").hide(); to hide the insertHtml dropdown control. And linked another menu to this control.

//// https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&ved=0CDcQFjAB&url=http%3A%2F%2Fwww.kendoui.com%2Fforums%2Fui%2Feditor%2Fget-cursor-position-in-textbox.aspx&ei=nPBjUYGHEpXH4APmrYCACg&usg=AFQjCNFqQz-7MqTNk8Y8iNrsEnDdKlLQ9A
////When user clicks on a variable in the list menu, insert this variable in the mail text.
//function addMailVariableToBodyText(selected_item) {
//    var editor = $("[id$='_txtMailBody']").data("kendoEditor");
//    editor.exec("inserthtml", { value: " %" + selected_item.id + "% " });
//}


   
