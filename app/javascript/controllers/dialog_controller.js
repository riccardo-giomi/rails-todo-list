import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "dialog" ]

  open(event) {
    event.preventDefault()
    this.dialogTarget.showModal()
  }

  close() {
    this.dialogTarget.close()
  }

  doNothing(e) {}

  submitForm({ params: { formId } }) {
    const form = document.getElementById(formId)

    form?.submit()
    this.dialogTarget.close()
  }
}
