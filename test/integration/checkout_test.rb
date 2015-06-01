require File.dirname(__FILE__) + '/../test_helper'

class CheckoutTest < ActionDispatch::IntegrationTest
  fixtures :manufacturers, :tshirts

  test "empty_cart_shows_error_message" do
    get '/checkout'
    assert_response :redirect
    assert_redirected_to :controller => 'catalog'
    assert_equal flash[:notice], 'Your shopping cart is empty! ' +
                                 'Please add at least one t-shirt to it before proceeding to check out.'
  end

  test "submitting_order" do
    post '/cart/add', :id => 1
    get '/checkout'
    assert_response :success
    assert_tag :tag => 'legend', :content => 'Contact Information'
    assert_tag :tag => 'legend', :content => 'Shipping Address'
    assert_tag :tag => 'legend', :content => 'Billing Information'

    post '/checkout/submit_order', :cart => { :id => Cart.last.id }, :order => {
      :email => 'kevin@email.com',
      :phone_number => '123456789',
      :ship_to_first_name => 'Troli',
      :ship_to_last_name => 'Perez',
      :ship_to_address => 'Calle del Campo',
      :ship_to_city => 'Paterna',
      :ship_to_postal_code => '123456',
      :ship_to_country_code => 'Spain',
	  :card_type => 'Visa',
      :card_number => '4007000000027',
      :card_expiration_month => '3',
      :card_expiration_year => '2018',
      :card_verification_value => '000'
    }

    assert_response :redirect
    assert_redirected_to '/checkout/thank_you'
  end
end
