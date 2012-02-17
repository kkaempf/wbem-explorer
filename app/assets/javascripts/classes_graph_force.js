console.log("classes_graph_force.js");

$(function() {
  var w = 800,
      h = 600,
      fill = d3.scale.category20();

  var vis = d3.select("#viewport").append("svg:svg")
      .attr("width", w)
      .attr("height", h);

  d3.json("cim_classes/data.json?model=11&layout=force", function(json) {

    var force = d3.layout.force()
      .charge(-300)
      .linkDistance(200)
      .nodes(json.nodes)
      .links(json.links)
      .size([w, h])
      .start();
    
    var link = vis.selectAll("line.link")
        .data(json.links)
        .enter().append("svg:line")
        .attr("class", "link")
        .style("stroke-width", 2)
        .attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    var node = vis.selectAll("rect.node")
        .data(json.nodes)
        .enter().append("svg:rect")
        .attr("class", "node")
        .attr("x", function(d) { return d.x; })
        .attr("y", function(d) { return d.y; })
        .attr("rx", 5)
        .attr("ry", 10)
        .attr("height", 10)
        .attr("width", function(d) { return d.name.length*0.8 + "em"; })
        .style("fill", function(d) { return fill(d.group); })
        .call(force.drag);

    var text = vis.selectAll("text.name")
      .data(json.nodes)
      .enter().append("svg:text")
      .attr("class", "name")
      .attr("x", function(d) { return d.x; })
      .attr("y", function(d) { return d.y; })
      .attr("dx", 5)
      .attr("dy", "1em")
      .style("fill", "black")
      .text(function(d) { return d.name; })
      .call(force.drag);

    force.on("tick", function() {
      link.attr("x1", function(d) { return d.source.x; })
          .attr("y1", function(d) { return d.source.y; })
          .attr("x2", function(d) { return d.target.x; })
          .attr("y2", function(d) { return d.target.y; });

      node.attr("x", function(d) { return d.x; })
          .attr("y", function(d) { return d.y; });
      text.attr("x", function(d) { return d.x; })
          .attr("y", function(d) { return d.y; });
    });
  });
});
