class OrdersController < ApplicationController
  require "stripe"
  Stripe.api_key = ENV['stripe_api_key']

  include CurrentCart
  before_action :set_cart, only: [:create, :new, :show]

  def new
    @order = Order.new
    @cart
  end

  def create
    @order = Order.new do |o|
      o.first_name = order_params[:first_name]
      o.last_name = order_params[:last_name]
      o.email = order_params[:email]
      o.phone = order_params[:phone]
    end
    if (!@order.valid?)
      flash[:danger] = "All fields are required. Please check the form."
      render :new, :order_info => params[:order_info]
    else
      begin
        # Use Stripe's bindings...
        resp = Stripe::Charge.create(
          :amount => @cart.total * 100,
          :currency => "usd",
          :source => {
            :object => 'card',
            :number => params[:order_info][:credit_card],
            :exp_month => params[:order_info][:exp_month],
            :exp_year => params[:order_info][:exp_year],
            :name => params[:order_info][:first_name] + ' ' + params[:order_info][:last_name]
          },
          :description => 'Charge for ' + params[:order_info][:email] + ' convention registration fees.',
          :metadata => {
            :email => params[:order_info][:email]
          },
          :receipt_email => params[:order_info][:email]
        )
        if (resp.status == 'succeeded' && resp.paid)
          total = @cart.total
          @order.total = total
          @order.stripe_id = resp.id
          @order.save
          @cart.itemizations.each do |item|
            @order.order_products.create(product_id: item.product_id, quantity: item.quantity)
          end
        end
        session[:cart_id] = nil
        flash[:success] = "order successfully processed. You should recieve an email confirmation shortly."
        redirect_to order_path(@order)
      rescue Stripe::CardError => e
        # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err  = body[:error]

        puts "Status is: #{e.http_status}"
        puts "Type is: #{err[:type]}"
        puts "Code is: #{err[:code]}"
        # param is '' in this case
        puts "Param is: #{err[:param]}"
        puts "Message is: #{err[:message]}"
        flash[:danger] = "#{err[:message]}. Please check all fields or use a different card."
        render :new, :order_info => params[:order_info]
      rescue Stripe::InvalidRequestError => e
        # Invalid parameters were supplied to Stripe's API
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
      rescue => e
        # Something else happened, completely unrelated to Stripe
      end
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
    @cart
  end

  private
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def order_params
      params.require(:order_info).permit(:first_name, :last_name, :phone, :email, :credit_card, :exp_month, :exp_year)
    end

end
