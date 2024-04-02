# frozen_string_literal: true

module OfficeJobs
  module Documents
    class CreateContractJob < ApplicationJob
      queue_as :default

      def perform(contract, responsible)
        Operations::Office::Documents::ContractContext::Create.new.call(contract, responsible)
      end
    end
  end
end
