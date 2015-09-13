class Order < ActiveRecord::Base
  has_many :order_products
  has_many :products, :through => :order_products

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :email, length: { minimum: 5 }
  validates :phone, length: { minimum: 10 }
end
