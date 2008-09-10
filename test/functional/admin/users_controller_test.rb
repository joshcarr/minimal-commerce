require File.dirname(__FILE__) + '/../../test_helper'
require "admin/users_controller"

class Admin::UsersControllerTest < ActionController::TestCase

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_user
    assert_difference('User.count') do
      post :create, :user => {:login => 'testuser', 
                              :email => 'testuser@gmail.com',
                              :password => '12345',
                              :password_confirmation => '12345'}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  def test_should_show_user
    get :show, :id => admin_users(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => admin_users(:one).id
    assert_response :success
  end

  def test_should_update_user
    put :update, :id => admin_users(:one).id, :user => {:email => 'testuser02@gmail.com',
                                                        :password => '123456',
                                                        :password_confirmation => '123456' }
    assert_redirected_to user_path(assigns(:user))
  end

  def test_should_destroy_user
    assert_difference('User.count', -1) do
      delete :destroy, :id => admin_users(:one).id
    end

    assert_redirected_to admin_users_path
  end
end
