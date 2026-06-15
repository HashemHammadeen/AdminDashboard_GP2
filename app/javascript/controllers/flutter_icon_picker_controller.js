import { Controller } from "@hotwired/stimulus"
import { allIconNames, searchIcons } from "flutter_icons"

// Popular/commonly-used stamp icons shown when the input is focused with no search term
const POPULAR_ICONS = [
  "star", "favorite", "loyalty", "local_cafe", "coffee", "restaurant",
  "storefront", "shopping_bag", "redeem", "card_giftcard", "celebration",
  "emoji_events", "workspace_premium", "diamond", "military_tech",
  "local_offer", "sell", "paid", "savings", "wallet",
  "cake", "icecream", "lunch_dining", "fastfood", "local_pizza",
  "local_bar", "wine_bar", "free_breakfast", "brunch_dining", "ramen_dining",
  "spa", "fitness_center", "sports_soccer", "sports_basketball", "sports_esports",
  "pets", "park", "eco", "water_drop", "bolt",
  "auto_awesome", "flash_on", "wb_sunny", "nightlight", "light_mode",
  "music_note", "headphones", "palette", "brush", "design_services",
  "flight", "directions_car", "directions_bike", "surfing", "kayaking",
  "school", "science", "psychology", "self_improvement", "volunteer_activism",
  "thumb_up", "sentiment_satisfied", "mood", "face", "cruelty_free",
  "photo_camera", "videocam", "movie", "theaters", "sports_bar",
  "checkroom", "watch", "backpack", "luggage", "local_mall",
  "home", "villa", "apartment", "hotel", "beach_access",
  "grass", "yard", "forest", "landscape", "terrain",
  "health_and_safety", "medical_services", "healing", "monitor_heart", "vaccines",
  "verified", "shield", "security", "lock", "vpn_key"
]

export default class extends Controller {
  static targets = ["search", "hidden", "dropdown", "preview", "previewName"]

  connect() {
    this.selected = null
    this.filtered = []
    this.focusedIndex = -1
    this.allIcons = allIconNames

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

  focus() {
    const term = this.searchTarget.value.trim()
    if (!term) {
      // Show popular icons when focused with empty search
      this.filtered = POPULAR_ICONS.filter(name => this.allIcons.includes(name))
      this.renderDropdown("Popular Icons")
      this.dropdownTarget.classList.remove("hidden")
    }
  }

  search() {
    const term = this.searchTarget.value.toLowerCase().trim()
    this.focusedIndex = -1

    if (!term) {
      // Show popular icons when search is cleared
      this.filtered = POPULAR_ICONS.filter(name => this.allIcons.includes(name))
      this.renderDropdown("Popular Icons")
      this.dropdownTarget.classList.remove("hidden")
      return
    }

    // Use the new tag-based search
    this.filtered = searchIcons(term).slice(0, 200)

    if (this.filtered.length === 0) {
      this.dropdownTarget.innerHTML = `
        <div class="p-6 text-center text-gray-400">
          <span class="material-icons text-3xl mb-2 block">search_off</span>
          <p class="text-sm">No icons found for "<strong>${term}</strong>"</p>
          <p class="text-xs mt-1">Try a different keyword</p>
        </div>`
      this.dropdownTarget.classList.remove("hidden")
      return
    }

    this.renderDropdown(`${this.filtered.length} icons found`)
    this.dropdownTarget.classList.remove("hidden")
  }

  renderDropdown(headerText = "") {
    this.dropdownTarget.innerHTML = ""

    // Header with count
    if (headerText) {
      const header = document.createElement("div")
      header.className = "px-3 py-2 bg-gray-50 border-b border-gray-100 flex items-center justify-between sticky top-0 z-10"
      header.innerHTML = `
        <span class="text-xs font-semibold text-gray-500 uppercase tracking-wider">${headerText}</span>
        <span class="text-xs text-gray-400">${this.filtered.length} icons</span>`
      this.dropdownTarget.appendChild(header)
    }

    // Grid container
    const grid = document.createElement("div")
    grid.className = "flutter-icon-grid"

    this.filtered.forEach((name, index) => {
      const item = document.createElement("div")
      item.dataset.index = index
      item.dataset.action = "mousedown->flutter-icon-picker#pick"
      item.dataset.flutterIconPickerTarget = "option"
      item.role = "option"
      item.setAttribute("aria-selected", "false")
      item.className = this.optionClass(false)
      item.title = name.replace(/_/g, " ")

      const iconSpan = document.createElement("span")
      iconSpan.className = "material-icons flutter-icon-grid-icon"
      iconSpan.textContent = name

      const textSpan = document.createElement("span")
      textSpan.className = "flutter-icon-grid-label"
      textSpan.textContent = name.replace(/_/g, " ")

      item.appendChild(iconSpan)
      item.appendChild(textSpan)

      grid.appendChild(item)
    })

    this.dropdownTarget.appendChild(grid)
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
    const base = "flutter-icon-grid-item"
    return focused ? `${base} flutter-icon-grid-item--focused` : base
  }
}
