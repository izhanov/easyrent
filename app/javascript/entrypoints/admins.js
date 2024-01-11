// Disable Turbo Drive for the admin namespace
// I guess temporarily until we get it working
import "@hotwired/turbo-rails"
Turbo.setFormMode("off");

// Import Rails UJS for enable Turbolinks helpers
import Rails from "@rails/ujs"

// Import Bootstrap CSS
import 'bootstrap';
import './../src/admins/scss/main.scss';

import '../src/admins/js/imask';
import './../src/admins/js/controllers';

Rails.start();
