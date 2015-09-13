class CartProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :update, :destroy]

  def create
    @cart.add_itemization(params)

    if @cart.save
      flash[:success] = "added item to cart!"
      redirect_to :back
    else
      flash[:error] = 'There was a problem adding this item to your shopping bag.'
      redirect :back
    end
  end

  def update
    @cart.update_quantity(params)
    if @cart.save
      flash[:success] = "Quantity Updated!"
      redirect_to cart_path(@cart)
    else
      flash[:error] = 'There was a problem updating quantity.'
      redirect :back
    end
  end

  def destroy
    @cart.remove_product(params)
    if @cart.save
      flash[:success] = "Item removed from cart!"
      redirect_to cart_path(@cart)
    else
      flash[:error] = 'There was a problem removing this item. Try refreshing the page.'
      redirect :back
    end
  end
end
