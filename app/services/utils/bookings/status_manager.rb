# frozen_string_literal: true

module Utils
  module Bookings
    class StatusManager
      AVAILABLE_STATUSES_TRANSITIONS = {
        new: [
          [I18n.t("activerecord.attributes.booking.statuses.new"), "new"],
          [I18n.t("activerecord.attributes.booking.statuses.confirmed"), "confirmed"],
          [I18n.t("activerecord.attributes.booking.statuses.canceled"), "canceled"]
        ],
        confirmed: [
          [I18n.t("activerecord.attributes.booking.statuses.confirmed"), "confirmed"],
          [I18n.t("activerecord.attributes.booking.statuses.payment_accepted"), "payment_accepted"],
          [I18n.t("activerecord.attributes.booking.statuses.canceled"), "canceled"]
        ],
        payment_accepted: [
          [I18n.t("activerecord.attributes.booking.statuses.payment_accepted"), "payment_accepted"],
          [I18n.t("activerecord.attributes.booking.statuses.give_out_the_car"), "give_out_the_car"]
        ],
        give_out_the_car: [
          [I18n.t("activerecord.attributes.booking.statuses.give_out_the_car"), "give_out_the_car"],
          [I18n.t("activerecord.attributes.booking.statuses.car_in_rent"), "car_in_rent"]
        ],
        car_in_rent: [
          [I18n.t("activerecord.attributes.booking.statuses.car_in_rent"), "car_in_rent"],
          [I18n.t("activerecord.attributes.booking.statuses.accept_the_car"), "accept_the_car"]
        ],
        accept_the_car: [
          [I18n.t("activerecord.attributes.booking.statuses.accept_the_car"), "accept_the_car"],
          [I18n.t("activerecord.attributes.booking.statuses.return_the_deposit"), "return_the_deposit"],
          [I18n.t("activerecord.attributes.booking.statuses.finished"), "finished"]
        ],
        return_the_deposit: [
          [I18n.t("activerecord.attributes.booking.statuses.return_the_deposit"), "return_the_deposit"],
          [I18n.t("activerecord.attributes.booking.statuses.finished"), "finished"]
        ],
        canceled: [
          [I18n.t("activerecord.attributes.booking.statuses.canceled"), "canceled"]
        ],
        finished: [
          [I18n.t("activerecord.attributes.booking.statuses.finished"), "finished"]
        ]
      }

      def available_statuses_from(status)
        AVAILABLE_STATUSES_TRANSITIONS[status.to_sym]
      end
    end
  end
end
