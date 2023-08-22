import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="background-switch"
export default class extends Controller {
  static targets = ["block1", "block2", "block3", "block4", "block5", "block6",
                    "block7", "block8", "block9", "block10", "block11", "block12" ]

    connect() {
    const imageDivs = [this.block1Target, this.block2Target, this.block3Target, this.block4Target, this.block5Target, this.block6Target,
              this.block7Target, this.block8Target, this.block9Target, this.block10Target, this.block11Target, this.block12Target, ]
    let index
    setInterval(() => {
      imageDivs.forEach( (div) => {
        div?.classList.remove("show-image");
      })
      let randomIndex = Math.ceil(Math.random() * imageDivs.length)
      while (index == randomIndex) {
        randomIndex = Math.ceil(Math.random() * imageDivs.length)
      }
      index = randomIndex
      console.log(randomIndex);
      imageDivs[randomIndex]?.classList.add("show-image");
    }, 2000);
  }

}
