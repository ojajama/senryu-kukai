import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (window.innerWidth <= 640) {
      this.element.removeAttribute("open")
    }
  }
}
