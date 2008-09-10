class Admin::ProductController < ApplicationController
  layout "admin"
  
  def index
    redirect_to :action => 'list_products'
  end
  
  # Show a list of all products 
  def list_products
    @types    = Type.find :all
    @models   = Model.find :all
  end


  # Show add new product form
  def new_product
    @product = McProduct.new
    @types   = Type.find :all
    @models  = Model.find :all
  end
  
  # Add new product to Database
  def add_product
    
    # Checkout the task value
    task = params[:task]

    if task == 'add_type'
       
       # Create new Type
       begin 
         addType params[:new_type]
         flash[:notice] = 'New type was successfully created.'
       rescue  Exception => err
         flash[:notice] = err
       end
       
       # Do add type and redirect to new product
       redirect_to :action => 'new_product'

    elsif task == 'add_model'

       # Create new Model
       begin 
         addModel params[:new_model]
         flash[:notice] = 'New model was successfully created.'
       rescue  Exception => err
         flash[:notice] = err
       end

       # Do add model and redirect to new product
       redirect_to :action => 'new_product'

    else # Add product to database
       
       @product = McProduct.new(params[:product])

       @product.byline      = @product.sku
       @product.create_date = DateTime::now.to_s(:db)
       @product.update_date = DateTime::now.to_s(:db)
       
       if @product.image.blank? && params[:image][:uploaded_data].size > 0

         @image = ImageUpload.new(params[:image])
         @product.image = ''
         @product.image_upload = @image

       end

       # Save product and image to db
       begin 
         @product.save!
         flash[:notice] = 'New product was successfully created.'
       rescue  Exception => err
         flash[:notice] = err
       end
      
       redirect_to :action => 'list_products'

    end
    
  end
  
  # Open product for detailed information
  def view_product
     @product = McProduct.find(params[:id])
  end

  # Open product for modifying information
  def edit_product
    @product  = McProduct.find(params[:id])
    @types    = Type.find :all
    @models   = Model.find :all
  end
  
  # Update product information from the edit form to database
  def update_product

    # Checkout the task value
    task = params[:task]

    if task == 'add_type'
       
       # Create new Type
       begin 
         addType params[:new_type]
         flash[:notice] = 'New type was successfully created.'
       rescue  Exception => err
         flash[:notice] = err
       end

       # Do add type and redirect to new product
       redirect_to :action => 'edit_product', :id => params[:id]

    elsif task == 'add_model'
       
       # Create new Model
       begin 
         addModel params[:new_model]
         flash[:notice] = 'New model was successfully created.'
       rescue  Exception => err
         flash[:notice] = err
       end

       # Do add model and redirect to new product
       redirect_to :action => 'edit_product', :id => @product
    
    elsif task == 'cancel'
       redirect_to :action => 'list_products'

    else # Update product to database
       
       # Update product info
       @product = McProduct.find(params[:id])
       
       @product.byline      = @product.sku
       @product.update_attributes!(params[:product])
       @product.update_date = DateTime::now.to_s(:db)

       # Destroy the existing image
       @product.image_upload.destroy if @product.image_upload
       
       # Update new image
       if @product.image.blank? && params[:image][:uploaded_data].size > 0

         @image = ImageUpload.new(params[:image])
         @product.image = ''
         @product.image_upload = @image

       end

       # Save product and image to database
       @product.save!

       redirect_to :action => 'view_product', :id => params[:id]

    end

  end
  
  def delete_product

    begin
      product = McProduct.find params[:id]
      product.image_upload.destroy
      product.destroy
    rescue Exception => err
      flash[:notice] = err
    else
      flash[:notice] = 'Product was deleted successfully.'
    end

    redirect_to :action => 'list_products'

  end

private

  # Add new product type to database
  def addType(type_name)
     type = Type.new
     type.name = type_name
     type.save!
  end
  
  # Add new product model to database
  def addModel(model_name)
     model = Model.new
     model.name = model_name
     model.save!
  end
  
end
