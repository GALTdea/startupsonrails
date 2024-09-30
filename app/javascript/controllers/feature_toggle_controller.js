import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="feature-toggle"
export default class extends Controller {
  static targets = ["button"]

  toggle(event) {
    event.preventDefault()
    const categoryId = this.buttonTarget.dataset.categoryId

    fetch(`/categories/${categoryId}/toggle_featured`, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      credentials: 'same-origin'
    })
      .then(response => response.json())
      .then(data => {
        this.updateButtonText(data.featured)
      })
  }

  updateButtonText(featured) {
    this.buttonTarget.textContent = featured ? "Unfeature Category" : "Feature Category"
    this.buttonTarget.classList.toggle("btn-primary", !featured)
    this.buttonTarget.classList.toggle("btn-secondary", featured)
  }
}
