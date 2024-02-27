// Disable Turbo Drive for the office namespace
// I guess temporarily until we get it working
import "@hotwired/turbo-rails"
Turbo.setFormMode("optin");

// Import Bootstrap CSS
import * as bootstrap from 'bootstrap';
import './../src/office/scss/main.scss';

import './../src/office/js/imask.js';
import './../src/office/js/toastify.js';
import './../src/office/js/transliterate.js';

import './../src/office/js/controllers';

// Bookings namespace
import './../src/office/js/bookings/new/insert_client.js';
import './../src/office/js/bookings/new/insert_offer.js';
import './../src/office/js/bookings/new/additional_services.js';
import './../src/office/js/bookings/new/insert_car_park_id.js';
import './../src/office/js/bookings/new/calculator.js';

// Set time zone to cookies

document.addEventListener('turbo:load', () => {
  const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
  document.cookie = `timezone=${timezone};`;
});

const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')

popoverTriggerList.forEach(function (popoverTriggerEl) {

  new bootstrap.Popover(popoverTriggerEl)
})
