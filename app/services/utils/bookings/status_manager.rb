# frozen_string_literal: true

module Utils
  module Bookings
    class StatusManager
      AVAILABLE_STATUSES_TRANSITIONS = {
        initial: [
          [I18n.t("activerecord.attributes.booking.statuses.initial"), "initial"],
          [I18n.t("activerecord.attributes.booking.statuses.confirmed"), "confirmed"],
          [I18n.t("activerecord.attributes.booking.statuses.cancelled"), "cancelled"]
        ],
        confirmed: [
          [I18n.t("activerecord.attributes.booking.statuses.confirmed"), "confirmed"],
          [I18n.t("activerecord.attributes.booking.statuses.give_out_the_car"), "give_out_the_car"],
          [I18n.t("activerecord.attributes.booking.statuses.cancelled"), "cancelled"]
        ],
        give_out_the_car: [
          [I18n.t("activerecord.attributes.booking.statuses.give_out_the_car"), "give_out_the_car"],
          [I18n.t("activerecord.attributes.booking.statuses.start_the_rent"), "start_the_rent"]
        ],
        start_the_rent: [
          [I18n.t("activerecord.attributes.booking.statuses.start_the_rent"), "start_the_rent"],
          [I18n.t("activerecord.attributes.booking.statuses.end_the_rent"), "end_the_rent"]
        ],
        end_the_rent: [
          [I18n.t("activerecord.attributes.booking.statuses.end_the_rent"), "end_the_rent"],
          [I18n.t("activerecord.attributes.booking.statuses.accept_the_car"), "accept_the_car"]
        ],
        accept_the_car: [
          [I18n.t("activerecord.attributes.booking.statuses.accept_the_car"), "accept_the_car"],
          [I18n.t("activerecord.attributes.booking.statuses.return_the_deposit"), "return_the_deposit"],
          [I18n.t("activerecord.attributes.booking.statuses.completed"), "completed"]
        ],
        return_the_deposit: [
          [I18n.t("activerecord.attributes.booking.statuses.return_the_deposit"), "return_the_deposit"],
          [I18n.t("activerecord.attributes.booking.statuses.completed"), "completed"]
        ],
        cancelled: [
          [I18n.t("activerecord.attributes.booking.statuses.cancelled"), "cancelled"]
        ],
        completed: [
          [I18n.t("activerecord.attributes.booking.statuses.completed"), "completed"]
        ]
      }

      def available_statuses_from(status)
        AVAILABLE_STATUSES_TRANSITIONS[status.to_sym]
      end
    end
  end
end
