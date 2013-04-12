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
//= require jquery.dynatree-1.2.4
//= require d3
//= require d3.layout
//= require d3.geom
//= require_self
//#disabled: require_tree .

var to_s = function(obj) {
  var output = '';
  for (property in obj) {
    output += property + ': ' + obj[property]+'; ';
  }
  return output;
}

//
// Update the 'connection' status
//
var update_status = function(data) {
  $.ajax({
    url: "/status/update",
    data: {format: "html"},
    success: function(data) {
      $("#connection_status").show();
      $("#connecting").hide();
      $("#connection_status").replaceWith(data);
    },
    cache: false
  });
  $.ajax({
    url: "/status/connected",
    data: {format: "json"},
    success: function(data) {
      console.log("/status/connected returns " + data);
      if (data == true) {
        $("#views_tree").css( 'display', 'block' );
      }
      else {
        $("#views_tree").css( 'display', 'none' );
      }
    },
    cache: false
  });
}

// run when document is ready
$(function(){

// make the views_tree div a dynatree
$("#views_tree").dynatree(
{
  onClick: function(node, event) {
    var e = node.getEventTargetType(event);
    console.log("#views_tree onClick " + e);
    if (e == "title") {
      var d = node.data;
      console.log("#views_tree onClick >" + d + "<, controller " + d.controller);
      if (!d) {
        return false;
      }
      switch (d.key) {
        case "systems":
          window.location.href = "/systems";
          break;
        case "services":
          window.location.href = "/services";
          break;
        case "processes":
          window.location.href = "/processes";
          break;
        case "networks":
          window.location.href = "/networks";
          break;
        case "storages":
          window.location.href = "/storages";
          break;
        default:
          // expanded 'namespaces' and 'models' tree
          console.log("#views_tree onClick d.controller >" + d.controller + "<");
          switch (d.controller) {
            case "classnames":
              window.location.href = "/classnames?ns="+d.ns;
              break;
            case "models":
              node.activateSilently();
              window.location.href = "/cim_classes?model="+d.id;
              break;
            break;
              default:
          };
      };
    }
  },
  // lazy read #views_tree items, like available namespaces, models, etc.
  onLazyRead: function(node) {
    console.log("#views_tree onLazyRead " + node.data.key);
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

//
// Update the clients tree in the left sidebar
//
$("#clients_tree").dynatree({
  onClick: function(node, event) {
    var e = node.getEventTargetType(event);
    if (e == "title") {
      var d = node.data;
      if (!d) {
        return false;
      }
      if (!d.id) {
        return false;
      }
      node.activateSilently();
      $("#connection_status").hide();
      $("#connecting").show();
      $.post("/connections.json?client="+d.id, function(data) { // gets the data from respond_with
	  update_status(data);
        }
      );
    }
  },
  // lazy read available clients
  onLazyRead: function(node) {
    console.log("#clients_tree onLazyRead key >" + node.data.key + "<");
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
}); // #clients_tree

}); // $(function()...
