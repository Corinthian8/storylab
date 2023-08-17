// app/javascript/controllers/editable_text_controller.js
import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["editableText", "editButton"];
  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  enableEditMode(event) {
    // Stop the click event from propagating further and losing focus
    event.stopPropagation();

    // Disable the Edit button
    this.editButtonTarget.disabled = true;

    const pElement = this.editableTextTarget;
    const text = pElement.innerHTML.replace(/<br>/g, "\n");


    // Create a textarea element with the text and replace the paragraph element
    const textareaElement = document.createElement("textarea");
    textareaElement.value = text;
    textareaElement.style.resize = "none"; // Disable resizing
    textareaElement.style.height = "800px";
    textareaElement.style.width = "790px";
    pElement.replaceWith(textareaElement);

    // Create a "Save" button
    const saveButton = document.createElement("button");
    saveButton.textContent = "Save";
    saveButton.className = "btn btn-primary";
    saveButton.type = "button";
    textareaElement.parentNode.insertBefore(saveButton, textareaElement.nextSibling);

    // Wait for the next frame before focusing to give the textarea time to render
    requestAnimationFrame(() => {
      textareaElement.focus();

      // Attach event listener to save changes when "Save" button is clicked
      saveButton.addEventListener("click", () => {
        const editedText = textareaElement.value;
        const formattedText = editedText.replace(/\n/g, "<br>");
        pElement.innerHTML = formattedText;
        textareaElement.replaceWith(pElement);
        saveButton.remove();

        // Enable the Edit button again
        this.editButtonTarget.disabled = false;
      });
    });
  }
}
