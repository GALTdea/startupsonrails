import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submitButton"]
  submit() {
    this.submitButtonTarget.click();
  }
}