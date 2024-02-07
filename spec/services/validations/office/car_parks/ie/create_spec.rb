# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::CarParks::Ie::Create do
  it "inherits from CarParkBase contract" do
    expect(described_class.superclass).to eq(Validations::Office::CarParks::CarParkBase)
  end

  it "requires contact phone in correct format but service phone" do
    expect(subject.call(contact_phone: "123").errors.to_h).to(
      include(contact_phone: ["must be in correct format"])
    )
    expect(subject.call(service_phone: "+7700)789-23-87").errors.to_h).not_to(
      include(service_phone: ["must be in correct format"])
    )
  end

  it "requires card id number max size to be 9" do
    expect(subject.call(card_id_number: "1234567890").errors.to_h).to(
      include(card_id_number: ["size cannot be greater than 9 symbols"])
    )
  end
end
