require File.dirname(__FILE__) + '/../test_helper'

class OrderTest < ActiveSupport::TestCase
  test "create_valid_order" do
    order = Order.new(
      :email => 'kevin@email.com',
      :phone_number => '123456789',
      :ship_to_first_name => 'Troli',
      :ship_to_last_name => 'Perez',
      :ship_to_address => 'Calle de Miguel',
      :ship_to_city => 'Paterna',
      :ship_to_postal_code => '123456',
      :ship_to_country_code => 'ES',
      :card_type => 'Visa',
      :card_number => '4007000000027',
      :card_expiration_month => '3',
      :card_expiration_year => '2018',
      :card_verification_value => '000'
    )

    order.customer_ip = '127.0.0.1'
    order.status = 'open'

    order.order_items << OrderItem.new(:tshirt_id => 1, :price => 155.25, :amount => 3)

    assert order.save
    assert order.process
    order.reload
    assert_equal 1, order.order_items.size
    assert_equal 155.25, order.order_items[0].price
    assert_equal order.status, 'processed'
    order.close
    assert order.closed?
  end

  test "validations" do
    order = Order.new
    assert_equal false, order.save
    assert_equal 16, order.errors.size

    assert order.errors[:order_items]
    assert order.errors[:email]
    assert order.errors[:phone_number]
    assert order.errors[:ship_to_first_nane]
    assert order.errors[:ship_to_last_name]
    assert order.errors[:ship_to_address]
    assert order.errors[:ship_to_city]
    assert order.errors[:ship_to_postal_code]
    assert order.errors[:ship_to_country_code]
    assert order.errors[:card_type]
    assert order.errors[:card_number]
    assert order.errors[:card_expiration_month]
    assert order.errors[:card_expiration_year]
    assert order.errors[:card_verification_value]
    assert order.errors[:customer_ip]
    assert order.errors[:status]
  end
end
