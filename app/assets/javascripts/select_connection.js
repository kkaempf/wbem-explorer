//
// Observe changes in the 'connection' select field
//

$(document).ready(function() {
  $('#connection_connection').change(function()
  {
    window.location.replace("/connections/" + $(this).val() + "/connect");
  });
  $('#tree').dynatree({
    // using default options
  });
});
