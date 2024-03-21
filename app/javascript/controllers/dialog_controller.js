import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "dialog" ]

  open(event) {
    event.preventDefault()
    this.dialogTarget.showModal()
  }

  close(event) {
    event.preventDefault()
    this.dialogTarget.close()
  }

  closeAndResetForm(event) {
    event.preventDefault()
    this.dialogTarget.getElementsByTagName('form')[0]?.reset()
    this.dialogTarget.close()
  }
}
