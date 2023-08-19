import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editableText", "editButton"];

  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  update() {
    console.log("This is update");
    const editedText = this.editableTextTarget.innerHTML;
    console.log(editedText)
    const formattedText = editedText.replace(/\n/g, '<br>');
    // console.log(formattedText);

    let formData = new FormData()
    formData.append("script[script_body]", formattedText)
    console.log(window.location.pathname)
    // body : JSON.stringify({"script[script_body]": formattedText}) <- didn't work
    event.preventDefault()

    fetch(window.location.pathname, {
      method: "PATCH",
      headers: {"Accept": "text/plain"},
      body: formData
    })
    .then(response => response.text())
    .then(data => {
      console.log(data);
    })
    .catch(error => {
      console.error(error);
    });
  };

  enableEditMode(event) {
    // Stop the click event from propagating further and losing focus
    event.stopPropagation();

    // Disable the Edit button
    this.editButtonTarget.disabled = true;

    const pElement = this.editableTextTarget;
    const text = pElement.innerHTML.replace(/\n/g, '<br>');


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
    saveButton.type = "submit";
    textareaElement.parentNode.insertBefore(saveButton, textareaElement.nextSibling);

    // add event listener that points to update
    saveButton.addEventListener("click", () => {
      const editedText = textareaElement.value;
      const formattedText = editedText;
      pElement.innerHTML = formattedText.replace(/\n/g, '<br>');
      textareaElement.replaceWith(pElement);

      this.update();

      saveButton.remove();
    });

    // Wait for the next frame before focusing to give the textarea time to render
    requestAnimationFrame(() => {
      console.log("hello from request animation frame")
      textareaElement.focus();

      // Attach event listener to save changes when "Save" button is clicked


        // Enable the Edit button again
        this.editButtonTarget.disabled = false;

        // Send the updated content to the server using Ajax
        // const scriptId = @script = Script.find(params[:id]);
      });
    }
}
