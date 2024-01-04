// Disable Turbo Drive for the office namespace
// I guess temporarily until we get it working
import "@hotwired/turbo-rails"
Turbo.session.drive = false

// Import Rails UJS for enable Turbolinks helpers
import Rails from "@rails/ujs"

// Import Bootstrap CSS
import 'bootstrap';
import './../src/office/scss/main.scss';

import './../src/office/js/imask.js';

Rails.start();
