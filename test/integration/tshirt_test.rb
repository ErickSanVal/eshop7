require File.dirname(__FILE__) + '/../test_helper'

class TshirtIntegrationTest < ActionDispatch::IntegrationTest

  test "tshirt_administration" do
  	manufacturer = Manufacturer.create(:name => 'Prueba', :telephone => '123456789')
  	kevin = new_session_as(:kevin)

  	new_tshirt_ruby = kevin.add_tshirt :tshirt => {
  		:price => 30.5,
  		:size => 'M',
  		:country => 'Spain',
  		:club => 'Real Madrid',
  		:manufacturer_id => manufacturer.id
  	}

  	kevin.list_tshirts
  	kevin.show_tshirt new_tshirt_ruby

  	kevin.edit_tshirt new_tshirt_ruby, :tshirt => {
  		:price => 10.5,
  		:size => 'L',
  		:country => 'Spain',
  		:club => 'Barcelona',
  		:manufacturer_id => manufacturer.id
  	}

  	troli = new_session_as(:troli)
  	troli.delete_tshirt new_tshirt_ruby
  end

  private

  module TshirtTestDSL
    attr_writer :name

    def add_tshirt(parameters)
      manufacturer = Manufacturer.first
      get '/admin/tshirt/new'
      assert_response :success
      assert_tag :tag => 'option', :attributes => { :value => manufacturer.id }
      post '/admin/tshirt/create', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/tshirt/index'
      page = Tshirt.all.count / 5 + 1
      get "/admin/tshirt/index/?page=#{page}"
      assert_tag :tag => 'td', :content => parameters[:tshirt][:club]
      tshirt = Tshirt.find_by_club(parameters[:tshirt][:club])
      return tshirt
    end

    def edit_tshirt(tshirt, parameters)
      get "admin/tshirt/edit?id=#{tshirt.id}"
      assert_response :success
      assert_template 'admin/tshirt/edit'
      post "/admin/tshirt/update?id=#{tshirt.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/tshirt/show'
    end

    def delete_tshirt(tshirt)
      post "/admin/tshirt/destroy?id=#{tshirt.id}"
      assert_response :redirect
      follow_redirect!
      assert_template 'admin/tshirt/index'
    end

    def show_tshirt(tshirt)
      get "/admin/tshirt/show?id=#{tshirt.id}"
      assert_response :success
      assert_template 'admin/tshirt/show'
    end

    def list_tshirts
      get 'admin/tshirt/index'
      assert_response :success
      assert_template 'admin/tshirt/index'
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(TshirtTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
