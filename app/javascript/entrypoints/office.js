// Disable Turbo Drive for the office namespace
// I guess temporarily until we get it working
import "@hotwired/turbo-rails"
Turbo.setFormMode("optin");

// Import Rails UJS for enable Turbolinks helpers
import Rails from "@rails/ujs"

// Import Bootstrap CSS
import 'bootstrap';
import './../src/office/scss/main.scss';

import './../src/office/js/imask.js';
import './../src/office/js/toastify.js';

import './../src/office/js/controllers';
Rails.start();


document.addEventListener("autocomplete.change", function (event) {
  console.log(event);
});
