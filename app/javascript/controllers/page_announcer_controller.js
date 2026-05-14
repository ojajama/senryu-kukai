import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:load", this.announce)
  }

  disconnect() {
    document.removeEventListener("turbo:load", this.announce)
  }

  announce = () => {
    this.element.textContent = ""
    requestAnimationFrame(() => {
      this.element.textContent = document.title
    })
  }
}
