import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "companyId"]

  connect() {
    console.log("%c Category Autocomplete controller connected", "color: green; font-weight: bold;")
  }

  search() {
    console.log("Search method called")
    const query = this.inputTarget.value.trim()

    if (query.length < 2) {
      this.clearResults()
      return
    }

    fetch(`/companies/search?query=${encodeURIComponent(query)}`)
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok')
        }
        return response.json()
      })
      .then(data => this.showResults(data))
      .catch(error => {
        console.error("Error:", error)
        this.clearResults()
      })
  }

  showResults(data) {
    if (Array.isArray(data) && data.length > 0) {
      this.resultsTarget.innerHTML = this.buildResultsList(data)
      this.resultsTarget.classList.remove("d-none")
    } else {
      this.clearResults()
    }
  }

  buildResultsList(data) {
    return data.map(company => `
      <li class="list-group-item" data-action="click->category-autocomplete#select" data-company-id="${company.id}">
        ${company.name}
      </li>
    `).join('')
  }

  selectCompany(event) {
    const companyName = event.target.textContent
    const companyId = event.target.dataset.companyId
    this.inputTarget.value = companyName
    this.companyIdTarget.value = companyId
    this.resultsTarget.innerHTML = ""
  }

  select(event) {
    const companyId = event.currentTarget.dataset.companyId
    const companyName = event.currentTarget.textContent.trim()

    this.inputTarget.value = companyName
    this.element.querySelector('input[name="company_id"]').value = companyId
    this.clearResults()
  }

  clearResults() {
    this.resultsTarget.innerHTML = ""
    this.resultsTarget.classList.add("d-none")
  }
}