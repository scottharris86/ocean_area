class AddFieldsToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.integer :total
      t.string :stripe_id
    end
  end
end
