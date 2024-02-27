json.booking do
  json.total_price(
    Utils::Bookings::Calculator.new(@booking).run.to_fs(:currency, locale: :kk)
  )
end
