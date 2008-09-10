require File.dirname(__FILE__) + '/../test_helper'

class CartControllerTest < ActionController::TestCase

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:cart)
    assert_not_nil assigns(:orders)
  end
  
  def test_add_2_cart
    # valid product ID
    post :add_2_cart, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'index'
    
    # invalid product ID
    post :add_2_cart, :id => '100'
    assert_response :redirect
    assert_redirected_to :action => 'index'
    
    # no product ID
    post :add_2_cart
    assert_response :redirect
    assert_redirected_to :action => 'index'
  end
  
  def test_change_quantity
    post :change_quantity, :id => 1, :qty => 2
    assert_response :success
    assert_not_nil assigns(:cart)
    assert_not_nil assigns(:orders)
  end

end
