require 'test_helper'

class Admin::TshirtControllerTest < ActionController::TestCase
  
  test "new" do
    get :new  
    assert_template 'admin/tshirt/new'  
    assert_tag 'h1', :content => 'Create new tshirt'  
  end

  test "create" do
    get :new    
    assert_template 'admin/tshirt/new'
    assert_difference(Tshirt, :count) do
      post :create, :tshirt => {:manufacturer_id => 1, :size => "L", :country => "Spain", :club => "Madrid", :price => 20}
      assert_response :redirect
      assert_redirected_to :action => 'index'      
    end
    assert_equal 'tshirt Madrid was succesfully created.', flash[:notice]
  end

  test "failing_create" do
    assert_no_difference(Tshirt, :count) do
      post :create, :tshirt => {:size => 'L'}
      assert_response :success
      assert_template 'admin/tshirt/new'
      assert_tag :tag => 'div', :attributes => {:class => 'field_with_errors'}
    end
  end
end
