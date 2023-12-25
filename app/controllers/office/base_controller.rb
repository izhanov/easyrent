# frozen_string_literal: true

module Office
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :check_user_role
    layout 'office'
  end
end
