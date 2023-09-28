import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="autocomplete"
export default class extends Controller {
  static targets = [ "input", "results" ]
  
  connect() {
    console.log("Autocomplete connected")
  }

  search() {
    if (this.inputTarget.value.length > 1) {
      fetch(`/companies?query=${this.inputTarget.value}`, {
        headers: { "Accept": "application/json" }
      })
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = data.map(company => {
          return `<li data-id="${company.id}" data-action="click->autocomplete#select">${company.name}</li>`;
        }).join('');
      })
    }
  }

  select(event) {
    const companyId = event.currentTarget.getAttribute('data-id');
    window.location.href = `/companies/${companyId}`;
  }
}



