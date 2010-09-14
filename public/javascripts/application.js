// debugging //////////////////////////////////////////////////////////
var has_console = "console" in window && (typeof console.log != "undefined");
var logger = {
  msg_style: "insert"  // insert or overwrite
}
function log(msg) {
  if (has_console) {
    console.log(msg);
  }
  else {
    if (logger.msg_style == "insert")
      $$(".debug").invoke('insert', msg+"<br/>");
    else if (logger.msg_style == "overwrite")
      $$(".debug").invoke('update', msg);
  }
}
