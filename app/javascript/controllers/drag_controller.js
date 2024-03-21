import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { patch } from '@rails/request.js'

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: ".handle",
      animation: 150,
      onEnd: this.end.bind(this),
    });
  }

  end(event) {
    const id = event.item.children[0]?.dataset['id']
    const position = event.newIndex + 1
    const url = this.urlValue?.replace(':id', id)

    patch(url, { body: JSON.stringify({ position }) })
  }
}
