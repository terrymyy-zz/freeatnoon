$(document).ready(function() {
    $("#user_phone_number").mask("(999) 999-9999");

    $("#join-group-button").click(function(e) {
	e.preventDefault();
        $("#user-info-form").show();
        $("#signup-button").hide();
        $("#welcome-message").hide();
    });

    $("#continue-button").click(function(e){
        e.preventDefault(); //This prevents the form from submitting normally
        var user_info = $(this).serializeObject();
        console.log("About to post to /users: " + JSON.stringify(user_info));
        $.ajax({
            type: "POST",
            url: "/users/",
            data: user_info,
            success: function(data){
                console.log("Response: " + JSON.stringify(data));
                $("#user-info-form").hide();
                $("#time-info-form").show();
            },
	    error: function (data) {
                var errors = $.parseJSON(data["responseText"])["errors"];
                console.log("Failed: " + JSON.stringify(errors));
                var msg = "";
                for (var key in errors) {
                    msg += "["+key +"]: "+ errors[key]+"\n";
                }
		alert("Failed creating user.\n"+msg);
	    },
            dataType: "json"
        });
    });

    $("#submit-button").click(function(e) {
	e.preventDefault();
        var badDates = $("input[type='checkbox']")
                        .filter(function(idx) { return this.checked })
                        .map(function() { return {date: $(this).val()} }).get();
	$.ajax({
	    type: "POST",
	    url: "/bad_dates/",
	    data: JSON.stringify({bad_dates: badDates,
                                  leaving_date: $("#leaving-date").val()}),
	    dataType: "json",
	    contentType: "application/json",
            success: function(data){
                console.log("Response: " + JSON.stringify(data));
                $("#time-info-form").hide();
                $("#thankyou-message").show();
            },
	    error: function (data) {
                console.log("Failed: " + data);
		alert("Failed creating user bad dates.");
	    }
	});
    });
});

$.fn.serializeObject = function() {
  var values = {}
  $("form input, form select, form textarea").each( function(){
    values[this.name] = $(this).val();
  });

  return values;
}
