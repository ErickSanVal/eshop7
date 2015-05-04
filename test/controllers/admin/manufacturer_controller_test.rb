require File.dirname(__FILE__) + '/../../test_helper'  

class Admin::ManufacturerControllerTest < ActionController::TestCase
  fixtures :manufacturers

  test "new" do
    get :new  
    assert_template 'admin/manufacturer/new'  
    assert_tag 'h1', :content => 'Create new manufacturer'  
    assert_tag 'form', :attributes => { :action => '/admin/manufacturer/create' }   
  end  

  test "create" do
    get :new    
    assert_template 'admin/manufacturer/new'
    assert_difference(Manufacturer, :count) do
      post :create, :manufacturer => {:name => 'Kevinva', :telephone => '123456789'}
      assert_response :redirect
      assert_redirected_to :action => 'index'      
    end
    assert_equal 'Manufacturer Kevinva was succesfully created.', flash[:notice]
  end

  test "failing_create" do
    assert_no_difference(Manufacturer, :count) do
      post :create, :manufacturer => {:name => 'Kevinva'}
      assert_response :success
      assert_template 'admin/manufacturer/new'
      assert_tag :tag => 'div', :attributes => {:class => 'field_with_errors'}
    end
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag :tag => 'input', :attributes => { :name => 'manufacturer[name]', :value => 'Kevinva' }
    assert_tag :tag => 'input', :attributes => { :name => 'manufacturer[telephone]', :value => '123456789' }
  end

  test "update" do
    post :update, :id => 1, :manufacturer => { :name => 'OtroNombre', :telephone => '123456789' }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'OtroNombre', Manufacturer.find(1).name
  end

  test "test_destroy" do
    assert_difference(Manufacturer, :count, -1) do
      post :destroy, :id => 1
      assert_equal flash[:notice], 'Succesfully deleted manufacturer Kevinva.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_tag :tag => 'div', :attributes => {:id => 'notice'},
        :content => 'Succesfully deleted manufacturer Kevinva.'
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/manufacturer/show'
    assert_equal 'Kevinva', assigns(:manufacturer).name
    assert_equal '123456789', assigns(:manufacturer).telephone
    assert_tag "h1", :content => Manufacturer.find(1).name
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag :tag => 'table', :children => { :count => Manufacturer.count + 1, :only => {:tag => 'tr'} }
    Manufacturer.find_each do |a|
      assert_tag :tag => 'td', :content => a.name
    end
  end
end
