class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :update, :destroy, :index]

  def index
    @products = Product.all
    @cart
  end

end
