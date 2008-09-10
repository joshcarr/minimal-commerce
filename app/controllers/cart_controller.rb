class CartController < ApplicationController
  include MinimalCart
  minimal_cart
  
  protect_from_forgery :only => [:create, :update, :destroy]
  
  def index
    @cart = get_cart
    @orders = @cart.orders.values
  end
  
  
  def add_2_cart
    begin
      pid = params[:id].to_i
      unless pid
        redirect_to :action => 'index'
        return
      end
      
      amount = params[:txtAmount].to_i
      for i in 1..amount
        add_cart pid
      end
    rescue Exception => exp
    end
    redirect_to :action => 'index'
  end
  
  def change_quantity
    begin
      pid = params[:id].to_i
      qty = params[:qty].to_i
      if( pid != nil && qty != nil )
        update_cart(pid, qty)
      end
    rescue
    end
    
    # render orders
    @cart = get_cart
    @orders = @cart.orders.values
    render :partial => 'update_orders'
  end
  
  
  # ===== check out =====
  def shipping
    @shipping = session[:shipping] == nil ? Hash.new : session[:shipping]
    @cart = get_cart
    @orders = @cart.orders.values
    @countries = CountryGroup.find :all,
                :select => 'country', :order => 'country ASC'
  end
  
  def do_shipping
    begin
      params[:shipping][:gender] = 1
      shipping = params[:shipping]
      session[:shipping] = shipping
      
      #customer = Customer.new shipping
      #customer.save!
      
      ship_to(shipping)
      redirect_to :action => 'billing'
    rescue Exception => exp
      flash[:notice] = exp
      
      @shipping = session[:shipping]
      @cart = get_cart
      @orders = @cart.orders.values
      @countries = CountryGroup.find :all,
                  :select => 'country', :order => 'country ASC'
      render :action => 'shipping'
    end
  end
  
  def billing
    @cart = get_cart
    @orders = @cart.orders.values
    @customer = session[:ship_to]
    
    @billing = session[:billing] == nil ? Hash.new : session[:billing]
  end
  
  def do_billing
    begin
      billing = params[:billing]
      session[:billing] = billing
      bill_to(session[:shipping], billing)
      
      redirect_to :action => 'checkout'
    rescue Exception => exp
      flash[:notice] = exp
      
      @cart = get_cart
      @orders = @cart.orders.values
      @customer = session[:ship_to]
      @billing = session[:billing]
      render :action => 'billing'
    end
  end
  
  def checkout
    @cart = get_cart
    @orders = @cart.orders.values
    @customer = session[:ship_to]
    @billing = session[:bill_to]
  end
  
  def do_checkout
    if check_out
      clear_cart
      session[:billing]  = nil
      session[:shipping] = nil
      session[:ship_to]  = nil
      session[:bill_to]  = nil
      redirect_to :controller => 'store', :action => 'index'
    else
      render :action => 'checkout'
    end
  end
  
end
