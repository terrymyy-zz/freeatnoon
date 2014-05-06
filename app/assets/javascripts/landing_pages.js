$(document).ready(function() {
    $("#user_phone_number").mask("(999) 999-9999");

    $("#join-group-button").click(function(e) {
	e.preventDefault();
        $("#user-info-form").show();
        $("#signup-button").hide();
        $("#welcome-message").hide();
    });

    $("#continue-button").click(function(e) {
	e.preventDefault();
        $("#user-info-form").hide();
        $("#time-info-form").show();
    });
});
