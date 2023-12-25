# frozen_string_literal: true

module Operations
  module Admins
    module Cities
      class Destroy < Base
        def call(city)
          yield can?(current_admin, city)
        end
      end
    end
  end
end
