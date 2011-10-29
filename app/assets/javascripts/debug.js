/*
 * a simple debug window handler
 *
 * just include 'debug.js' and call 
 *   debug ("Blah blah");
 * in your javascript.
 *
 */

    var _debug_console = null;
    function debug(msg)
    {
	if ((_debug_console == null) || (_debug_console.closed)) {
	    _debug_console = window.open("", "debug console", "width=600;height=300;resizable");
	    _debug_console.document.open("text/plain");
	}
	_debug_console.focus();
	_debug_console.document.writeln(msg);
	_debug_console.document.writeln("<br>");
    }
