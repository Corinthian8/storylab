import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="video-player"
export default class extends Controller {
  static targets = ["0", "1", "2", "thumbnails", "video"]

  play(event) {
    console.log(event.currentTarget);
    const id = event.currentTarget.id;
    this.videoTarget.outerHTML="";
    this.element.insertAdjacentHTML("beforeend",
    `<iframe class="py-2 large-thumbnail" data-video-player-target="video" width="100%" height="315" src="https://www.youtube.com/embed/${id}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen autoplay loop muted playsinline></iframe>`
    );
  }
}
