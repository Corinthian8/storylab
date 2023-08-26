import { Controller } from "@hotwired/stimulus";
import * as d3 from "d3"; // Import the entire d3 library

export default class extends Controller {
  static values = { words: Array };

  connect() {
    // List of words
    var myWords = this.wordsValue;
    var wordCloud = [
      { word: myWords[0], size: "60" },
      { word: myWords[1], size: "60" },
      { word: myWords[2], size: "50" },
      { word: myWords[3], size: "50" },
      { word: myWords[4], size: "40" },
      { word: myWords[5], size: "40" },
    ];

    // Get the dimensions of the container element
    var container = document.getElementById("my_dataviz");
    var containerWidth = container.clientWidth;
    var containerHeight = container.clientHeight;

    // Set margins
    var margin = { top: 0, right: 0, bottom: 0, left: 0 };

    // Create the SVG element
    var svg = d3
      .select(container)
      .append("svg")
      .attr("width", containerWidth)
      .attr("height", containerHeight)
      .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    // Rest of your code...
    var layout = d3.layout
      .cloud()
      .size([containerWidth, containerHeight]) // Use container dimensions
      .words(
        wordCloud.map(function (d) {
          return { text: d.word, size: d.size };
        })
      )
      .padding(5)
      .rotate(function () {
        return ~~(Math.random() * 2) * 360;
      })
      .fontSize(function (d) {
        return d.size;
      })
      .on("end", draw);
    layout.start();

    function draw(words) {
      svg
        .append("g")
        .attr(
          "transform",
          "translate(" +
            layout.size()[0] / 2 +
            "," +
            layout.size()[1] / 2 +
            ")"
        )
        .selectAll("text")
        .data(words)
        .enter()
        .append("text")
        .style("font-size", function (d) {
          return d.size;
        })
        // .style("fill", "#ffd700")
        // .style("text-shadow", "1px 1px 3px grey")
        .attr("text-anchor", "middle")
        // .style("font-family", "Poppins")
        .attr("transform", function (d) {
          return (
            "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")"
          );
        })
        .text(function (d) {
          return d.text;
        });
    }
  }
}
