// debugging //////////////////////////////////////////////////////////
var has_console = "console" in window && (typeof console.log !== "undefined");
var logger = {
  msg_style: "insert"  // insert or overwrite
}
var DEBUG = true;

function log(msg) {
  if (!DEBUG) return;
  
  if (has_console) {
    console.log(msg);
  }
  else {
    if (logger.msg_style == "insert")
      $(".debug").append(msg+"<br/>");
    else if (logger.msg_style == "overwrite")
      $(".debug").html(msg);
  }
}
