# frozen_string_literal: true

require "rails_helper"

RSpec.describe Validations::Office::CarParks::Llp::Create do
  it "inherits from CarParkBase contract" do
    expect(described_class.superclass).to eq(Validations::Office::CarParks::CarParkBase)
  end

  it "requires service phone, contact phone in correct format" do
    expect(subject.call(service_phone: "123").errors.to_h).to(
      include(service_phone: ["must be in correct format"])
    )
    expect(subject.call(contact_phone: "+7700)789-23-87").errors.to_h).to(
      include(contact_phone: ["must be in correct format"])
    )
  end
end
