import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "section"]

  resetForm() {
    // Scroll to the contact section
    this.sectionTarget.scrollIntoView({ behavior: "smooth" })

    // Reset the form if needed
    this.formTarget.reset()
  }
} 