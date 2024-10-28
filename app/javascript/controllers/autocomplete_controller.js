import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    console.log("Autocomplete connected")
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.performSearch()
    }, 300)
  }

  performSearch() {
    const query = this.inputTarget.value.trim()
    const isLocation = this.inputTarget.id === "location-search"
    if (query.length > 1) {
      const searchParam = isLocation ? `location=${encodeURIComponent(query)}` : `query=${encodeURIComponent(query)}`
      fetch(`/companies?${searchParam}`, {
        headers: {
          "Accept": "text/vnd.turbo-stream.html, application/json",
          "X-Requested-With": "XMLHttpRequest"
        }
      })
        .then(response => {
          const contentType = response.headers.get("Content-Type")
          if (contentType && contentType.includes("text/vnd.turbo-stream.html")) {
            return response.text().then(html => {
              Turbo.renderStreamMessage(html)
            })
          } else {
            return response.json().then(data => {
              this.resultsTarget.innerHTML = data.map(company => {
                return `<li class="list-group-item" data-id="${company.id}" data-action="click->autocomplete#select">${company.name} - ${company.location}</li>`;
              }).join('');
              this.showResults()
            })
          }
        })
    } else {
      this.clearResults()
    }
  }

  select(event) {
    const companyId = event.currentTarget.getAttribute('data-id');
    window.location.href = `/companies/${companyId}`;
  }

  showResults() {
    this.resultsTarget.classList.remove('d-none')
  }

  clearResults() {
    this.resultsTarget.innerHTML = ''
    this.resultsTarget.classList.add('d-none')
  }

  clearFilter() {
    this.inputTarget.value = "";
    this.clearResults();
    this.element.requestSubmit();
  }
}