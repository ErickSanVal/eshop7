require File.dirname(__FILE__) + '/../test_helper'

class CatalogTest < ActionDispatch::IntegrationTest
  fixtures :manufacturers, :tshirts

  test "browse" do
    kevin = new_session_as :kevin
    kevin.index
    kevin.second_page
    #kevin.tshirt_details 'Madrid'
    kevin.latest_tshirts
  end

  module BrowsingTestDSL
    include ERB::Util

    def index
      get 'catalog/index'
      assert_response :success
      assert_tag :tag => 'dl', :attributes => { :id => 'tshirts' },
                 :children => { :count => 5, :only => { :tag => 'dt' }}
      check_tshirt_links
    end

    def second_page
      get 'catalog/index?page=2'
      assert_response :success
      assert_template 'catalog/index'
      assert_equal Tshirt.find_by_club('Madrid'),
                   assigns(:tshirts).last
      check_tshirt_links
    end
  end

  def tshirt_details(club)
    @tshirt = Tshirt.where(:club => club).first
    get "catalog/show?id=#{@tshirt.id}"
    assert_response :success
    assert_template 'catalog/show'
    assert_tag :tag => 'h1', :content => @tshirt.title
    assert_tag :tag => 'h2', :content => "by #{@tshirt.manufacturers.map{|a| a.name}.join(", ")}"
  end

  def check_tshirt_links
    for tshirt in assigns :tshirts
      assert_tag :tag => 'a', :attributes => { :href => "/catalog/show?id=#{tshirt.id}" }
    end
  end

  def latest_tshirts
    get 'catalog/latest'
    assert_response :success
    assert_template 'catalog/latest'
    assert_tag :tag => 'dl', :attributes => { :id => 'tshirts' },
               :children => { :count => 5, :only => { :tag => 'dt' } }
    @tshirts = Tshirt.latest(5)
    @tshirts.each do |a|
      assert_tag :tag => 'dt', :content => a.club
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
