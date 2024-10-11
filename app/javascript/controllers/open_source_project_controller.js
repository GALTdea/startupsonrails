import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="open-source-project"
export default class extends Controller {
  static targets = ["form", "errors"]

  connect() {
    console.log("OpenSourceProject controller connected")
  }

  async submitForm(event) {
    event.preventDefault()
    const form = this.formTarget
    const formData = new FormData(form)

    try {
      const response = await fetch(form.action, {
        method: form.method,
        body: formData,
        headers: {
          "Accept": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      })
      const data = await response.json()

      if (response.ok) {
        this.projectListController.addProject({ detail: data })
        form.reset()
        this.errorsTarget.textContent = ''
        this.errorsTarget.style.display = 'none'
      } else {
        this.errorsTarget.textContent = data.errors.join(', ')
        this.errorsTarget.style.display = 'block'
      }
    } catch (error) {
      console.error('Error:', error)
      this.errorsTarget.textContent = 'An unexpected error occurred. Please try again.'
      this.errorsTarget.style.display = 'block'
    }
  }

  get projectListController() {
    return this.application.getControllerForElementAndIdentifier(this.element, 'project-list')
  }
}
