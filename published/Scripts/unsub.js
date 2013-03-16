
var unsub = {
    leave: function () {
        var email = $("#email").val();
        $("#intro").fadeOut();
        $.post("/unsub/confirm", { emailToRemove: email },
            function (data) {
                $('h1').first().html(data.Title);
                $('h2').first().html(data.Message);
            });
    }
};

$(document).ready(function () {
    $("#menu").fadeOut();
    $("#login").fadeOut();
    $("#sendConfirmation").click(function () {
        unsub.leave();
        return false;
    });

});