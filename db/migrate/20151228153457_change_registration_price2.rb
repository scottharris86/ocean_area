class ChangeRegistrationPrice2 < ActiveRecord::Migration
  def change
    @product = Product.find_by(name: 'registration')
    if @product
      @product.price = 15
      @product.save
    end
  end
end
