class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :tshirts, :through => :cart_items

  def add(tshirt_id)
    items = cart_items.where(tshirt_id: tshirt_id)
    tshirt = Tshirt.find tshirt_id
    if items.size < 1
      ci = cart_items.create :tshirt_id => tshirt_id, :amount => 1, :price => tshirt.price
    else
      ci = items.first
      ci.update_attribute :amount, ci.amount + 1
    end
    ci
  end

  def remove(tshirt_id)
    ci = cart_items.where(tshirt_id: tshirt_id).first
    if ci.amount > 1
      ci.update_attribute :amount, ci.amount - 1
    else
      CartItem.destroy ci.id
    end
    ci
  end

  def total
    sum = 0
    cart_items.each do |item| sum += item.price * item.amount end
    sum
  end
end