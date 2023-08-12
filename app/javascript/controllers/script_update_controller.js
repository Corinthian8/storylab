import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="script-update"
export default class extends Controller {
  static targets = ["script", "duration", "tone", "audience", "regenerate"]

  connect() {
    console.log("this is the script update controller")
  }

  generate(event) {
    preventDefault()
    console.log(this.event)
  }
}
