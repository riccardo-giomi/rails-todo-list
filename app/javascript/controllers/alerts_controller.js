import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "alert" ]

  open(event) {
    event.preventDefault()
  }

  close() {
    this.alertTarget.remove()
  }
}
