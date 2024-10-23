import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="issue"
export default class extends Controller {
  static targets = ["githubIssueSelect", "titleInput", "githubUrlInput"]
  static values = { companyId: String }

  connect() {
    console.log("Issue controller connected")
  }

  fetchGithubIssues(event) {
    const projectId = event.target.value
    if (!projectId) return

    fetch(`/companies/${this.companyIdValue}/issues/fetch_github_issues?open_source_project_id=${projectId}`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        console.log("Received GitHub issues:", data)
        this.githubIssueSelectTarget.innerHTML = '<option value="">Select an issue</option>'
        data.forEach(issue => {
          const option = document.createElement('option')
          option.value = JSON.stringify(issue)
          option.textContent = issue.title
          this.githubIssueSelectTarget.appendChild(option)
        })
      })
      .catch(error => {
        console.error('Error:', error)
        this.githubIssueSelectTarget.innerHTML = '<option value="">Error fetching issues</option>'
      })
  }

  selectGithubIssue(event) {
    const issueData = JSON.parse(event.target.value)
    if (this.titleInputTarget.value === "") {
      this.titleInputTarget.value = issueData.title
    }
    if (this.githubUrlInputTarget.value === "") {
      this.githubUrlInputTarget.value = issueData.html_url
    }
  }
}
