class ChangeRegistrationPriceForAfterNewYears < ActiveRecord::Migration
  def change
    @product = Product.find_by(name: 'registration')
    if @product
      @product.price = 25
      @product.save
    end
  end
end
