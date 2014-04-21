$(document).ready(function() {
    var isDragging = false;

    $(".slot").mousedown(function(event) {
	isDragging = true;
	$(this).toggleClass("selected");
	event.preventDefault();
    });

    $(".slot").mouseover(function() {
	if (isDragging) {
	    $(this).toggleClass("selected");
	}
    });

    $(window).mouseup(function() {
	isDragging = false;
    });

    $("#timeslot-submit-button").click(function(e) {
	e.preventDefault();
	var slots = [];
	var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
	for (var i=0; i<days.length; i++) {
	    var day = days[i];
	    var selected = $(".selected."+day);
	    for (var j=0; j<selected.length; j++) {
		var time = parseFloat(selected[j].id.substring(4));
		if (slots[i]) {
		    slots[i].push(time);
		} else {
		    slots[i] = [time];
		}
	    }
	    _.map(slots, function(arr) {arr.sort(function(a,b) { return a-b; })});
	}

	for (var i=0; i<slots.length; i++) {
	    if (!slots[i]) continue;
	    var selected = slots[i];
	    var start = selected[0];
	    var end = selected[0];
	    for (var j=1; j<selected.length; j++) {
		if (selected[j]-selected[j-1] === 0.25)
		    end = selected[j];
		else {
		    post_free_time(i, start, end-start+0.25);
		    start = selected[j];
		    end = selected[j];
		}
	    }
	    post_free_time(i, start, end-start+0.25);
	}
    });
});

function post_free_time(day, time, duration) {
    console.log("time: "+ time+ ", day: "+day+", length: "+duration);
    $.ajax({
	type: "POST",
	url: "/free_times/",
	data: { free_time: { day: time, day: time, duration: duration } },
	dataType: "json",
	success: function (data) {
	    alert(data);
	    return false;
	},
	error: function (data) {
	    return false;
	}
    });
}
