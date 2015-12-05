class ChangeRegistrationPrice < ActiveRecord::Migration
  def change
    @product = Product.find_by(name: 'registration')
    if @product
      @product.price = 20
      @product.save
    end
  end
end
