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
//= require d3
//= require d3.layout
//= require d3.geom
//= require_self
//#disabled: require_tree .

//$(document).ready(function() {
//  $('#tree').dynatree({
//    // using default options
//  });
//});


var update_status = function(data) {
  $.ajax({
    url: "/status/update",
    data: {status: data.data, format: "html"},
    success: function(data) {
      $("#status").replaceWith(data);
    },
    cache: false
  });
}
  
$(function(){

$("#left_sidebar_tree").dynatree({
  onClick: function(node, event) {
    var e = node.getEventTargetType(event);
    if (e == "title") {
      var k = node.data.key;
      if (!k) {
        return false;
      }
      switch (k.controller) {
        case "connections":
          node.activateSilently();
          $.ajax({
            url: "/connections/"+k.id+"/"+k.action,
	    data: { mode: "dynatree", format: "json" },
            success: function(data) { // gets the data from respond_with
	      update_status(data);
	    },
	    cache: false
          });
	  break;
        case "classnames":
	  window.location.href = "/classnames?ns="+k.ns
	  break;
        case "models":
          node.activateSilently();
	  window.location.href = "/cim_classes?model="+k.id
          break;
        default:
      };
    }
  },
  onLazyRead: function(node) {
    node.appendAjax({
      url: "/"+node.data.key,
      data: {"format": "json",
             "key": node.data.key,
             "mode": "dynatree" },

      success: function(data) { },
      error: function(node, XMLHttpRequest, textStatus, errorThrown) { },
      cache: false
    });
  }
});
});
