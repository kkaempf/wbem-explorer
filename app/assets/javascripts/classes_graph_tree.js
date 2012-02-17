var text_click = function(event) {
  var target;
  if (!event) var event = window.event;
  if (event.target) target = event.target;
  else if (event.srcElement) target = event.srcElement;
  if (target.nodeType == 3) // Safari bug
    target = target.parentNode;
  name = $(target).attr('name');
  console.log("text_click " + name);
  window.location.href = "/cim_classes/"+name;
};

$(function(){
  var r = 600 / 2;

  var tree = d3.layout.tree()
    .size([360, r])
    .separation(function(a, b) { return (a.parent == b.parent ? 1 : 2) / a.depth; });

  var diagonal = d3.svg.diagonal.radial()
    .projection(function(d) { return [d.y, d.x / 180 * Math.PI]; });

  var vis = d3.select("#viewport").append("svg:svg")
      .attr("width", r * 2 + r/2)
      .attr("height", r * 2)
      .append("svg:g")
      .attr("class", "group")
      // shift 150px to right so root node doesn't get cut off
      .attr("transform", "translate("+(r+150)+","+r+")");

  d3.json(graph_controller()+"/data.json?model="+graph_model()+"&ns="+graph_ns()+"&layout=tree", function(json) {

    var nodes = tree.nodes(json);

  var link = vis.selectAll("path.link")
    .data(tree.links(nodes))
    .enter().append("svg:path")
    .attr("class", "link")
    .attr("d", diagonal);

  var node = vis.selectAll("circle.node")
    .data(nodes)
    .enter().append("svg:circle")
    .attr("class", "node")
    .attr("r", 4.5)
    .attr("transform", function(d) { return "rotate(" + (d.x - 90) + ")translate(" + d.y + ")"; });

  var text = vis.selectAll("text.name")
    .data(nodes)
    .enter().append("svg:text")
    .attr("class", "name")
    .attr("dx", function(d) { return d.x < 180 ? 8 : -8; })
    .attr("dy", ".31em")
    .attr("onclick", "text_click(evt)")
    .attr("text-anchor", function(d) { return d.x < 180 ? "start" : "end"; })
    .attr("name", function(d) { return d.name; })
    // transform/rotate text within group
    .attr("transform", function(d) {
//       console.log(d.name + "@x:" + d.x + ",y:" + d.y);
//       return "rotate(" + (d.x-90) + ")translate(" + d.y + ")rotate("+(70-d.x)+")";
       return "rotate(" + (d.x-90) + ")translate(" + d.y + ")rotate("+(90-d.x)+")";
    })
    .text(function(d) { return d.name; });

  $( "#slider-orientation" ).slider({
    orientation: "vertical",
    range: "min",
    min: 0,
    max: 360,
    value: 70,
    slide: function( event, ui ) {
//      var e = ui.getEventTargetType(event);
      var value = $( "#slider-orientation" ).slider("value" );
      // rotate the text lables
      vis.selectAll("text.name")
      .attr("transform", function(d) {
        return "rotate(" + (d.x-90) + ")translate(" + d.y + ")rotate("+((90-value)-d.x)+")";
      });
      // rotate the branches and leafs
      d3.select(".group")
      .attr("transform", function(d) {
        return "translate("+(r+150)+","+r+")rotate(" + value+")";
      });
    }
  });

  $( "#slider-zoom" ).slider({
    orientation: "horizontal",
    range: "min",
    min: 0,
    max: 300,
    value: 50,
    slide: function( event, ui ) {
//      var e = ui.getEventTargetType(event);
      var value = $( "#slider-zoom" ).slider("value" );
      // scale the branches and leafes
      d3.select("path.link")
      .attr("transform", function(d) {
        return "scale(" + value / 10.0 +")";
      });
    }
  });
});
});
