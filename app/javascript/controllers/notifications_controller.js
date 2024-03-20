import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "notifications" ]

  open(event) {
    event.preventDefault()
  }

  close() {
    this.notificationsTarget.remove()
  }
}
