import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="background-switch"
export default class extends Controller {
  static targets = ["block1", "block2", "block3", "block4", "block5", "block6",
                    "block7", "block8", "block9", "block10", "block11", "block12", "main-page" ]
  connect() {
    console.log("hey from the switch")
  }


  toggle() {
    var block = getElementbyId(`block${Math.ceil(Math.random() * 12)}`);
    block.classList.remove("blacked-out");
    setTimeout(() => {
      block.classList.add("blacked-out");
    }, 2000)
    // this.block1Target.classList.remove("blacked-out");
    // this.block1Target.classList.add("blacked-out");
  }

}
