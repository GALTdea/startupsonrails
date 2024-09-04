import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="rich-text"
export default class extends Controller {
  connect() {
    this.resizeTextarea()
    this.element.addEventListener('input', this.resizeTextarea.bind(this))
  }

  resizeTextarea() {
    this.element.style.height = 'auto'
    this.element.style.height = `${this.element.scrollHeight}px`
  }
}
