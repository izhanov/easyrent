# frozen_string_literal: true

module Office
  class ConsumablesLogsController < BaseController
    before_action :find_consumable

    def index
      @consumable_logs = @consumable.consumable_logs
    end

    def new
      @consumable_log = @consumable.consumable_logs.new
    end

    def create
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def find_consumable

    end
  end
end
