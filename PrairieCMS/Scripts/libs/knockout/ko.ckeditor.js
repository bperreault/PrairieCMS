//http://stackoverflow.com/questions/10713155/knockout-ckeditor-single-page-app
ko.bindingHandlers.ckeditor = {
    init: function (element, valueAccessor, allBindingsAccessor, context) {
        var options = allBindingsAccessor().ckeditorOptions || {};
        var modelValue = valueAccessor();
        var value = ko.utils.unwrapObservable(valueAccessor());

        $(element).html(value);
        $(element).ckeditor();

        var editor = $(element).ckeditorGet();

        //handle edits made in the editor

        editor.on('blur', function (e) {
            var self = this;
            if (ko.isWriteableObservable(self)) {
                self($(e.listenerData).val());
            }
        }, modelValue, element);
    }
};