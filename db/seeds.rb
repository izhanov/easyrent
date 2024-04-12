# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(
  email: "admin@example.com",
  password: "123456",
  phone: "+77771234567",
  first_name: "Admin",
  last_name: "Admin"
)

user_id = User.first.id

toyota = Brand.create!(title: "Toyota", synonyms: ["Toyota"])
mercedes = Brand.create!(title: "Mercedes", synonyms: ["Mercedes"])

Mark.create!(brand_id: toyota.id, title: "Corolla", body: "Description for Toyota Corolla", synonyms: ["Corolla"])
Mark.create!(brand_id: mercedes.id, title: "E-Class", body: "Description for Mercedes E-Class", synonyms: ["E-Class"])

City.create!(title: "Almaty", slug: "ala")
City.create!(title: "Astana", slug: "nqz")

car_park = CarPark.create!(
  city_id: City.first.id,
  user_id: user_id,
  title: "Car Park 1",
  kind: "Public",
  business_id_number: "123456789",
  contact_phone: "123-456-789",
  bank_name: "Bank 1",
  bank_account_number: "12345678901234567890",
  email: "carpark1@example.com",
  card_id_number: "123456789",
  privateer_number: "123456789",
  privateer_date: Date.today,
  residence_address: "Address 1",
  bank_code: "123",
  benificiary_code: "456",
  legal_address: "Legal Address 1",
  service_phone: "987-654-321",
  booking_prefix: "UNDF"
)

mileage_limit = RentalRule::MileageLimit.create!(
  title: "Basic",
  value: 100,
  owner: car_park
)

price_range = PriceRange.create(
  unit: "day",
  owner: car_park
)

[[1,3], [4,10], [11,20], [21,30]].each do |(from, to)|
  PriceRangeCell.create(
    from: from,
    to: to,
    price_range: price_range
  )
end

Car.skip_callback(:commit, :after, :update_typesense_index)

10.times do
  Car.create!(
    mark_id: rand(1..2),
    owner_type: "CarPark",
    owner_id: CarPark.first.id,
    year: rand(1990..2022),
    vin_code: SecureRandom.hex(10).upcase,
    plate_number: "#{('A'..'Z').to_a.sample(3).join}-#{rand(1000..9999)}",
    klass: ['sedan', 'hatchback', 'SUV'].sample,
    technical_certificate_number: SecureRandom.hex(8).upcase,
    mileage: rand(0..100_000),
    fuel: ['gasoline', 'diesel', 'electric'].sample,
    color: ['black', 'white', 'silver', 'red', 'blue'].sample,
    transmission: Car::TRANSMISSION_TYPES.sample,
    number_of_seats: rand(2..6),
    tank_volume: rand(40..80),
    engine_capacity: rand(1.0..5.0).round(2),
    engine_capacity_unit: 'liters',
    technical_condition: Car::TECHNICAL_CONDITION_TYPES.sample,
    appearance: Car::APPEARANCE_TYPES.sample,
    over_mileage_price: rand(1000..5000).round(-2)
  )
end

["smart", "lite", "nomad"].each do |plan|
  Car.all.each do |car|
    offer = Offer.create!(
      title: plan,
      car_id: car.id,
      published: true,
      mileage_limit_id: mileage_limit.id,
      prices: {
        "1..3" => 10_000,
        "4..10" => 10_000,
        "11..20" => 10_000,
        "21..30" => 9_000,
      }
    )
  end
end
