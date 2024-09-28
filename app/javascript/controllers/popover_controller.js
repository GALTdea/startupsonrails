import { Controller } from "@hotwired/stimulus"
import { Popover } from "../custom/popover"

export default class extends Controller {
  static values = {
    content: String,
    placement: { type: String, default: 'top' }
  }

  connect() {
    this.popover = new Popover(this.element, {
      content: this.contentValue,
      placement: this.placementValue
    })
    this.popover.init()
  }

  disconnect() {
    if (this.popover) {
      this.popover.destroy()
    }
  }
}
