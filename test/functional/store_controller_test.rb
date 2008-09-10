require File.dirname(__FILE__) + '/../test_helper'

class StoreControllerTest < ActionController::TestCase
  
  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end
  
  def test_product
    # valid product ID
    get :product, :id => 1
    assert_response :success
    assert_template 'product'
    assert_not_nil assigns(:product)
    
    # invalid product ID
    get :product, :id => '100'
    assert_response :redirect
    assert_not_nil flash[:notice]
    assert_redirected_to :action => 'error'
    
    # no product ID
    get :product
    assert_response :redirect
    assert_redirected_to :action => 'index'
  end
  
  def test_error
    get :error
    assert_response :success
    assert_template 'error'
  end
  
end
