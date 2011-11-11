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
//    alert('clicked ' + node.getEventTargetType(event));
  },
  onLazyRead: function(node){
    node.appendAjax({
      url: "/"+node.data.key,
      data: {"format": 'json',
             "key": node.data.key, // Optional url arguments
             "mode": "dynatree" },

      // (Optional) use JSONP to allow cross-site-requests
      // (must be supported by the server):
//      dataType: "jsonp",
      success: function(node) { // Called after nodes have been created and the waiting icon was removed.
                               // 'this' is the options for this Ajax
			       request
                              },
      error: function(node, XMLHttpRequest, textStatus, errorThrown) { // Called on error, after error icon was created.
                               },
      cache: false // Append random '_' argument to url to prevent caching.
    });
  }});
});