import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    "carId",
    "clientId",
    "startsAt",
    "endsAt",
    "pickupLocation",
    "dropOffLocation",
    "errorMessage"
  ]

  connect() {
    this.addChangeListener(this.carIdTarget)
    this.addChangeListener(this.clientIdTarget)
    this.addChangeListener(this.startsAtTarget)
    this.addChangeListener(this.endsAtTarget)
    this.addChangeListener(this.pickupLocationTarget)
    this.addChangeListener(this.dropOffLocationTarget)


  }

  show({detail: errors}) {
    for (const [key, value] of Object.entries(errors)) {
      const input = document.querySelector(`input[data-bookings--error-handler-target="${key}"]`)
      const errorMessage = document.querySelector(`div[data-bookings--error-handler-target="${key}"]`)

      if (input) {
        let errorSpan = document.createElement('span')
        errorSpan.classList.add('small')
        errorSpan.classList.add('text-danger')
        errorSpan.classList.add('error-field')
        errorSpan.innerHTML = value
        errorSpan.setAttribute('style', 'position: absolute;')
        input.classList.add('is-invalid')
        input.parentElement.appendChild(errorSpan)
      }

      if (errorMessage) {
        errorMessage.innerHTML = value
        errorMessage.parentElement.classList.remove('d-none')
        errorMessage.parentElement.classList.add('show')
      }
    }
  }

  addChangeListener(target) {
    target.addEventListener('keyup', (e) => {
      const parentNode = target.parentElement
      const errorField = parentNode.querySelector('.error-field')
      if (errorField) {
        target.classList.remove('is-invalid')
        errorField.remove()
      }
    });
  }

  closeErrorMessage(event) {
    event.preventDefault()
    event.target.parentElement.classList.remove('show')
    event.target.parentElement.classList.add('d-none')
    event.target.previousElementSibling.innerHTML = ''
  }
}
