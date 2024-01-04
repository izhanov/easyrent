require "rails_helper"
require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    timeout: 10,
    headless: true,
    js_errors: true,
    browser_options: {
      process_timeout: 20
    },
    url_blacklist: [
      "https://fonts.googleapis.com",
      "https://fonts.gstatic.com",
      "https://cdnjs.cloudflare.com"
    ]
  )
end

Capybara.javascript_driver = :cuprite

Capybara.configure do |config|
  config.enable_aria_label = true
end

RSpec::Matchers.define_negated_matcher :not_change, :change
