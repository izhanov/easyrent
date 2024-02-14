import { Controller } from '@hotwired/stimulus';
import camelcaseKeys from 'camelcase-keys';

export default class extends Controller {
  static targets = [
    "carTitle",
    "carId"
  ]

  connect() {
  }

  async submit (e) {
    e.preventDefault()
    const response = await fetch('/office/bookings', {method: "POST", body: new FormData(this.element)})
    const data = await response.json()
    if (response.ok) {
      Turbo.visit(`/office/bookings/${data.booking.id}`)
    } else {
      const errors = data.errors
      this.dispatch("error", {detail: camelcaseKeys(errors)})
    }
  }
}
