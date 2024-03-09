import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  wasAtTop = false

  static targets = ['hideAtTop']

  connect() {
    this.wasAtTop = this.#atTop()
  }

  afterScrollDisplay() {
    if(this.hideAtTopTargets.length > 0) {
      this.#handleHideAtTop()
    }
  }

  #handleHideAtTop() {
    const atTop = this.#atTop()

    // Try not to toggle unnecessarily, once we leave the top, we are done until
    // we come back for example. Generally we want to do things when we are "not
    // where we were".
    if(this.wasAtTop == atTop) {
      return
    }

    if(atTop) {
      this.hideAtTopTargets.forEach(target => { target.classList.add('hidden') })
      this.wasAtTop = true
    } else {
      this.hideAtTopTargets.forEach(target => { target.classList.remove('hidden') })
      this.wasAtTop = false
    }
  }

  #atTop() {
    const container = document.documentElement || document.body
    const minDistanceFromTop = 100
    return container.scrollTop <= minDistanceFromTop
  }
}
