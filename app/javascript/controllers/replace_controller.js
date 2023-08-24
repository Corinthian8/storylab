import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="post-replace"
export default class extends Controller {
  static values = { scriptId: Number }
  static targets = ["scriptBody"]

  // When connected, this will open a connection with the PostChannel using the id from the values
  // The received method indicates what happens with the data received.
  // In this example it is a one line replacement but can be a more complicated method
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "PostChannel", id: this.scriptIdValue },
      { received: data => this.scriptBodyTarget.innerHTML = data }
    )
    console.log("connected to ", this.channel)
  }

  // Best practice is to have an unsubscribe
  disconnect() {
    this.channel.unsubscribe()
  }
}
