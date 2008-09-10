class Admin::OrderController < ApplicationController

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  protect_from_forgery :only => [] 

  layout "admin"

  def index
    
    @orders = McOrder.paginate :all, :page => params[:page], :per_page => 2

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # Show order details
  def detail
    @order = McOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end
  
  # Mark an order status
  # 1: paid ;  2: sent
  def mark
    @order = McOrder.find(params[:id])

    @order.status = 2
    @order.save!

    render :partial => 'marked_sent'
  end
  # GET /admin_orders/new
  # GET /admin_orders/new.xml
  #def new
  #  @order = Order.new

  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.xml  { render :xml => @order }
  #  end
  #end

  # GET /admin_orders/1/edit
  #def edit
  #  @order = Admin::Order.find(params[:id])
  #end

  # POST /admin_orders
  # POST /admin_orders.xml
  #def create
  #  @order = Admin::Order.new(params[:order])

  #  respond_to do |format|
  #    if @order.save
  #      flash[:notice] = 'Admin::Order was successfully created.'
  #      format.html { redirect_to(@order) }
  #      format.xml  { render :xml => @order, :status => :created, :location => @order }
  #    else
  #      format.html { render :action => "new" }
  #      format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

  # PUT /admin_orders/1
  # PUT /admin_orders/1.xml
  #def update
  #  @order = Admin::Order.find(params[:id])

  #  respond_to do |format|
  #    if @order.update_attributes(params[:order])
  #      flash[:notice] = 'Admin::Order was successfully updated.'
  #      format.html { redirect_to(@order) }
  #      format.xml  { head :ok }
  #    else
  #      format.html { render :action => "edit" }
  #      format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
  #    end
 #   end
 # end

  # DELETE /admin_orders/1
  # DELETE /admin_orders/1.xml
 # def destroy
 #   @order = Admin::Order.find(params[:id])
  #  @order.destroy

 #   respond_to do |format|
 #     format.html { redirect_to(admin_orders_url) }
 #     format.xml  { head :ok }
 #   end
 # end
end
