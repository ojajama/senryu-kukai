import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("focus", this.moveCursorToEnd)
    this.element.focus()
  }

  disconnect() {
    this.element.removeEventListener("focus", this.moveCursorToEnd)
  }

  moveCursorToEnd = () => {
    const len = this.element.value.length
    this.element.setSelectionRange(len, len)
  }
}
