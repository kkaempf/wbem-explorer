$(function(){

  var w = 800,
      h = 600,
      fill = d3.scale.category20();

  var vis = d3.select("#viewport").append("svg:svg")
      .attr("width", w)
      .attr("height", h);

  $('#classnames_data > div').each(function(index) {
    n = $(this).attr('id');
    console.log("Class "+n);
    var x = Math.random() * (w-80);
    var y = Math.random() * (h-20);
    vis.append("svg:rect")
       .attr("x", x)
       .attr("y", y)
       .attr("width", 80)
       .attr("height", 20)
       .style("fill", "orange")
       .append("svn:text")
       .attr("x", x)
       .attr("y", y)
       .attr("dx", -40)
       .attr("dy", "1.2em")
       .attr("text-anchor", "middle")
       .text(n)
       .attr("fill", "white");
  });

});
