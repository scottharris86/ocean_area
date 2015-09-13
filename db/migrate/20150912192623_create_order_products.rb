class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.references :order
      t.references :product
      t.integer :quantity
    end
  end
end
