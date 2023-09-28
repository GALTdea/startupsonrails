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

  haveResults() {
    return this.resultsTarget.children.length > 0;
  }

  populateResults(data) {
    // populate the results

  
    if (this.haveResults()) {
      this.resultsTarget.classList.add('has-results');
    } else {
      this.resultsTarget.classList.remove('has-results');
    }
  }
}

