import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = {
    urls: String
  }

  connect() {
    const autocomplete = document.querySelector('div[data-controller="autocomplete"]');
    const urls = JSON.parse(this.urlsValue);
    const selectedCarPark = document.querySelector('select[id="car_park_id"]').value;

    autocomplete.setAttribute('data-autocomplete-url-value', urls[selectedCarPark]);
  }

  changeUrl(event) {
    const autocomplete = document.querySelector('div[data-controller="autocomplete"]');
    const urls = JSON.parse(this.urlsValue);

    autocomplete.querySelector('input[id="car"]').value = ''
    autocomplete.setAttribute('data-autocomplete-url-value', urls[event.target.value]);
  }

  changeServices(event) {
    const carParkID = event.target.value;
    Turbo.visit(`/office/car_parks/${carParkID}/additional_services/booking_checkboxes`, {frame: "additional_services_checkboxes"})

    const servicesCheckboxesFrame = document.querySelector('turbo-frame[id="additional_services_checkboxes"]');

    servicesCheckboxesFrame.addEventListener("turbo:frame-load", (event) => {
      document.dispatchEvent(new CustomEvent('calculator:services-changed'))
    });
  }

  resetTotalPrice() {
    document.dispatchEvent(new CustomEvent('calculator:reset-total-price'));
  }
}
