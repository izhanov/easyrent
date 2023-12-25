# frozen_string_literal: true

module Admins
  class BaseController < ApplicationController
    include Dry::Monads[:result]
    layout "admins"

    before_action :authenticate_admin!
  end
end
