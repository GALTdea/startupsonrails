import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "pane"]

  connect() {
    console.log("Tabs controller connected")
  }

  switchToHelpWanted(event) {
    event.preventDefault()

    // Find the Help Wanted tab and its content
    const helpWantedTab = document.querySelector('#help-wanted-tab')
    const helpWantedContent = document.querySelector('#help-wanted')

    if (helpWantedTab && helpWantedContent) {
      // Remove active class from all tabs and contents
      document.querySelectorAll('.nav-link').forEach(tab => tab.classList.remove('active'))
      document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('show', 'active'))

      // Activate the Help Wanted tab and content
      helpWantedTab.classList.add('active')
      helpWantedContent.classList.add('show', 'active')

      // Scroll to the Help Wanted content
      helpWantedContent.scrollIntoView({ behavior: 'smooth' })

      // Update the URL hash
      history.pushState(null, '', '#help-wanted')
    }
  }
}
