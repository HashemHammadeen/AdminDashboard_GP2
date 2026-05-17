import { Controller } from "@hotwired/stimulus"
import allIcons from "flutter_icons"

export default class extends Controller {
  static targets = ["search", "hidden", "dropdown", "preview", "previewName"]

  connect() {
    this.selected = null
    this.filtered = []
    this.focusedIndex = -1
    this.allIcons = allIcons

    if (this.hasHiddenTarget && this.hiddenTarget.value) {
      this.selected = this.hiddenTarget.value
      this.updatePreview()
      if (this.hasSearchTarget) {
        this.searchTarget.value = this.selected.replace(/_/g, " ")
      }
    }

    this._onDocumentClick = this._handleDocumentClick.bind(this)
    document.addEventListener("click", this._onDocumentClick)
  }

  disconnect() {
    document.removeEventListener("click", this._onDocumentClick)
  }

  _handleDocumentClick(event) {
    if (!this.element.contains(event.target)) {
      this.dropdownTarget.classList.add("hidden")
    }
  }

  search() {
    const term = this.searchTarget.value.toLowerCase().trim()
    this.focusedIndex = -1

    if (!term) {
      this.filtered = []
      this.dropdownTarget.classList.add("hidden")
      return
    }

    this.filtered = this.allIcons.filter(name =>
      name.includes(term)
    ).slice(0, 150)

    if (this.filtered.length === 0) {
      this.dropdownTarget.classList.add("hidden")
      return
    }

    this.renderDropdown()
    this.dropdownTarget.classList.remove("hidden")
  }

  renderDropdown() {
    this.dropdownTarget.innerHTML = ""
    this.filtered.forEach((name, index) => {
      const item = document.createElement("div")
      item.dataset.index = index
      item.dataset.action = "mousedown->flutter-icon-picker#pick"
      item.dataset.flutterIconPickerTarget = "option"
      item.role = "option"
      item.setAttribute("aria-selected", "false")
      item.className = this.optionClass(false)

      const iconSpan = document.createElement("span")
      iconSpan.className = "material-icons text-lg leading-none"
      iconSpan.textContent = name

      const textSpan = document.createElement("span")
      textSpan.className = "text-sm text-gray-700"
      textSpan.textContent = name.replace(/_/g, " ")

      item.appendChild(iconSpan)
      item.appendChild(textSpan)

      this.dropdownTarget.appendChild(item)
    })
  }

  pick(event) {
    event.preventDefault()
    const index = parseInt(event.currentTarget.dataset.index)
    const name = this.filtered[index]
    this.chooseIcon(name)
  }

  chooseIcon(name) {
    this.selected = name
    this.hiddenTarget.value = name
    this.searchTarget.value = name.replace(/_/g, " ")
    this.dropdownTarget.classList.add("hidden")
    this.updatePreview()
  }

  updatePreview() {
    if (!this.hasPreviewTarget && !this.hasPreviewNameTarget) return

    if (this.selected) {
      if (this.hasPreviewTarget) {
        this.previewTarget.classList.remove("hidden")
        const iconEl = this.previewTarget.querySelector(".material-icons")
        if (iconEl) iconEl.textContent = this.selected
      }
      if (this.hasPreviewNameTarget) {
        this.previewNameTarget.textContent = this.selected
      }
    } else {
      if (this.hasPreviewTarget) {
        this.previewTarget.classList.add("hidden")
      }
      if (this.hasPreviewNameTarget) {
        this.previewNameTarget.textContent = "No icon selected"
      }
    }
  }

  keydown(event) {
    if (this.dropdownTarget.classList.contains("hidden") && event.key !== "Escape") return

    switch (event.key) {
      case "ArrowDown":
        event.preventDefault()
        this.focusedIndex = Math.min(this.focusedIndex + 1, this.filtered.length - 1)
        this.updateFocus()
        break
      case "ArrowUp":
        event.preventDefault()
        this.focusedIndex = Math.max(this.focusedIndex - 1, 0)
        this.updateFocus()
        break
      case "Enter":
        event.preventDefault()
        if (this.focusedIndex >= 0 && this.focusedIndex < this.filtered.length) {
          this.chooseIcon(this.filtered[this.focusedIndex])
        }
        break
      case "Escape":
        this.dropdownTarget.classList.add("hidden")
        break
    }
  }

  updateFocus() {
    const items = this.dropdownTarget.querySelectorAll("[data-flutter-icon-picker-target=\"option\"]")
    items.forEach((item, i) => {
      item.className = i === this.focusedIndex ? this.optionClass(true) : this.optionClass(false)
      item.setAttribute("aria-selected", i === this.focusedIndex ? "true" : "false")
    })
    if (this.focusedIndex >= 0) {
      items[this.focusedIndex]?.scrollIntoView({ block: "nearest" })
    }
  }

  optionClass(focused) {
    const base = "flex items-center gap-3 px-3 py-2 cursor-pointer border-b border-gray-50 last:border-b-0"
    return focused ? `${base} bg-secondary/10` : `${base} hover:bg-gray-50`
  }
}
