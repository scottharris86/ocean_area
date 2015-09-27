class ScheduleController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index]
  def index
    @cart
  end
end
