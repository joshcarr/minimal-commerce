require File.dirname(__FILE__) + '/../../test_helper'
require "admin/product_controller"

class Admin::ProductControllerTest < ActionController::TestCase

  # Replace this with your real tests.
  def setup
    
  end

  def test_index
    get :index
    assert_redirected_to :action => 'list_products'
  end

  def test_list_products

    get :list_products

    assert_response :success
    assert_template 'list_products'
  end

  def test_new_product
    get :new_product
    
    assert_response :success
    assert_template 'new_product'
  end

  def test_add_new_type
    post :add_product, :task => 'add_type', :new_type => 'Test Type'
    
    type = Type.find_by_name('Test Type')
    assert_not_nil type
    assert type.destroy
    assert_redirected_to :action => 'new_product'
  end
  
  def test_add_new_model
    post :add_product, :task => 'add_model', :new_model => 'Test Model'
    
    model = Model.find_by_name('Test Model')
    assert_not_nil model
    assert model.destroy
    assert_redirected_to :action => 'new_product'
  end

  def test_add_product
    type  = Type.new(:name => 'MP3')
    type.save!

    model = Model.new(:name => 'iPod')
    model.save!

    post :add_product, 
         :task => 'add', 
         :product => { :type_id     => type.id,
                       :model_id    => model.id,
                       :sku         => 'IP-9999',
                       :name        => 'iPod Nano',
                       :price       => '120.23',
                       :weight      => '10',
                       :quantity    => '999',
                       :description => 'some description text',
                       :image       => 'http://images.apple.com/ipod/whichipod/images/classic20070905.jpg'
                     }
    
    product = Product.find_by_sku('IP-9999')
    assert_not_nil product

    assert_redirected_to :action => 'list_products'

  end
  
  def test_view_product
    post :view_product, :id => '1'

    assert_not_nil assigns(:product)

    assert_response :success
    assert_template 'view_product'

  end
end
