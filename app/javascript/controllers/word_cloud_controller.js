import { Controller } from "@hotwired/stimulus"
import script_update_controller from "./script_update_controller";

// Connects to data-controller="word-cloud"
export default class extends Controller {
  static values = {words: Array}

  connect() {

    // List of words
    var myWords = this.wordsValue
    var wordCloud = [{word: myWords[0], size: "60"}, {word: myWords[1], size: "60"},
                    {word: myWords[2], size: "50"}, {word: myWords[3], size: "50"},
                    {word: myWords[4], size: "40"}, {word: myWords[5], size: "40"}];

    // set the dimensions and margins of the graph
    var margin = {top: 0, right: 0, bottom: 0, left: 0},
        width = 400 - margin.left - margin.right,
        height = 400 - margin.top - margin.bottom;

    // append the svg object to the body of the page
    var svg = d3.select("#my_dataviz").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform",
              "translate(" + margin.left + "," + margin.top + ")");

    // Constructs a new cloud layout instance. It run an algorithm to find the position of words that suits your requirements
    // Wordcloud features that are different from one word to the other must be here
    var layout = d3.layout.cloud()
      .size([width, height])
      .words(wordCloud.map(function(d) { return {text: d.word, size:d.size}; }))
      .padding(5)        //space between words
      .rotate(function() { return ~~(Math.random() * 2) * 360; })
      .fontSize(function(d) { return d.size; })      // font size of words
      .on("end", draw);
    layout.start();

    // This function takes the output of 'layout' above and draw the words
    // Wordcloud features that are THE SAME from one word to the other can be here
    function draw(words) {
      svg
        .append("g")
          .attr("transform", "translate(" + layout.size()[0] / 2 + "," + layout.size()[1] / 2 + ")")
          .selectAll("text")
            .data(words)
          .enter().append("text")
            .style("font-size", function(d) { return d.size; })
            .style("fill", "#ffd700")
            .style("text-shadow", "1px 1px 3px grey")
            .attr("text-anchor", "middle")
            .style("font-family", "Poppins")
            .attr("transform", function(d) {
              return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
            })
            .text(function(d) { return d.text; });
    }
  }
}
