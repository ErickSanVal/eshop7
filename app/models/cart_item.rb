class CartItem < ActiveRecord::Base
  # attr_accessible :book_id, :cart_id, :price, :amount

  belongs_to :cart
  belongs_to :tshirt
end
