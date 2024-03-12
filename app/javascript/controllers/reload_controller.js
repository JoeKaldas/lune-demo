// Reload the page
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    location.reload();
    this.element.remove();
  }
}