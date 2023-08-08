import { Controller } from "@hotwired/stimulus";
import { Sortable } from "sortablejs";
import { patch } from "@rails/request.js";

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: ".sort-handle",
      animation: 150,
      onEnd: this.end.bind(this),
    });
  }

  end(event) {
    let id = event.item.dataset.id;
    const url = this.data.get("url").replace(":id", id);

    patch(url, { body: JSON.stringify({ position: event.newIndex + 1 }) });
  }
}
