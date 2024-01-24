// Disable Turbo Drive for the office namespace
// I guess temporarily until we get it working
import "@hotwired/turbo-rails"
Turbo.setFormMode("optin");

// Import Bootstrap CSS
import 'bootstrap';
import './../src/office/scss/main.scss';

import './../src/office/js/imask.js';
import './../src/office/js/toastify.js';
import './../src/office/js/transliterate.js';

import './../src/office/js/controllers';
