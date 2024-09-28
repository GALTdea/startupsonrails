import { Controller } from "@hotwired/stimulus"
import { Popover } from "../custom/popover"

// Connects to data-controller="popover"
export default class extends Controller {
  connect() {
    const popoverTriggerList = document.querySelectorAll('[data-popover]')
    this.popovers = [...popoverTriggerList].map(popoverTriggerEl => {
      const content = popoverTriggerEl.getAttribute('data-popover-content')
      const placement = popoverTriggerEl.getAttribute('data-popover-placement') || 'top'
      const popover = new Popover(popoverTriggerEl, { content, placement })
      popover.init()
      return popover
    })
  }

  disconnect() {
    if (this.popovers) {
      this.popovers.forEach(popover => popover.destroy())
    }
  }
}
