# frozen_string_literal: true

module Admins
  class BaseController < ApplicationController
    layout "admins"

    before_action :authenticate_admin!
  end
end
