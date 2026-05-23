import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["upper", "middle", "lower", "preview"]

  connect() {
    this.updatePreview()
  }

  updatePreview() {
    const parts = [this.upperTarget.value, this.middleTarget.value, this.lowerTarget.value]
      .map(s => s.trim())
      .filter(s => s.length > 0)
    this.previewTarget.textContent = parts.join("")
  }

  swapUpperMiddle() {
    const tmp = this.upperTarget.value
    this.upperTarget.value = this.middleTarget.value
    this.middleTarget.value = tmp
    this.updatePreview()
    this.upperTarget.focus()
  }

  swapMiddleLower() {
    const tmp = this.middleTarget.value
    this.middleTarget.value = this.lowerTarget.value
    this.lowerTarget.value = tmp
    this.updatePreview()
    this.middleTarget.focus()
  }

  swapUpperLower() {
    const tmp = this.upperTarget.value
    this.upperTarget.value = this.lowerTarget.value
    this.lowerTarget.value = tmp
    this.updatePreview()
    this.upperTarget.focus()
  }
}
