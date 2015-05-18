require File.dirname(__FILE__) + '/../test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  def setup
    User.create(:name => 'Kevin Valle', :login => 'kevin', :email => 'kevin@emporium.com',
                :password => 'valle', :password_confirmation => 'valle')
  end

  test "successful_login" do
    kevin = new_session_as(:kevin)
    kevin.tries_to_go_to_admin
    kevin.logs_in_succesfully("kevin", "valle")
  end

  test "failed_login" do
    troli = new_session_as(:troli)
    troli.tries_to_go_to_admin
    troli.fails_login("troli", "miguel")
  end

  private

  module BrowsingTestDSL
    include ERB::Util
    attr_writer :name

    def tries_to_go_to_admin
      get '/admin/tshirt/new'
      assert_response :redirect
      assert_redirected_to '/user_sessions/new'
    end

    def logs_in_succesfully(login, password)
      post_login(login, password)
      assert_response :redirect
      assert_redirected_to '/admin/tshirt/new'
    end

    def fails_login(login, password)
      post_login(login, password)
      assert_response :success
      assert_template 'user_sessions/new'
      assert_tag :tag => 'div', :attributes => { :id => 'errorExplanation' }
      assert_tag :tag => 'li', :content => 'You must be logged out to access this page.'
    end

    private

    def post_login(login, password)
      post '/user_sessions/create', :user_session => { :login => login, :password => password }
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
