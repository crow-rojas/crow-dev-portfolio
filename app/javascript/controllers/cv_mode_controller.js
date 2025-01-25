import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static classes = ["active"]

  toggle() {
    document.body.classList.toggle("cv-mode")
    this.element.classList.toggle(this.activeClass)

    // Print automatically when entering CV mode
    if (document.body.classList.contains("cv-mode")) {
      // Optional: Automatically open print dialog
      // window.print()
    }
  }
} 