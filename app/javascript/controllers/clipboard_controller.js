import { Controller } from "@hotwired/stimulus"

export default class ClipboardController extends Controller {
  static targets = ["source", "trigger"]

  copy(event) {
    event.preventDefault()
    const textContent = this.sourceTarget.innerHTML
    const textWithLineBreaks = textContent.replace(/<br\s*\/?>/g, "\n")

    console.log("Text with line breaks:", textWithLineBreaks); // Add this line

    navigator.clipboard.writeText(textWithLineBreaks)

    this.sourceTarget.focus()
    var triggerElement = this.triggerTarget
    var initialHTML = triggerElement.innerHTML
    triggerElement.innerHTML = "<i class=\"fa-solid fa-copy\"></i>"
    setTimeout(() => {
      triggerElement.innerHTML = initialHTML
      // unfocus
      this.sourceTarget.blur()
    }, 2000)
  }
}
