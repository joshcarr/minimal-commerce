class StoreController < ApplicationController
  
  def index
    # list all products
    @products = McProduct.paginate :all,
                   :page => params[:page], :per_page => 10
  end
  
  def product
    # view details of product
    begin
      pid = params[:id]
      unless pid
        redirect_to :action => 'index'
        return
      end
      
      @product = McProduct.find pid
    rescue
      flash[:notice] = 'Product not found.'
      redirect_to :action => 'error'
    end
  end
  
  
  def error
  end
end
