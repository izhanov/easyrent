# frozen_string_literal: true

module Office
  class BaseController < ApplicationController
    before_action :authenticate_office_user!
    layout "office"
  end
end
