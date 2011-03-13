// debugging //////////////////////////////////////////////////////////
var has_console = "console" in window && (typeof console.log !== "undefined");
var logger = {
	msg_style : "insert" // insert or overwrite
}
var DEBUG = false; // this should be can be true in development

function log(msg) {
	if (!DEBUG)
		return;

	if (has_console) {
		console.log(msg);
	} else {
		if (logger.msg_style == "insert")
			$(".debug").append(msg + "<br/>");
		else if (logger.msg_style == "overwrite")
			$(".debug").html(msg);
	}
}

// ///////////////////////////////////////////////////////////////////

var FLASH_MSG_DISPLAY_TIME = 4500;

function display_flash(msg, msgtype) {
	if (!msg)
		return;

	// get type from msg, it is at the start and surrounded by square brackets
	if (typeof msgtype === 'undefined') {
		var matches = msg.match(/^\[(\w+)\]/);
		// log(matches);
		// returns an array:
		// ["text that was matched", "text matched by capturing parenthese"...]
		if (matches.length != 2) {
			log("display_flash(): Error with flash format: " + msg);
			return;
		}
		msgtype = matches[1];
		msg = msg.substring(matches[0].length);
	}
	element = $('<div class="' + msgtype + '"></div>').appendTo('#flash');
	// log("displaying flash message:");
	// log(element);
	// log(msg);

	element.stop();
	element.hide();
	element.queue(function() {
		$(this).html(msg);
		$(this).dequeue();
	});
	element.slideDown();
	element.delay(FLASH_MSG_DISPLAY_TIME);
	element.slideUp();
	element.queue(function() {
		$(this).parent().empty();
		$(this).dequeue();
	});
}

// Flash animations
$(document).ready(function() {
	$("#flash > div").delay(FLASH_MSG_DISPLAY_TIME).slideUp('fast');

	$("#flash > div").live("click", function() {
		// log("flash msg clicked");
		$(this).stop();
		$(this).slideUp('fast');
	});
});

function blink(element) {
	// TODO: return to previous opacity
	var opacity = element.css('opacity');
	element.fadeTo('fast', opacity / 2);
	element.fadeTo('slow', opacity);
}

// used to display ajax flash notices
$(document).ajaxComplete(function(event, request, options) {
	// log("ajax complete received");
	// log(event);
	// log(request);
	// log(options);
	// var msg = request.getResponseHeader('X-Flash');
	// log(msg);
	display_flash(request.getResponseHeader('X-Flash'));
});

function isiPhone() {
  return (
      (navigator.platform.indexOf("iPhone") != -1) ||
      (navigator.platform.indexOf("iPod") != -1) ||
      (navigator.userAgent.match(/iPhone/i)) ||
      (navigator.userAgent.match(/iPod/i))
  );
}