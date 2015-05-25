class CartItem < ActiveRecord::Base
  # attr_accessible :tshirt_id, :cart_id, :price, :amount

  belongs_to :cart
  belongs_to :tshirt
end
