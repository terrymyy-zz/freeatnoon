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
	var slots = {};
	var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
	for (var i=0; i<days.length; i++) {
	    var day = days[i];
	    var selected = $(".selected."+day);
	    for (var j=0; j<selected.length; j++) {
		var time = parseFloat(selected[j].id.substring(4));
		if (day in slots) {
		    slots[day].push(time);
		} else {
		    slots[day] = [time];
		}
	    }
	    _.map(slots, function(arr) {arr.sort(function(a,b) { return a-b; })});
	}

	for (var day in slots) {
	    var selected = slots[day];
	    var start = selected[0];
	    var end = selected[0];
	    for (var i=1; i<selected.length; i++) {
		if (selected[i]-selected[i-1] === 0.25)
		    end = selected[i];
		else {
		    console.log("time: "+ start+ ", day: "+day+", length: "+(end-start+0.25));
		    start = selected[i];
		    end = selected[i];
		}
	    }
	    console.log("time: "+ start+ ", day: "+day+", length: "+(end-start+0.25));
	}
	window.result = slots;
  });
});

