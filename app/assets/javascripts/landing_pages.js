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


    $("#submit-button").click(function(e) {
	e.preventDefault();
        var badDates = $("input[type='checkbox']").map(function() { return $(this).val() }).get();
	$.ajax({
	    type: "POST",
	    url: "/bad_dates/",
	    data: JSON.stringify({bad_dates: badDates}),
                                  // leaving_date: $("#leaving-date").val()}),
	    dataType: "json",
	    contentType: "application/json",
	    error: function (data) {
		alert("Failed creating user bad dates.");
	    }
	});
    });
});
