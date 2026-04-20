import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "select"]

  filter() {
    const term = this.inputTarget.value.toLowerCase()
    
    Array.from(this.selectTarget.options).forEach(option => {
      // Don't hide the prompt option if it exists and has empty value
      if (option.value === "") return
      
      const text = option.text.toLowerCase()
      if (text.includes(term)) {
        option.style.display = ""
      } else {
        option.style.display = "none"
      }
    })
  }
}
