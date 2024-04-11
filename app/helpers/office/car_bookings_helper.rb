module Office
  module CarBookingsHelper
    def days_count(from, to)
      from = Date.parse(from) if from.is_a?(String)
      to = Date.parse(to) if to.is_a?(String)

      (to - from).to_i
    end
  end
end