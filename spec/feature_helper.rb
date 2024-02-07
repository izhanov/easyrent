require "rails_helper"
require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 800],
    timeout: 60,
    headless: !ENV["SHOW_BROWSER"],
    js_errors: true,
    inspector: true,
    browser_options: {},
    process_timeout: 60,
    url_blacklist: [
      %r{https://fonts.googleapis.com},
      %r{https://fonts.gstatic.com},
      %r{https://cdnjs.cloudflare.com}
    ]
  )
end

Capybara.javascript_driver = :cuprite

Capybara.configure do |config|
  config.enable_aria_label = true
end

RSpec::Matchers.define_negated_matcher :not_change, :change
