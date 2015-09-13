class Cart < ActiveRecord::Base
  has_many :itemizations
  has_many :products, :through => :itemizations

  def add_itemization(params)
    current_product = itemizations.find_by(product_id: params[:product_id])

    if current_product
      current_product.quantity = params[:quantity].to_i
      current_product.save
    else
      current_product = itemizations.create(product_id: params[:product_id], quantity: params[:quantity].to_i)
    end
  end

  def total
    base_price = 0
    items = itemizations.all
    items.each do |item|
      product = Product.find_by(id: item.product_id)
      base_price += product.price * item.quantity
    end
    return base_price
  end

  def update_quantity(params)
    current_product = itemizations.find_by(product_id: params[:product_id])

    if current_product
      current_product.quantity = params[:quantity].to_i
      current_product.save
    end
  end

  def remove_product(params)
    current_product = itemizations.find_by(product_id: params[:product_id])
    if current_product
      current_product.destroy
    end
  end

  def product_count
    count = 0
    items = itemizations.all
    items.each do |item|
      count += item.quantity
    end
    return count
  end
end
