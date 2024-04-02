# frozen_string_literal: true

module OfficeJobs
  module Documents
    class CreateApplicationOneJob < ApplicationJob
      queue_as :default

      def perform(contract, responsible)
        Operations::Office::Documents::ApplicationOne::Create.new.call(contract, responsible)
      end
    end
  end
end
