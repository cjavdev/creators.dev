import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-form"
export default class extends Controller {
  static targets = ['template', 'prices']
  connect() {
  }

  addPrice() {
    const template = this.templateTarget.innerHTML
    this.pricesTarget.insertAdjacentHTML(
      'beforeend',
      template
    )
  }
}
