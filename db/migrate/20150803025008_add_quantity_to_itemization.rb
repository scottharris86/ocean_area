class AddQuantityToItemization < ActiveRecord::Migration
  def change
    add_column :itemizations, :quantity, :integer
  end
end
