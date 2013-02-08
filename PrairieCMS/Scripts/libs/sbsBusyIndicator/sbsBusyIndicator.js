
define([], function () {

    var sbsBusyIndicator = function () {

    }
    sbsBusyIndicator.showBusy = function () {
        $("#IsBusy").removeClass("notbusy");
        $("#IsBusy").addClass("busy");
    };

    sbsBusyIndicator.hideBusy = function () {
        $("#IsBusy").removeClass("busy");
        $("#IsBusy").addClass("notbusy");
    };

    return sbsBusyIndicator;
});


