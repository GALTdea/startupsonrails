import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="open-source-project"
export default class extends Controller {
  static targets = ["form", "errors", "projectsList"]

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
        this.addProjectToList(data)
        form.reset()
        this.errorsTarget.textContent = ''
      } else {
        this.errorsTarget.textContent = data.errors.join(', ')
      }
    } catch (error) {
      console.error('Error:', error)
      this.errorsTarget.textContent = 'An unexpected error occurred. Please try again.'
    }
  }

  addProjectToList(project) {
    const projectHtml = `
      <div class="col-md-6 mb-4">
        <div class="card h-100">
          <div class="card-body">
            <div class="d-flex align-items-center mb-3">
              <img src="${project.icon_url || 'default_project_icon.png'}" alt="${project.name} Logo" class="me-3 rounded" style="width: 50px; height: 50px;">
              <h5 class="card-title mb-0">${project.name}</h5>
            </div>
            <p class="card-text">${project.description}</p>
            <div class="mt-3">
              <span class="badge bg-${project.project_type === 'contribution' ? 'success' : 'warning text-dark'} me-2">
                ${project.project_type === 'contribution' ? 'Active Contributor' : 'Sponsor'}
              </span>
              <span class="badge bg-info me-2">${project.stars} Stars</span>
              <span class="badge bg-secondary">${project.forks} Forks</span>
            </div>
          </div>
          <div class="card-footer bg-transparent">
            <a href="${project.url}" class="btn btn-outline-primary btn-sm" target="_blank">View Project</a>
          </div>
        </div>
      </div>
    `
    this.projectsListTarget.insertAdjacentHTML('afterbegin', projectHtml)
  }

  removeProject(event) {
    event.preventDefault()
    const projectElement = event.target.closest('.col-md-6')
    const projectId = this.projectIdParamValue
    const companyId = this.companyIdParamValue

    if (confirm('Are you sure you want to remove this project?')) {
      fetch(event.target.form.action, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Accept': 'application/json'
        }
      })
        .then(response => {
          if (response.ok) {
            projectElement.remove()
          } else {
            console.error('Failed to remove project')
          }
        })
        .catch(error => console.error('Error:', error))
    }
  }

  // toggleForm(event) {
  //   event.preventDefault()
  //   this.formTarget.classList.toggle("d-none")
  // }
}
