require 'test_helper'

class Admin::OrderControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def test_index
    get :index

    assert_response :success
    assert_template 'index'
  end
  
  def test_detail
    post :detail, :id => '1'
    
    assert_not_nil assigns(:order)

    assert_response :success
    assert_template 'detail'
  end
  
  def test_mark
    order = McOrder.find(1);
    assert_equal 0, order.status

    post :mark, :id => '1'
    
  end

end
