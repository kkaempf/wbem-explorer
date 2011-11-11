// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.8.16.custom.min
//= require jquery.cookie
//= require jquery.dynatree
//= require_self
//= require_tree .

$(function(){

$("#tree").dynatree({
  onClick: function(node, event) {
    var e = node.getEventTargetType(event);
    if (e == "title") {
      var k = node.data.key;
      switch (k) {
        case "connections":
        case "namespaces":
        case "profiles":
          break;
        default:
          node.activateSilently();
          $.get(
            "/"+node.data.key,
	    { mode: "dynatree", format: "json"},
            function(data) { }
          );
      };
    }
  },
  onLazyRead: function(node){
    node.appendAjax({
      url: "/"+node.data.key,
      data: {"format": "json",
             "key": node.data.key,
             "mode": "dynatree" },

      success: function(node) {
	      request
      },
      error: function(node, XMLHttpRequest, textStatus, errorThrown) { },
      cache: false
    });
  }
});
});
