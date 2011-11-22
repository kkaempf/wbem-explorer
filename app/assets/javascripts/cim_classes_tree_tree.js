// Display classes as dynamic tree
//
$(function(){

  $("#classes_tree").dynatree({
    onClick: function(node, event) {
      var e = node.getEventTargetType(event);
      console.log("CimClass onClick " + e + ": " + node.data.title);
      if (e === 'title') {
        window.location.href = "/cim_classes/"+node.data.title;
      }
    }
  });

});
