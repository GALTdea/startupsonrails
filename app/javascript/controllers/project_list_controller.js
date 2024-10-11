import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="project-list"
export default class extends Controller {
  static targets = ["list"]

  connect() {
    console.log("Project List controller connected")
  }

  addProject(event) {
    const project = event.detail
    const projectHtml = this.generateProjectHtml(project)
    this.listTarget.insertAdjacentHTML('afterbegin', projectHtml)
  }

  removeProject(event) {
    event.preventDefault()
    const projectElement = event.target.closest('.row')
    const projectId = event.params.projectId
    const companyId = event.params.companyId

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

  generateProjectHtml(project) {
    return `
      <div class="col-12 col-md-6 col-lg-4 mb-4">
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
            <div class="d-flex justify-content-between align-items-center">
              <a href="${project.url}" class="btn btn-outline-primary btn-sm" target="_blank">View Project</a>
            </div>
          </div>
        </div>
      </div>
    `
  }
}
