import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.focus()
    const len = this.element.value.length
    this.element.setSelectionRange(len, len)
  }
}
