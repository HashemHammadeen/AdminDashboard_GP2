import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["container"]

    dismiss() {
        this.containerTarget.classList.add("opacity-0", "transition-opacity", "duration-300")
        setTimeout(() => this.containerTarget.remove(), 300)
    }
}
